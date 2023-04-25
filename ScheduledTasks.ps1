$tasksToDelete = @'
\Microsoft\XblGameSave\XblGameSaveTask
\Microsoft\Windows\DiskDiagnostic\Microsoft-Windows-DiskDiagnosticDataCollector
\Microsoft\Windows\Application Experience\Microsoft Compatibility Appraiser
\Microsoft\Windows\Application Experience\StartupAppTask
\Microsoft\Windows\Windows Defender\Windows Defender Cache Maintenance
\Microsoft\Windows\Windows Defender\Windows Defender Cleanup
\Microsoft\Windows\Windows Defender\Windows Defender Scheduled Scan
\Microsoft\Windows\Windows Defender\Windows Defender Verification
\Microsoft\Windows\Windows Error Reporting\QueueReporting
\Microsoft\Windows\Diagnosis\RecommendedTroubleshootingScanner
\Microsoft\Windows\Feedback\Siuf\DmClientOnScenarioDownload
\Microsoft\Windows\Feedback\Siuf\DmClient
\Microsoft\Windows\RetailDemo\CleanupOfflineContent
\Microsoft\Windows\Windows Error Reporting\QueueReporting
'@ -split '\r?\n'

foreach ($task in $tasksToDelete) {
  if (-not (Test-Path Registry::"$reg_software\Microsoft\Windows NT\CurrentVersion\Schedule\TaskCache\Tree$task")) {
    continue
  }
  # 似乎这里引用到了
  $id = (Get-ItemProperty Registry::"$reg_software\Microsoft\Windows NT\CurrentVersion\Schedule\TaskCache\Tree$task").Id
  & $wsudo -T REG DELETE "$reg_software\Microsoft\Windows NT\CurrentVersion\Schedule\TaskCache\Plain\$id\\" /f
  & $wsudo -T REG DELETE "$reg_software\Microsoft\Windows NT\CurrentVersion\Schedule\TaskCache\Tasks\$id\\" /f
  & $wsudo -T REG DELETE "$reg_software\Microsoft\Windows NT\CurrentVersion\Schedule\TaskCache\Tree$task" /f
  Write-Host $task
}

[gc]::Collect()
