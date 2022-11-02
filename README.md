# Controlling Taskbar Button Animations

On the Windows platform, beginning with Windows 7 the shell introduced taskbar button animations.

Taskbar buttons can show progress state, an indeterminate progress bar, and colors for interruptions (orange) and error (red).

Wouldn't it be nice to use these visual clues for PowerShell scripts as well? While your script is running, its taskbar button would then quickly provide a visual clue on progress or error state.

With this module, you can add these things easily for *Windows PowerShell* and *PowerShell* - as long as you run your scripts on the Windows platform.

## Installing Module

Run this to download the module from the [PowerShell Gallery](https://www.powershellgallery.com/packages/PsoProgressButton) and install it:

```powershell
Install-Module -Name PsoProgressButton -Scope CurrentUser
```

You will need to do this separately for Windows PowerShell and PowerShell unless you use `-Scope AllUsers` (in which case both PowerShell versions share the same module location).

## Showing Progress Indicator

To show a progress indicator inside the taskbar button that represents your running PowerShell script, set a value between 0 and 100. This sets the progress bar to 50%

```powershell
Set-PsoProgressButtonValue -CurrentValue 50
```


## Turning Off Progress Indicator

To hide the progress indicator and revert button state to normal, change button state like this:

```powershell
Set-PsoButtonProgressState -ProgressState NoProgress
```

## Indeterminate Progressbar

For situations where you don't know the exact progress and would like to just show a "busy" indicator, turn on the indeterminate progress bar:

```powershell
Set-PsoButtonProgressState -ProgressState Indeterminate
```

## Indicating Error State

If something went wrong and you would like to indicate error state, run this:

```powershell
Set-PsoButtonProgressState -ProgressState Error
```

The width of the progress bar depends on its current value. For indeterminate progress bars, only a small column may be shown. You can always manually change the progress bar value to show "more red":

```powershell
Set-PsoProgressButtonValue -CurrentValue 100
```

## Indicating Interruption

If your script was interrupted but might be able to resume, i.e. because it is waiting for a user interaction, run this:

```powershell
Set-PsoButtonProgressState -ProgressState Paused
```

## Back to Normal

To revert any visual clues and change the takbar button appearance back to normal, run this:

```powershell
Set-PsoProgressButtonValue -CurrentValue 0
Set-PsoButtonProgressState -ProgressState NoProgress
```

## Important Notes

These commands work for both **Windows PowerShell** and **PowerShell**, however they only work when running your scripts on the **Windows Operating System**.
