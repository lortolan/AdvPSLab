#ModuleBMLog.psm1
Set-StrictMode -Version 3

function Write-Log
{
    [CmdletBinding(DefaultParameterSetName='Set2', 
                  PositionalBinding=$true,
                  HelpUri = 'http://www.microsoft.com/')]
    [OutputType([String])]
    Param
    (
        [Parameter(Mandatory, ParameterSetName='Set1')]
        [Switch]$Header,

        [Parameter(Mandatory, ParameterSetName='Set2', Position = 0)]
        [ValidateSet("Information", "Warning", "Error")]
        [String]$Category,

        [Parameter(Mandatory, ParameterSetName='Set2', Position = 1,ValueFromPipeline)]
        [String]$Message,

        [Switch]$ToScreen,

        [Parameter(Mandatory, ParameterSetName='Set3')]
        [Switch]$Footer,

        [Parameter(Mandatory)]
        [String]$FilePath
    )
    
    $PSDefaultParameterValues['*:Encoding'] = 'utf8'
    [String] $CurrentDate = Get-Date -Format 'yyyy-MM-dd HH:mm:ss'
    [Char] $Delimiter = ';'
    [Hashtable] $HashCat = @{
                    Information = 'Cyan'
                    Warning = 'Yellow'
                    Error = 'Red'
                }

    Switch ($PSCmdlet.ParameterSetName) {
        'Set1' { # Implémentation du Header 

              [String] $head = 
@'
+----------------------------------------------------------------------------------------+
Script fullname          : {0}
When generated           : {1}
Current user             : {2}
Current computer         : {3}
Operating System         : {4}
OS Architecture          : {5}
+----------------------------------------------------------------------------------------+  

'@ -f $PSCommandPath, 
      (Get-Date -Format 'yyyy-MM-dd HH:mm:ss'),
      "$env:COMPUTERNAME\$env:username",
      $env:COMPUTERNAME,
      (Get-CimInstance -ClassName Win32_OperatingSystem).Caption,
      (Get-CimInstance -ClassName Win32_OperatingSystem).OSArchitecture

           $head | Out-File -Filepath $FilePath
           if ($ToScreen) {Write-Host $head}     
        }
        'Set2' { 
            [String] $MessageFormatted = '{0}{3}{1}{3}{2}' -f $CurrentDate, $Category, $Message, $Delimiter
            $MessageFormatted | Out-File -FilePath $FilePath -Append
            if ($ToScreen) {Write-host $MessageFormatted -ForegroundColor $HashCat[$Category]}
        }
        'Set3' { 
            #On récupère la date de création dans le fichier log généré 
            [String[]] $file = Get-Content $FilePath
            if($file | where-object {$_ -match 'When generated\s+:\s{1}(?<Date>.+)'}){
                $StartDate = $matches.Date -as [datetime]
            }
            [Timespan] $Interval = (Get-Date) - $StartDate
            [String] $Foot =
@'

+----------------------------------------------------------------------------------------+
End time                 : {0}
Total duration (seconds) : {1}
Total duration (minutes) : {2}
+----------------------------------------------------------------------------------------+
'@ -f $CurrentDate, [int]$Interval.TotalSeconds,[int]$Interval.TotalMinutes

            $Foot | Out-File -Filepath $FilePath -Append
            if ($ToScreen) {Write-Host $Foot}    
        } 
    } # End Switch
}

class LogEntry
{
   [datetime] $Date
   [string] $Category
   [string] $Message

   LogEntry ([datetime] $d, [string]$c, [string]$m)
   {
       $this.date = $d
       $this.category = $c   
       $this.message = $m 
   }
}
#Fonction ConvertFrom-Log avec Classobject + constructeur
function ConvertFrom-Log
{
    Param
    (
        [Parameter(Mandatory,
                   ValueFromPipeline
                   )]
        [ValidateScript({Test-Path $_})]
        [string]$Logpath

    )
    [string[]]$Text = (Get-Content -Path $Logpath) -match '^\d'
    foreach($line in $Text){
         $LogContent = $line.Split(';')
         [LogEntry]::new($LogContent[0] -as [datetime],$LogContent[1],$LogContent[2])
    }
}
