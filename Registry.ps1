# Invoked by `Debloat.ps1`
$reg_software = "HKLM\debloat-" + (New-Guid).Guid
$reg_system = "HKLM\debloat-" + (New-Guid).Guid
$reg_default = "HKLM\debloat-" + (New-Guid).Guid
$reg_user = "HKLM\debloat-" + (New-Guid).Guid

REG LOAD $reg_software "$wim_mount_dir\Windows\System32\Config\Software"
REG LOAD $reg_system "$wim_mount_dir\Windows\System32\Config\SYSTEM"
REG LOAD $reg_default "$wim_mount_dir\Windows\System32\Config\DEFAULT"
REG LOAD $reg_user "$wim_mount_dir\Users\Default\NTUSER.DAT"

<#
  These tweaks base on related Group Policy, see:
  https://www.microsoft.com/en-us/download/104593
  https://www.microsoft.com/en-us/download/104677
#>

# @REM 限制 Internet 通信
REG ADD "$reg_software\Policies\Microsoft\InternetManagement" /v "RestrictCommunication" /t REG_DWORD /d "1" /f
REG ADD "$reg_software\Microsoft\Windows\CurrentVersion\Policies\Explorer" /v "NoPublishingWizard" /t REG_DWORD /d "1" /f
REG ADD "$reg_software\Microsoft\Windows\CurrentVersion\Policies\Explorer" /v "NoWebServices" /t REG_DWORD /d "1" /f
REG ADD "$reg_software\Policies\Microsoft\Windows NT\CurrentVersion\Software Protection Platform" /v "NoGenTicket" /t REG_DWORD /d "1" /f
REG ADD "$reg_software\Policies\Microsoft\Windows NT\CurrentVersion\Software Protection Platform" /v "AllowWindowsEntitlementReactivation" /t REG_DWORD /d "1" /f
REG ADD "$reg_software\Microsoft\Windows\CurrentVersion\Policies\Explorer" /v "NoOnlinePrintsWizard" /t REG_DWORD /d "1" /f
REG ADD "$reg_software\Policies\Microsoft\Messenger\Client" /v "CEIP" /t REG_DWORD /d "2" /f
REG ADD "$reg_software\Policies\Microsoft\PCHealth\HelpSvc" /v "Headlines" /t REG_DWORD /d "0" /f
REG ADD "$reg_software\Policies\Microsoft\PCHealth\HelpSvc" /v "MicrosoftKBSearch" /t REG_DWORD /d "0" /f
REG ADD "$reg_software\Policies\Microsoft\PCHealth\ErrorReporting" /v "DoReport" /t REG_DWORD /d "0" /f
REG ADD "$reg_software\Policies\Microsoft\Windows\Windows Error Reporting" /v "Disabled" /t REG_DWORD /d "1" /f
REG ADD "$reg_software\Microsoft\Windows\CurrentVersion\Policies\Explorer" /v "NoInternetOpenWith" /t REG_DWORD /d "1" /f
REG ADD "$reg_software\Policies\Microsoft\Windows\Internet Connection Wizard" /v "ExitOnMSICW" /t REG_DWORD /d "1" /f
REG ADD "$reg_software\Policies\Microsoft\EventViewer" /v "MicrosoftEventVwrDisableLinks" /t REG_DWORD /d "1" /f
REG ADD "$reg_software\Policies\Microsoft\SystemCertificates\AuthRoot" /v "DisableRootAutoUpdate" /t REG_DWORD /d "1" /f
REG ADD "$reg_software\Policies\Microsoft\Windows\Registration Wizard Control" /v "NoRegistration" /t REG_DWORD /d "1" /f
REG ADD "$reg_software\Policies\Microsoft\SearchCompanion" /v "DisableContentFileUpdates" /t REG_DWORD /d "1" /f
REG ADD "$reg_software\Policies\Microsoft\Windows NT\Printers" /v "DisableHTTPPrinting" /t REG_DWORD /d "1" /f
REG ADD "$reg_software\Policies\Microsoft\Windows NT\Printers" /v "DisableWebPnPDownload" /t REG_DWORD /d "1" /f
REG ADD "$reg_software\Policies\Microsoft\Windows\DriverSearching" /v "DontSearchWindowsUpdate" /t REG_DWORD /d "1" /f
REG ADD "$reg_software\Policies\Microsoft\Windows\WindowsUpdate" /v "DisableWindowsUpdateAccess" /t REG_DWORD /d "1" /f
REG ADD "$reg_software\Policies\Microsoft\Windows\HandwritingErrorReports" /v "PreventHandwritingErrorReports" /t REG_DWORD /d "1" /f
REG ADD "$reg_software\Policies\Microsoft\Windows\TabletPC" /v "PreventHandwritingDataSharing" /t REG_DWORD /d "1" /f
REG ADD "$reg_software\Policies\Microsoft\WindowsMovieMaker" /v "WebHelp" /t REG_DWORD /d "1" /f
REG ADD "$reg_software\Policies\Microsoft\WindowsMovieMaker" /v "CodecDownload" /t REG_DWORD /d "1" /f
REG ADD "$reg_software\Policies\Microsoft\WindowsMovieMaker" /v "WebPublish" /t REG_DWORD /d "1" /f
REG ADD "$reg_software\Policies\Microsoft\SQMClient\Windows" /v "CEIPEnable" /t REG_DWORD /d "0" /f
REG ADD "$reg_software\Policies\Microsoft\Windows\NetworkConnectivityStatusIndicator" /v "NoActiveProbe" /t REG_DWORD /d "1" /f

# @REM 配置自动更新
REG ADD "$reg_software\Policies\Microsoft\Windows\WindowsUpdate\AU" /v "NoAutoUpdate" /t REG_DWORD /d "1" /f

# @REM 隐藏 Windows 安全系统托盘
REG ADD "$reg_software\Policies\Microsoft\Windows Defender Security Center\Systray" /v "HideSystray" /t REG_DWORD /d "1" /f

# @REM 关闭 Windows 移动中心
REG ADD "$reg_software\Microsoft\Windows\CurrentVersion\Policies\MobilityCenter" /v "NoMobilityCenter" /t REG_DWORD /d "1" /f

# @REM 允许使用 Windows Ink 工作区
REG ADD "$reg_software\Policies\Microsoft\WindowsInkWorkspace" /v "AllowWindowsInkWorkspace" /t REG_DWORD /d "0" /f

# @REM 允许使用 Windows Ink 工作区中建议的应用
REG ADD "$reg_software\Policies\Microsoft\WindowsInkWorkspace" /v "AllowSuggestedAppsInWindowsInkWorkspace" /t REG_DWORD /d "0" /f

# @REM 启用或禁用 Windows 游戏录制和广播
REG ADD "$reg_software\Policies\Microsoft\Windows\GameDVR" /v "AllowGameDVR" /t REG_DWORD /d "0" /f

# @REM 禁用 Windows 错误报告
REG ADD "$reg_software\Policies\Microsoft\Windows\Windows Error Reporting" /v "Disabled" /t REG_DWORD /d "1" /f

# @REM 禁用日志记录
REG ADD "$reg_software\Policies\Microsoft\Windows\Windows Error Reporting" /v "LoggingDisabled" /t REG_DWORD /d "1" /f

# @REM 配置 Windows Defender SmartScreen
REG ADD "$reg_software\Policies\Microsoft\Windows\System" /v "EnableSmartScreen" /t REG_DWORD /d "0" /f

# @REM 关闭 Windows 日历
REG ADD "$reg_software\Microsoft\Windows\CurrentVersion\Policies\Windows" /v "TurnOffWinCal" /t REG_DWORD /d "1" /f

# @REM 关闭 Tablet PC 触笔练习
REG ADD "$reg_software\Policies\Microsoft\PenTraining" /v "DisablePenTraining" /t REG_DWORD /d "1" /f

# @REM 不同步
REG ADD "$reg_software\Policies\Microsoft\Windows\SettingSync" /v "DisableSettingSync" /t REG_DWORD /d "2" /f
REG ADD "$reg_software\Policies\Microsoft\Windows\SettingSync" /v "DisableSettingSyncUserOverride" /t REG_DWORD /d "1" /f

# @REM 允许语音数据的自动更新
REG ADD "$reg_software\Policies\Microsoft\Speech" /v "AllowSpeechModelUpdate" /t REG_DWORD /d "0" /f

# @REM 阻止客户端对索引进行远程查询
REG ADD "$reg_software\Policies\Microsoft\Windows\Windows Search" /v "PreventRemoteQueries" /t REG_DWORD /d "1" /f

# @REM 请勿在 Web 中搜索或在“搜索”中显示 Web 结果
REG ADD "$reg_software\Policies\Microsoft\Windows\Windows Search" /v "ConnectedSearchUseWeb" /t REG_DWORD /d "0" /f

# @REM 不允许 Web 搜索
REG ADD "$reg_software\Policies\Microsoft\Windows\Windows Search" /v "DisableWebSearch" /t REG_DWORD /d "1" /f

# @REM 允许使用 Cortana
REG ADD "$reg_software\Policies\Microsoft\Windows\Windows Search" /v "AllowCortana" /t REG_DWORD /d "0" /f

# @REM 允许云搜索
REG ADD "$reg_software\Policies\Microsoft\Windows\Windows Search" /v "AllowCloudSearch" /t REG_DWORD /d "0" /f

# @REM 允许搜索要点
REG ADD "$reg_software\Policies\Microsoft\Windows\Windows Search" /v "EnableDynamicContentInWSB" /t REG_DWORD /d "0" /f

# @REM 关闭 Windows 演示文稿设置
REG ADD "$reg_software\Microsoft\Windows\CurrentVersion\Policies\PresentationSettings" /v "NoPresentationSettings" /t REG_DWORD /d "1" /f

# @REM 关闭活动帮助
REG ADD "$reg_software\Policies\Microsoft\Assistance\Client\1.0" /v "NoActiveHelp" /t REG_DWORD /d "1" /f

# @REM 禁止使用 OneDrive 进行文件存储
REG ADD "$reg_software\Policies\Microsoft\Windows\OneDrive" /v "DisableFileSyncNGSC" /t REG_DWORD /d "1" /f

# @REM 在任务栏上启用资讯和兴趣
REG ADD "$reg_software\Policies\Microsoft\Windows\Windows Feeds" /v "EnableFeeds" /t REG_DWORD /d "0" /f

# @REM 在托管模式下打开 Microsoft Defender 应用程序防护
REG ADD "$reg_software\Policies\Microsoft\AppHVSI" /v "AllowAppHVSI" /t REG_DWORD /d "0" /f
REG ADD "$reg_software\Policies\Microsoft\AppHVSI" /v "AllowAppHVSI_ProviderSet" /t REG_DWORD /d "0" /f

# @REM 关闭实时保护
REG ADD "$reg_software\Policies\Microsoft\Windows Defender\Real-Time Protection" /v "DisableRealtimeMonitoring" /t REG_DWORD /d "1" /f

# @REM 关闭 Microsoft Defender 防病毒
REG ADD "$reg_software\Policies\Microsoft\Windows Defender" /v "DisableAntiSpyware" /t REG_DWORD /d "1" /f

# @REM 关闭传感器
REG ADD "$reg_software\Policies\Microsoft\Windows\LocationAndSensors" /v "DisableSensors" /t REG_DWORD /d "1" /f

# @REM 关闭位置
REG ADD "$reg_software\Policies\Microsoft\Windows\LocationAndSensors" /v "DisableLocation" /t REG_DWORD /d "1" /f

# @REM 关闭位置脚本
REG ADD "$reg_software\Policies\Microsoft\Windows\LocationAndSensors" /v "DisableLocationScripting" /t REG_DWORD /d "1" /f

# @REM 禁止将自动微调数据保存到文件
REG ADD "$reg_user\software\policies\microsoft\ime\imejp" /v "SaveAutoTuneDataToFile" /t REG_DWORD /d "0" /f

# @REM 禁用基于历史的预测输入
REG ADD "$reg_user\software\policies\microsoft\ime\imejp" /v "UseHistorybasedPredictiveInput" /t REG_DWORD /d "0" /f

# @REM 禁用 Internet 搜索集成
REG ADD "$reg_user\software\policies\microsoft\ime\shared" /v "SearchPlugin" /t REG_DWORD /d "0" /f

# @REM 打开动态贴纸
REG ADD "$reg_user\Software\Policies\Microsoft\InputMethod\Settings\CHS" /v "EnableLiveSticker" /t REG_DWORD /d "0" /f

# @REM 打开词典更新
REG ADD "$reg_user\Software\Policies\Microsoft\InputMethod\Settings\CHS" /v "Enable Lexicon Update" /t REG_DWORD /d "0" /f

# @REM 启用/关闭“查找我的设备”
REG ADD "$reg_software\Policies\Microsoft\FindMyDevice" /v "AllowFindMyDevice" /t REG_DWORD /d "0" /f

# @REM 关闭文件历史记录
REG ADD "$reg_software\Policies\Microsoft\Windows\FileHistory" /v "Disabled" /t REG_DWORD /d "1" /f

# @REM 关闭缩略图显示并仅显示图标。
# REG ADD "$reg_user\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer" /v "DisableThumbnails" /t REG_DWORD /d "1" /f
# 这会造成搜索中，设置的图标显示不正常

# @REM 删除 CD 刻录功能
REG ADD "$reg_user\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer" /v "NoCDBurning" /t REG_DWORD /d "1" /f

# @REM 不显示“安装了新应用程序”通知
REG ADD "$reg_software\Policies\Microsoft\Windows\Explorer" /v "NoNewAppAlert" /t REG_DWORD /d "1" /f

# @REM 切换对会员版本的用户控制
REG ADD "$reg_software\Policies\Microsoft\Windows\PreviewBuilds" /v "AllowBuildPreview" /t REG_DWORD /d "0" /f

# @REM 配置遥测选择加入设置用户界面。
REG ADD "$reg_software\Policies\Microsoft\Windows\DataCollection" /v "DisableTelemetryOptInSettingsUx" /t REG_DWORD /d "0" /f

# @REM 配置遥测选择加入更改通知。
REG ADD "$reg_software\Policies\Microsoft\Windows\DataCollection" /v "DisableTelemetryOptInChangeNotification" /t REG_DWORD /d "0" /f

# @REM 不显示反馈通知
REG ADD "$reg_software\Policies\Microsoft\Windows\DataCollection" /v "DoNotShowFeedbackNotifications" /t REG_DWORD /d "1" /f

# @REM 配置浏览数据集合以便桌面分析使用
REG ADD "$reg_software\Microsoft\Windows\CurrentVersion\Policies\DataCollection" /v "MicrosoftEdgeDataOptIn" /t REG_DWORD /d "0" /f
REG ADD "$reg_software\Microsoft\Windows\CurrentVersion\Policies\DataCollection" /v "AllowTelemetry" /t REG_DWORD /d "0" /f

# @REM 关闭 Microsoft 用户体验
REG ADD "$reg_software\Policies\Microsoft\Windows\CloudContent" /v "DisableWindowsConsumerFeatures" /t REG_DWORD /d "1" /f

# @REM 不显示 Windows 使用技巧
REG ADD "$reg_software\Policies\Microsoft\Windows\CloudContent" /v "DisableSoftLanding" /t REG_DWORD /d "1" /f

# @REM 关闭云优化内容
REG ADD "$reg_software\Policies\Microsoft\Windows\CloudContent" /v "DisableCloudOptimizedContent" /t REG_DWORD /d "1" /f

# @REM 在锁屏界面上配置 Windows 聚焦
REG ADD "$reg_user\Software\Policies\Microsoft\Windows\CloudContent" /v "ConfigureWindowsSpotlight" /t REG_DWORD /d "2" /f

# @REM 关闭所有 Windows 聚焦功能
REG ADD "$reg_user\Software\Policies\Microsoft\Windows\CloudContent" /v "DisableWindowsSpotlightFeatures" /t REG_DWORD /d "1" /f

# @REM 不要将诊断数据用于量身定制的体验
REG ADD "$reg_user\Software\Policies\Microsoft\Windows\CloudContent" /v "DisableTailoredExperiencesWithDiagnosticData" /t REG_DWORD /d "1" /f

# @REM 请勿在 Windows 聚焦中建议第三方内容
REG ADD "$reg_user\Software\Policies\Microsoft\Windows\CloudContent" /v "DisableThirdPartySuggestions" /t REG_DWORD /d "1" /f

# @REM 在操作中心关闭 Windows 聚焦
REG ADD "$reg_user\Software\Policies\Microsoft\Windows\CloudContent" /v "DisableWindowsSpotlightOnActionCenter" /t REG_DWORD /d "1" /f

# @REM 在“设置”中关闭 Windows 聚焦
REG ADD "$reg_user\Software\Policies\Microsoft\Windows\CloudContent" /v "DisableWindowsSpotlightOnSettings" /t REG_DWORD /d "1" /f

# @REM 关闭“欢迎使用 Windows”体验
REG ADD "$reg_user\Software\Policies\Microsoft\Windows\CloudContent" /v "DisableWindowsSpotlightWindowsWelcomeExperience" /t REG_DWORD /d "1" /f

# @REM 允许使用生物特征
REG ADD "$reg_software\Policies\Microsoft\Biometrics" /v "Enabled" /t REG_DWORD /d "0" /f

# @REM 关闭自动播放
REG ADD "$reg_software\Microsoft\Windows\CurrentVersion\Policies\Explorer" /v "NoDriveTypeAutoRun" /t REG_DWORD /d "255" /f

# @REM 文件附件中不保留区域信息
REG ADD "$reg_user\Software\Microsoft\Windows\CurrentVersion\Policies\Attachments" /v "SaveZoneInformation" /t REG_DWORD /d "1" /f

# @REM 阻止访问 16 位应用程序
REG ADD "$reg_software\Policies\Microsoft\Windows\AppCompat" /v "VDMDisallowed" /t REG_DWORD /d "1" /f

# @REM 删除程序兼容性属性页
REG ADD "$reg_software\Policies\Microsoft\Windows\AppCompat" /v "DisablePropPage" /t REG_DWORD /d "1" /f

# @REM 关闭应用程序遥测
REG ADD "$reg_software\Policies\Microsoft\Windows\AppCompat" /v "AITEnable" /t REG_DWORD /d "0" /f

# @REM 关闭 SwitchBack 兼容性引擎
REG ADD "$reg_software\Policies\Microsoft\Windows\AppCompat" /v "SbEnable" /t REG_DWORD /d "0" /f

# @REM 关闭应用程序兼容性引擎
REG ADD "$reg_software\Policies\Microsoft\Windows\AppCompat" /v "DisableEngine" /t REG_DWORD /d "1" /f

# @REM 关闭程序兼容性助理
REG ADD "$reg_software\Policies\Microsoft\Windows\AppCompat" /v "DisablePCA" /t REG_DWORD /d "1" /f

# @REM 关闭问题步骤记录器
REG ADD "$reg_software\Policies\Microsoft\Windows\AppCompat" /v "DisableUAR" /t REG_DWORD /d "1" /f

# @REM 禁用清单收集器
REG ADD "$reg_software\Policies\Microsoft\Windows\AppCompat" /v "DisableInventory" /t REG_DWORD /d "1" /f

# @REM 允许 Microsoft 帐户为可选
REG ADD "$reg_software\Microsoft\Windows\CurrentVersion\Policies\System" /v "MSAOptional" /t REG_DWORD /d "1" /f

# @REM 允许 Windows 应用访问日历
REG ADD "$reg_software\Policies\Microsoft\Windows\AppPrivacy" /v "LetAppsAccessCalendar" /t REG_DWORD /d "2" /f

# @REM 允许 Windows 应用访问呼叫历史记录
REG ADD "$reg_software\Policies\Microsoft\Windows\AppPrivacy" /v "LetAppsAccessCallHistory" /t REG_DWORD /d "2" /f

# @REM 允许 Windows 应用访问联系人
REG ADD "$reg_software\Policies\Microsoft\Windows\AppPrivacy" /v "LetAppsAccessContacts" /t REG_DWORD /d "2" /f

# @REM 允许 Windows 应用访问电子邮件
REG ADD "$reg_software\Policies\Microsoft\Windows\AppPrivacy" /v "LetAppsAccessEmail" /t REG_DWORD /d "2" /f

# @REM 允许 Windows 应用访问位置
REG ADD "$reg_software\Policies\Microsoft\Windows\AppPrivacy" /v "LetAppsAccessLocation" /t REG_DWORD /d "2" /f

# @REM 允许 Windows 应用访问消息
REG ADD "$reg_software\Policies\Microsoft\Windows\AppPrivacy" /v "LetAppsAccessMessaging" /t REG_DWORD /d "2" /f

# @REM 允许 Windows 应用访问运动数据
REG ADD "$reg_software\Policies\Microsoft\Windows\AppPrivacy" /v "LetAppsAccessMotion" /t REG_DWORD /d "2" /f

# @REM 允许 Windows 应用访问通知
REG ADD "$reg_software\Policies\Microsoft\Windows\AppPrivacy" /v "LetAppsAccessNotifications" /t REG_DWORD /d "2" /f

# @REM 允许 Windows 应用打电话
REG ADD "$reg_software\Policies\Microsoft\Windows\AppPrivacy" /v "LetAppsAccessPhone" /t REG_DWORD /d "2" /f

# @REM 允许 Windows 应用控制无线收发器
REG ADD "$reg_software\Policies\Microsoft\Windows\AppPrivacy" /v "LetAppsAccessRadios" /t REG_DWORD /d "2" /f

# @REM 允许 Windows 应用与未配对设备通信
REG ADD "$reg_software\Policies\Microsoft\Windows\AppPrivacy" /v "LetAppsSyncWithDevices" /t REG_DWORD /d "2" /f

# @REM 允许 Windows 应用访问任务
REG ADD "$reg_software\Policies\Microsoft\Windows\AppPrivacy" /v "LetAppsAccessTasks" /t REG_DWORD /d "2" /f

# @REM 允许 Windows 应用在后台运行
REG ADD "$reg_software\Policies\Microsoft\Windows\AppPrivacy" /v "LetAppsRunInBackground" /t REG_DWORD /d "2" /f

# @REM 让 Windows 应用访问与其他应用有关的诊断信息
REG ADD "$reg_software\Policies\Microsoft\Windows\AppPrivacy" /v "LetAppsGetDiagnosticInfo" /t REG_DWORD /d "2" /f

# @REM 让 Windows 应用访问眼睛跟踪器设备
REG ADD "$reg_software\Policies\Microsoft\Windows\AppPrivacy" /v "LetAppsAccessGazeInput" /t REG_DWORD /d "2" /f

# @REM 允许通过语音激活 Windows 应用
REG ADD "$reg_software\Policies\Microsoft\Windows\AppPrivacy" /v "LetAppsActivateWithVoice" /t REG_DWORD /d "2" /f

# @REM 在系统锁定时，允许使用语音方式激活 Windows 应用
REG ADD "$reg_software\Policies\Microsoft\Windows\AppPrivacy" /v "LetAppsActivateWithVoiceAboveLock" /t REG_DWORD /d "2" /f

# @REM 允许 Windows 应用在后台运行时访问用户移动
REG ADD "$reg_software\Policies\Microsoft\Windows\AppPrivacy" /v "LetAppsAccessBackgroundSpatialPerception" /t REG_DWORD /d "2" /f

# @REM 阻止向导运行。
REG ADD "$reg_software\Microsoft\Windows\CurrentVersion\Policies\Explorer\WAU" /v "Disabled" /t REG_DWORD /d "1" /f

# @REM 关闭播发 ID
REG ADD "$reg_software\Policies\Microsoft\Windows\AdvertisingInfo" /v "DisabledByGroupPolicy" /t REG_DWORD /d "1" /f

# @REM 配置请求的远程协助
REG ADD "$reg_software\policies\Microsoft\Windows NT\Terminal Services" /v "fAllowToGetHelp" /t REG_DWORD /d "0" /f

# @REM 配置提供远程协助
REG ADD "$reg_software\policies\Microsoft\Windows NT\Terminal Services" /v "fAllowUnsolicited" /t REG_DWORD /d "0" /f

# @REM 关闭帮助分级
REG ADD "$reg_user\Software\Policies\Microsoft\Assistance\Client\1.0" /v "NoExplicitFeedback" /t REG_DWORD /d "1" /f

# @REM 关闭帮助体验改善计划
REG ADD "$reg_user\Software\Policies\Microsoft\Assistance\Client\1.0" /v "NoImplicitFeedback" /t REG_DWORD /d "1" /f

# @REM 关闭 Windows 联机
REG ADD "$reg_user\Software\Policies\Microsoft\Assistance\Client\1.0" /v "NoOnlineAssist" /t REG_DWORD /d "1" /f

# @REM 启用 App-V 客户端
REG ADD "$reg_software\Policies\Microsoft\AppV\Client" /v "Enabled" /t REG_DWORD /d "0" /f

# @REM 不搜索文件
REG ADD "$reg_user\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer" /v "NoSearchFilesInStartMenu" /t REG_DWORD /d "1" /f

# @REM 不搜索 Internet
REG ADD "$reg_user\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer" /v "NoSearchInternetInStartMenu" /t REG_DWORD /d "1" /f

# @REM 不搜索通信
REG ADD "$reg_user\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer" /v "NoSearchCommInStartMenu" /t REG_DWORD /d "1" /f

# @REM 从“开始”菜单显示或隐藏“最常用”列表
REG ADD "$reg_software\Policies\Microsoft\Windows\Explorer" /v "ShowOrHideMostUsedApps" /t REG_DWORD /d "2" /f

# @REM 从“开始”菜单中删除常用程序列表
REG ADD "$reg_software\Microsoft\Windows\CurrentVersion\Policies\Explorer" /v "NoStartMenuMFUprogramsList" /t REG_DWORD /d "1" /f

# @REM 从“开始”菜单中删除“帮助”菜单
REG ADD "$reg_user\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer" /v "NoSMHelp" /t REG_DWORD /d "1" /f

# @REM 关闭用户跟踪
REG ADD "$reg_user\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer" /v "NoInstrumentation" /t REG_DWORD /d "1" /f

# @REM 不保留最近打开文档的历史
REG ADD "$reg_software\Microsoft\Windows\CurrentVersion\Policies\Explorer" /v "NoRecentDocsHistory" /t REG_DWORD /d "1" /f

# @REM 从“开始”菜单中删除“最近使用的项目”菜单
REG ADD "$reg_user\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer" /v "NoRecentDocsMenu" /t REG_DWORD /d "1" /f

# @REM 从任务栏中删除"人脉"栏
REG ADD "$reg_user\Software\Policies\Microsoft\Windows\Explorer" /v "HidePeopleBar" /t REG_DWORD /d "1" /f

# @REM 从“开始”菜单中删除“最近添加”列表
REG ADD "$reg_software\Policies\Microsoft\Windows\Explorer" /v "HideRecentlyAddedApps" /t REG_DWORD /d "1" /f

# @REM 关闭 Aero Shake 窗口最小化鼠标手势
REG ADD "$reg_user\Software\Policies\Microsoft\Windows\Explorer" /v "NoWindowMinimizingShortcuts" /t REG_DWORD /d "1" /f

# @REM 允许在线提示
REG ADD "$reg_software\Microsoft\Windows\CurrentVersion\Policies\Explorer" /v "AllowOnlineTips" /t REG_DWORD /d "0" /f

####

REG UNLOAD $reg_software
REG UNLOAD $reg_system
REG UNLOAD $reg_default
REG UNLOAD $reg_user
