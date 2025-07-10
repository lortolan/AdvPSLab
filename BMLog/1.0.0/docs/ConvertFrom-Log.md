---
external help file: BMLog-help.xml
Module Name: BMLog
online version:
schema: 2.0.0
---

# ConvertFrom-Log

## SYNOPSIS
Cette fonction récupère les lignes de log présentes dans un fichier  .txt ou .log pour les formatter correctement 

## SYNTAX

```
ConvertFrom-Log [-Logpath] <String> [-ProgressAction <ActionPreference>] [<CommonParameters>]
```

## DESCRIPTION
Récupère les lignes de logs dans un fichier afin de pouvoir effectuer du traitement

## EXAMPLES

### Example 1
```powershell
PS C:\> ConvertFrom-Log -LogPath 'C:\Windows\Logs\Adobe.txt'
```

## PARAMETERS

### -Logpath
Renseigne l'emplacement du fichier a traiter

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: 0
Default value: None
Accept pipeline input: True (ByValue)
Accept wildcard characters: False
```

### -ProgressAction

```yaml
Type: ActionPreference
Parameter Sets: (All)
Aliases: proga

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### System.String

## OUTPUTS

### System.Object
## NOTES

## RELATED LINKS
