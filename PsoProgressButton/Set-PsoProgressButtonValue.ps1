function Set-PsoProgressButtonValue
{
    <#
            .SYNOPSIS
            Sets the progress indicator for the taskbar button of the PowerShell host that is running this code

            .DESCRIPTION
            Provides easy access to Windows taskbar button animations. Runs on Windows OS only (Win7 or better)

            .EXAMPLE
            Set-PsoProgressButtonValue -CurrentValue 50
            Sets the progress indicator in the taskbar button to 50%

            .EXAMPLE
            Set-PsoProgressButtonValue -CurrentValue 50 -MaximumValue 200
            Sets the progress indicator in the taskbar button to 25%

            .LINK
            https://github.com/TobiasPSP/Modules.PsoProgressButton
    #>

    [Alias('Set-ProgressButton')]
    param
    (
        [Parameter(Mandatory)]
        [int]
        # current progress bar value
        $CurrentValue,
        
        [int]
        # maximum progress bar value
        $MaximumValue = 100
    )

    [PsoShell.TaskbarManager]::Instance.SetProgressValue($CurrentValue, $MaximumValue)
}