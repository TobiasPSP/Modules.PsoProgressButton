# Controlling Taskbar Button Animations

On the Windows platform, beginning with Windows 7 the shell has introduced taskbar button animations.

Taskbar buttons can show progress state, an indeterminate progress bar, and colors for interruptions (orange) and error (red).

Wouldn't it be nice to use these visual clues for PowerShell scripts as well? While your script is running, its taskbar button would then quickly provide a visual clue on progress or error state.

With this module, you can add these things easily for *Windows PowerShell* and *PowerShell* - as long as you run your scripts on the Windows platform.

**Note:** for the commands below to work, you need to run your code inside ISE, powershell.exe or pwsh.exe directly. When you run your code within a console that is embedded in **Windows Terminal** or **VSCode**, the original console window and its taskbar button is invisible and thus inaccessible. In these cases you would receive an exception stating that the window handle is invalid.

On **Windows 11**, apparently all consoles now are automatically embedded into **Windows Terminal** thus taskbar buttons are not accessible. If anyone knows how to easily run a stand-alone workhorse PowerShell script in its own console on **Windows 11**, please leave a comment. 


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
Set-PsoProgressButtonState -ProgressState NoProgress
```

## Indeterminate Progressbar

For situations where you don't know the exact progress and would like to just show a "busy" indicator, turn on the indeterminate progress bar:

```powershell
Set-PsoProgressButtonState -ProgressState Indeterminate
```

## Indicating Error State

If something went wrong and you would like to indicate error state, run this:

```powershell
Set-PsoProgressButtonState -ProgressState Error
```

The width of the progress bar depends on its current value. For indeterminate progress bars, only a small column may be shown. You can always manually change the progress bar value to show "more red":

```powershell
Set-PsoProgressButtonValue -CurrentValue 100
```

## Indicating Interruption

If your script was interrupted but might be able to resume, i.e. because it is waiting for a user interaction, run this:

```powershell
Set-PsoProgressButtonState -ProgressState Paused
```

## Back to Normal

To revert any visual clues and change the takbar button appearance back to normal, run this:

```powershell
Set-PsoProgressButtonValue -CurrentValue 0
Set-PsoProgressButtonState -ProgressState NoProgress
```

## Important Notes

These commands work for both **Windows PowerShell** and **PowerShell**, however they only work when running your scripts on the **Windows Operating System**.

The commands **will not work** when you run the console windows from within **Windows Terminal** or **VSCode**: in these cases, the original console window is hidden and its taskbar button is not visible so the window handle would always be 0, and the commands would not find the taskbar buttons to change.

