function Set-PsoProgressButtonState
{
    <#
            .SYNOPSIS
            Sets the state for the taskbar button of the PowerShell host that is running this code

            .DESCRIPTION
            Provides easy access to Windows taskbar button animations and states. Runs on Windows OS only (Win7 or better)

            .EXAMPLE
            Set-PsoButtonProgressState -ProgressState Indeterminate
            Shows an indeterminate progress bar that runs forever until turned off again

            .EXAMPLE
            Set-PsoButtonProgressState -ProgressState NoProgress
            Turns off the progress bar inside the taskbar button

            .EXAMPLE
            Set-PsoButtonProgressState -ProgressState Error
            Indicates error by switching animation to red color

            .EXAMPLE
            Set-PsoButtonProgressState -ProgressState Paused
            Indicates interruption by switching animation to orange color

            .LINK
            https://github.com/TobiasPSP/Modules.PsoProgressButton
    #>
    [Alias('Set-StateButton')]
    param
    (
        [Parameter(Mandatory)]
        [PsoShell.TaskbarProgressBarState]
        $ProgressState
    )

    [PsoShell.TaskbarManager]::Instance.SetProgressState($ProgressState)
}