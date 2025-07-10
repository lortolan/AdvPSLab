# Projet complet du module powershell BMLog permettant de créer et modifier des fichiers logs personnalisé
#A documentation de chaque fonction est aussi disponible au format markdown dans le dossier du projet.
# Version 1.0.0

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


# Write-Log

## SYNOPSIS
Cette fonction créer fichier log personnalisé en fonction de la gravité du message généré. 

## SYNTAX

### Set2 (Default)
```
Write-Log [-Category] <String> [-Message] <String> [-ToScreen] -FilePath <String>
 [-ProgressAction <ActionPreference>] [<CommonParameters>]
```

### Set1
```
Write-Log [-Header] [-ToScreen] -FilePath <String> [-ProgressAction <ActionPreference>] [<CommonParameters>]
```

### Set3
```
Write-Log [-ToScreen] [-Footer] -FilePath <String> [-ProgressAction <ActionPreference>] [<CommonParameters>]
```

## DESCRIPTION
Cette fonction créer fichier log personnalisé en fonction de la gravité du message généré.
Le Header comprend des information sur le système, l'utilisateur et la date de lancement.
Le Footer comprend la durée d'éxécution de la fonction.

## EXAMPLES

### Example 1
```powershell
PS C:\> Write-Log -Category Warning -Message "Ceci est un message d'avertissement" -FilePath 'C:\Windows\logs\log.txt' -ToScreen
```
Cette commande écrira le message renseigné via -Message directement dans le fichier log spécifié par -Filepath et affichera le message à l'écran

### Example 2
```powershell
PS C:\> Write-Log -Header -FilePath 'C:\Windows\logs\log.txt'
```
Cette commande créera une entete dans le fichier log.

## PARAMETERS

### -Category
{{ Fill Category Description }}