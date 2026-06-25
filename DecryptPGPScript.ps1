#Requires -Version 5.1
# --- GUI Setup ---
#
# This script was vibe-coded and validated by Alex Otto on 10/23/2025
# Please do not modify without consulting Alex.
# Nic Fargo would be a close second in an emergency
# David Cannon would be our last line of defense
#
#
#Requires -Version 5.1
# --- GUI Setup ---
Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing

# =============================================================================
# --- Theme Definitions ---
# =============================================================================
$LightMode = @{
    Name          = "Light"
    FormBack      = [System.Drawing.Color]::White
    Text          = [System.Drawing.Color]::Black
    GroupBoxText  = [System.Drawing.Color]::Black
    TextBoxBack   = [System.Drawing.Color]::White
    TextBoxText   = [System.Drawing.Color]::Black
    StatusBack    = [System.Drawing.ColorTranslator]::FromHtml("#F5F5F5")
    ButtonBack    = [System.Drawing.ColorTranslator]::FromHtml("#EAEAEA")
    ButtonText    = [System.Drawing.Color]::Black
    PrimaryBack   = [System.Drawing.ColorTranslator]::FromHtml("#0078D4")
    PrimaryText   = [System.Drawing.Color]::White
    MenuBack      = [System.Drawing.ColorTranslator]::FromHtml("#F0F0F0")
    MenuSelected  = [System.Drawing.ColorTranslator]::FromHtml("#DCDCDC")
}

$DarkMode = @{
    Name          = "Dark"
    FormBack      = [System.Drawing.ColorTranslator]::FromHtml("#2D2D30")
    Text          = [System.Drawing.Color]::White
    GroupBoxText  = [System.Drawing.ColorTranslator]::FromHtml("#999999")
    TextBoxBack   = [System.Drawing.ColorTranslator]::FromHtml("#3D3D3E")
    TextBoxText   = [System.Drawing.Color]::White
    StatusBack    = [System.Drawing.ColorTranslator]::FromHtml("#1E1E1E")
    ButtonBack    = [System.Drawing.ColorTranslator]::FromHtml("#3D3D3E")
    ButtonText    = [System.Drawing.Color]::White
    PrimaryBack   = [System.Drawing.ColorTranslator]::FromHtml("#28A745") # Green
    PrimaryText   = [System.Drawing.Color]::White
    MenuBack      = [System.Drawing.ColorTranslator]::FromHtml("#252526")
    MenuSelected  = [System.Drawing.ColorTranslator]::FromHtml("#3D3D3E")
}

# =============================================================================
# --- Main Form ---
# =============================================================================
$form = New-Object System.Windows.Forms.Form
$form.Text = 'GPG Tool'
$form.Size = New-Object System.Drawing.Size(800, 800) # Widened for menu
$form.StartPosition = 'CenterScreen'
$form.FormBorderStyle = 'FixedDialog'
$form.MaximizeBox = $false

# --- Side Menu Panel ---
$panelMenu = New-Object System.Windows.Forms.Panel
$panelMenu.Location = New-Object System.Drawing.Point(0, 0)
$panelMenu.Size = New-Object System.Drawing.Size(140, 800)
$form.Controls.Add($panelMenu)

# --- Content Panels (replaces TabPages) ---
$panelDecrypt = New-Object System.Windows.Forms.Panel
$panelDecrypt.Location = New-Object System.Drawing.Point(140, 0)
$panelDecrypt.Size = New-Object System.Drawing.Size(660, 800)
$form.Controls.Add($panelDecrypt)

$panelEncrypt = New-Object System.Windows.Forms.Panel
$panelEncrypt.Location = New-Object System.Drawing.Point(140, 0)
$panelEncrypt.Size = New-Object System.Drawing.Size(660, 800)
$panelEncrypt.Visible = $false # Hide by default
$form.Controls.Add($panelEncrypt)

$panelImportKey = New-Object System.Windows.Forms.Panel
$panelImportKey.Location = New-Object System.Drawing.Point(140, 0)
$panelImportKey.Size = New-Object System.Drawing.Size(660, 800)
$panelImportKey.Visible = $false # Hide by default
$form.Controls.Add($panelImportKey)

$panelOptions = New-Object System.Windows.Forms.Panel
$panelOptions.Location = New-Object System.Drawing.Point(140, 0)
$panelOptions.Size = New-Object System.Drawing.Size(660, 800)
$panelOptions.Visible = $false # Hide by default
$form.Controls.Add($panelOptions)

$panelManageKeys = New-Object System.Windows.Forms.Panel
$panelManageKeys.Location = New-Object System.Drawing.Point(140, 0)
$panelManageKeys.Size = New-Object System.Drawing.Size(660, 800)
$panelManageKeys.Visible = $false # Hide by default
$form.Controls.Add($panelManageKeys)

# --- Menu Buttons ---
$btnShowDecrypt = New-Object System.Windows.Forms.Button
$btnShowDecrypt.Text = 'Decrypt'
$btnShowDecrypt.Location = New-Object System.Drawing.Point(10, 20)
$btnShowDecrypt.Size = New-Object System.Drawing.Size(120, 45)
$panelMenu.Controls.Add($btnShowDecrypt)

$btnShowEncrypt = New-Object System.Windows.Forms.Button
$btnShowEncrypt.Text = 'Encrypt'
$btnShowEncrypt.Location = New-Object System.Drawing.Point(10, 75)
$btnShowEncrypt.Size = New-Object System.Drawing.Size(120, 45)
$panelMenu.Controls.Add($btnShowEncrypt)

$btnShowImportKey = New-Object System.Windows.Forms.Button
$btnShowImportKey.Text = 'Import Key'
$btnShowImportKey.Location = New-Object System.Drawing.Point(10, 130)
$btnShowImportKey.Size = New-Object System.Drawing.Size(120, 45)
$panelMenu.Controls.Add($btnShowImportKey)

$btnShowOptions = New-Object System.Windows.Forms.Button
$btnShowOptions.Text = 'Options'
$btnShowOptions.Location = New-Object System.Drawing.Point(10, 185)
$btnShowOptions.Size = New-Object System.Drawing.Size(120, 45)
$panelMenu.Controls.Add($btnShowOptions)

$btnShowManageKeys = New-Object System.Windows.Forms.Button
$btnShowManageKeys.Text = 'Manage Keys'
$btnShowManageKeys.Location = New-Object System.Drawing.Point(10, 240)
$btnShowManageKeys.Size = New-Object System.Drawing.Size(120, 45)
$panelMenu.Controls.Add($btnShowManageKeys)

# Global list of menu buttons and panels
$MenuButtons = @($btnShowDecrypt, $btnShowEncrypt, $btnShowImportKey, $btnShowOptions, $btnShowManageKeys)
$ContentPanels = @($panelDecrypt, $panelEncrypt, $panelImportKey, $panelOptions, $panelManageKeys)

# --- Menu Button Click Logic ---
$MenuClickHandler = {
    param($Button, $Panel)
    $ContentPanels.ForEach({ $_.Visible = $false })
    $Panel.Visible = $true
}
$btnShowDecrypt.Add_Click({ . $MenuClickHandler -Button $btnShowDecrypt -Panel $panelDecrypt })
$btnShowEncrypt.Add_Click({ . $MenuClickHandler -Button $btnShowEncrypt -Panel $panelEncrypt })
$btnShowImportKey.Add_Click({ . $MenuClickHandler -Button $btnShowImportKey -Panel $panelImportKey })
$btnShowOptions.Add_Click({ . $MenuClickHandler -Button $btnShowOptions -Panel $panelOptions })
$btnShowManageKeys.Add_Click({ . $MenuClickHandler -Button $btnShowManageKeys -Panel $panelManageKeys })


# DEFINE THE DEFAULT FOLDER FOR KEYS HERE
$keyFolderPath = "H:\GPGHelper\Keys"

# --- Helper Functions (Shared) ---
function Get-FilePath($Title, $Filter, $InitialDirectory = $null) { $dialog = New-Object System.Windows.Forms.OpenFileDialog; $dialog.Title = $Title; $dialog.Filter = $Filter; if (-not [string]::IsNullOrWhiteSpace($InitialDirectory) -and (Test-Path $InitialDirectory)) { $dialog.InitialDirectory = $InitialDirectory }; if ($dialog.ShowDialog() -eq 'OK') { return $dialog.FileName }; return $null }
function Get-SaveFilePath($Title, $Filter) { $dialog = New-Object System.Windows.Forms.SaveFileDialog; $dialog.Title = $Title; $dialog.Filter = $Filter; if ($dialog.ShowDialog() -eq 'OK') { return $dialog.FileName }; return $null }
function Get-FolderPath($Title) { $dialog = New-Object System.Windows.Forms.FolderBrowserDialog; $dialog.Description = $Title; if ($dialog.ShowDialog() -eq 'OK') { return $dialog.SelectedPath }; return $null }
function Set-ModernButtonStyle {
    param($Button, $Theme, $IsPrimary = $false, $IsMenu = $false)
    $Button.FlatStyle = 'Flat'; $Button.FlatAppearance.BorderSize = 0; $Button.Cursor = 'Hand'
    if ($IsMenu) { $Button.BackColor = $Theme.MenuBack; $Button.ForeColor = $Theme.Text; $Button.Font = New-Object System.Drawing.Font("Segoe UI", 10, [System.Drawing.FontStyle]::Bold) }
    elseif ($IsPrimary) { $Button.BackColor = $Theme.PrimaryBack; $Button.ForeColor = $Theme.PrimaryText; $Button.Font = New-Object System.Drawing.Font("Segoe UI", 10, [System.Drawing.FontStyle]::Bold) }
    else { $Button.BackColor = $Theme.ButtonBack; $Button.ForeColor = $Theme.ButtonText }
}
$defaultFont = New-Object System.Drawing.Font("Segoe UI", 9)

# =============================================================================
# --- DECRYPT PANEL CONTROLS --- (Note: Adding to $panelDecrypt.Controls)
# =============================================================================
$groupBoxConfig = New-Object System.Windows.Forms.GroupBox; $groupBoxConfig.Text = 'Configuration (Set once and saved)'; $groupBoxConfig.Location = New-Object System.Drawing.Point(15, 15); $groupBoxConfig.Size = New-Object System.Drawing.Size(610, 115); $groupBoxConfig.Font = New-Object System.Drawing.Font("Segoe UI", 9, [System.Drawing.FontStyle]::Bold); $panelDecrypt.Controls.Add($groupBoxConfig)
$privateKeyLabel = New-Object System.Windows.Forms.Label; $privateKeyLabel.Location = New-Object System.Drawing.Point(15, 35); $privateKeyLabel.Size = New-Object System.Drawing.Size(120, 20); $privateKeyLabel.Text = 'Your Private Key:'; $privateKeyLabel.Font = $defaultFont; $groupBoxConfig.Controls.Add($privateKeyLabel)
$privateKeyTextBox = New-Object System.Windows.Forms.TextBox; $privateKeyTextBox.Location = New-Object System.Drawing.Point(140, 32); $privateKeyTextBox.Size = New-Object System.Drawing.Size(340, 23); $privateKeyTextBox.Font = $defaultFont; $groupBoxConfig.Controls.Add($privateKeyTextBox)
$browsePrivateKeyButton = New-Object System.Windows.Forms.Button; $browsePrivateKeyButton.Location = New-Object System.Drawing.Point(490, 30); $browsePrivateKeyButton.Size = New-Object System.Drawing.Size(100, 27); $browsePrivateKeyButton.Text = 'Browse...'; $browsePrivateKeyButton.Font = $defaultFont; $groupBoxConfig.Controls.Add($browsePrivateKeyButton)
$publicKeyLabel = New-Object System.Windows.Forms.Label; $publicKeyLabel.Location = New-Object System.Drawing.Point(15, 75); $publicKeyLabel.Size = New-Object System.Drawing.Size(120, 20); $publicKeyLabel.Text = 'Your Public Key:'; $publicKeyLabel.Font = $defaultFont; $groupBoxConfig.Controls.Add($publicKeyLabel)
$publicKeyTextBox = New-Object System.Windows.Forms.TextBox; $publicKeyTextBox.Location = New-Object System.Drawing.Point(140, 72); $publicKeyTextBox.Size = New-Object System.Drawing.Size(340, 23); $publicKeyTextBox.Font = $defaultFont; $groupBoxConfig.Controls.Add($publicKeyTextBox)
$browsePublicKeyButton = New-Object System.Windows.Forms.Button; $browsePublicKeyButton.Location = New-Object System.Drawing.Point(490, 70); $browsePublicKeyButton.Size = New-Object System.Drawing.Size(100, 27); $browsePublicKeyButton.Text = 'Browse...'; $browsePublicKeyButton.Font = $defaultFont; $groupBoxConfig.Controls.Add($browsePublicKeyButton)
$groupBoxDecryptTask = New-Object System.Windows.Forms.GroupBox; $groupBoxDecryptTask.Text = 'Decryption Task'; $groupBoxDecryptTask.Location = New-Object System.Drawing.Point(15, 140); $groupBoxDecryptTask.Size = New-Object System.Drawing.Size(610, 195); $groupBoxDecryptTask.Font = New-Object System.Drawing.Font("Segoe UI", 9, [System.Drawing.FontStyle]::Bold); $panelDecrypt.Controls.Add($groupBoxDecryptTask)
$inputFileLabel = New-Object System.Windows.Forms.Label; $inputFileLabel.Location = New-Object System.Drawing.Point(15, 35); $inputFileLabel.Size = New-Object System.Drawing.Size(120, 20); $inputFileLabel.Text = 'File to Decrypt:'; $inputFileLabel.Font = $defaultFont; $groupBoxDecryptTask.Controls.Add($inputFileLabel)
$inputFileTextBox = New-Object System.Windows.Forms.TextBox; $inputFileTextBox.Location = New-Object System.Drawing.Point(140, 32); $inputFileTextBox.Size = New-Object System.Drawing.Size(340, 23); $inputFileTextBox.Font = $defaultFont; $groupBoxDecryptTask.Controls.Add($inputFileTextBox)
$browseInputFileButton = New-Object System.Windows.Forms.Button; $browseInputFileButton.Location = New-Object System.Drawing.Point(490, 30); $browseInputFileButton.Size = New-Object System.Drawing.Size(100, 27); $browseInputFileButton.Text = 'Browse...'; $browseInputFileButton.Font = $defaultFont; $groupBoxDecryptTask.Controls.Add($browseInputFileButton)
$outputFileLabel = New-Object System.Windows.Forms.Label; $outputFileLabel.Location = New-Object System.Drawing.Point(15, 75); $outputFileLabel.Size = New-Object System.Drawing.Size(120, 20); $outputFileLabel.Text = 'Save Decrypted File:'; $outputFileLabel.Font = $defaultFont; $groupBoxDecryptTask.Controls.Add($outputFileLabel)
$outputFileTextBox = New-Object System.Windows.Forms.TextBox; $outputFileTextBox.Location = New-Object System.Drawing.Point(140, 72); $outputFileTextBox.Size = New-Object System.Drawing.Size(340, 23); $outputFileTextBox.Font = $defaultFont; $groupBoxDecryptTask.Controls.Add($outputFileTextBox)
$browseOutputFileButton = New-Object System.Windows.Forms.Button; $browseOutputFileButton.Location = New-Object System.Drawing.Point(490, 70); $browseOutputFileButton.Size = New-Object System.Drawing.Size(100, 27); $browseOutputFileButton.Text = 'Browse...'; $browseOutputFileButton.Font = $defaultFont; $groupBoxDecryptTask.Controls.Add($browseOutputFileButton)
$passphraseLabel = New-Object System.Windows.Forms.Label; $passphraseLabel.Location = New-Object System.Drawing.Point(15, 115); $passphraseLabel.Size = New-Object System.Drawing.Size(120, 20); $passphraseLabel.Text = 'Key Passphrase:'; $passphraseLabel.Font = $defaultFont; $groupBoxDecryptTask.Controls.Add($passphraseLabel)
$passphraseTextBox = New-Object System.Windows.Forms.TextBox; $passphraseTextBox.Location = New-Object System.Drawing.Point(140, 112); $passphraseTextBox.Size = New-Object System.Drawing.Size(340, 23); $passphraseTextBox.PasswordChar = '*'; $passphraseTextBox.Font = $defaultFont; $groupBoxDecryptTask.Controls.Add($passphraseTextBox)
$decryptButton = New-Object System.Windows.Forms.Button; $decryptButton.Location = New-Object System.Drawing.Point(315, 355); $decryptButton.Size = New-Object System.Drawing.Size(150, 45); $decryptButton.Text = 'DECRYPT'; $panelDecrypt.Controls.Add($decryptButton)
$decryptAndOpenButton = New-Object System.Windows.Forms.Button; $decryptAndOpenButton.Location = New-Object System.Drawing.Point(475, 355); $decryptAndOpenButton.Size = New-Object System.Drawing.Size(150, 45); $decryptAndOpenButton.Text = 'DECRYPT & OPEN'; $panelDecrypt.Controls.Add($decryptAndOpenButton)
$logoPath = Join-Path $PSScriptRoot "Inceptia_NSLP_Logo.gif"; if (Test-Path $logoPath) { $brandingLogo = New-Object System.Windows.Forms.PictureBox; $brandingLogo.Location = New-Object System.Drawing.Point(15, 355); $brandingLogo.Size = New-Object System.Drawing.Size(248, 71); $brandingLogo.SizeMode = 'Zoom'; $brandingLogo.Image = [System.Drawing.Image]::FromFile($logoPath); $panelDecrypt.Controls.Add($brandingLogo) }
$statusLabelDecrypt = New-Object System.Windows.Forms.Label; $statusLabelDecrypt.Location = New-Object System.Drawing.Point(15, 440); $statusLabelDecrypt.Size = New-Object System.Drawing.Size(100, 20); $statusLabelDecrypt.Text = 'Status:'; $statusLabelDecrypt.Font = New-Object System.Drawing.Font("Segoe UI", 9, [System.Drawing.FontStyle]::Bold); $panelDecrypt.Controls.Add($statusLabelDecrypt)
$statusTextBoxDecrypt = New-Object System.Windows.Forms.TextBox; $statusTextBoxDecrypt.Location = New-Object System.Drawing.Point(15, 465); $statusTextBoxDecrypt.Size = New-Object System.Drawing.Size(610, 270); $statusTextBoxDecrypt.Multiline = $true; $statusTextBoxDecrypt.ScrollBars = 'Vertical'; $statusTextBoxDecrypt.ReadOnly = $true; $statusTextBoxDecrypt.Font = New-Object System.Drawing.Font("Consolas", 9); $panelDecrypt.Controls.Add($statusTextBoxDecrypt)

# =============================================================================
# --- ENCRYPT PANEL CONTROLS --- (Note: Adding to $panelEncrypt.Controls)
# =============================================================================
$groupBoxEncryptTask = New-Object System.Windows.Forms.GroupBox; $groupBoxEncryptTask.Text = 'Encryption Task'; $groupBoxEncryptTask.Location = New-Object System.Drawing.Point(15, 15); $groupBoxEncryptTask.Size = New-Object System.Drawing.Size(610, 155); $groupBoxEncryptTask.Font = New-Object System.Drawing.Font("Segoe UI", 9, [System.Drawing.FontStyle]::Bold); $panelEncrypt.Controls.Add($groupBoxEncryptTask)
$encryptFileLabel = New-Object System.Windows.Forms.Label; $encryptFileLabel.Location = New-Object System.Drawing.Point(15, 35); $encryptFileLabel.Size = New-Object System.Drawing.Size(120, 20); $encryptFileLabel.Text = 'File to Encrypt:'; $encryptFileLabel.Font = $defaultFont; $groupBoxEncryptTask.Controls.Add($encryptFileLabel)
$encryptFileTextBox = New-Object System.Windows.Forms.TextBox; $encryptFileTextBox.Location = New-Object System.Drawing.Point(140, 32); $encryptFileTextBox.Size = New-Object System.Drawing.Size(340, 23); $encryptFileTextBox.Font = $defaultFont; $groupBoxEncryptTask.Controls.Add($encryptFileTextBox)
$browseEncryptFileButton = New-Object System.Windows.Forms.Button; $browseEncryptFileButton.Location = New-Object System.Drawing.Point(490, 30); $browseEncryptFileButton.Size = New-Object System.Drawing.Size(100, 27); $browseEncryptFileButton.Text = 'Browse...'; $browseEncryptFileButton.Font = $defaultFont; $groupBoxEncryptTask.Controls.Add($browseEncryptFileButton)
$encryptOutputLabel = New-Object System.Windows.Forms.Label; $encryptOutputLabel.Location = New-Object System.Drawing.Point(15, 75); $encryptOutputLabel.Size = New-Object System.Drawing.Size(120, 20); $encryptOutputLabel.Text = 'Save Encrypted File:'; $encryptOutputLabel.Font = $defaultFont; $groupBoxEncryptTask.Controls.Add($encryptOutputLabel)
$encryptOutputTextBox = New-Object System.Windows.Forms.TextBox; $encryptOutputTextBox.Location = New-Object System.Drawing.Point(140, 72); $encryptOutputTextBox.Size = New-Object System.Drawing.Size(340, 23); $encryptOutputTextBox.Font = $defaultFont; $groupBoxEncryptTask.Controls.Add($encryptOutputTextBox)
$browseEncryptOutputButton = New-Object System.Windows.Forms.Button; $browseEncryptOutputButton.Location = New-Object System.Drawing.Point(490, 70); $browseEncryptOutputButton.Size = New-Object System.Drawing.Size(100, 27); $browseEncryptOutputButton.Text = 'Browse...'; $browseEncryptOutputButton.Font = $defaultFont; $groupBoxEncryptTask.Controls.Add($browseEncryptOutputButton)
$recipientKeyLabel = New-Object System.Windows.Forms.Label; $recipientKeyLabel.Location = New-Object System.Drawing.Point(15, 115); $recipientKeyLabel.Size = New-Object System.Drawing.Size(120, 20); $recipientKeyLabel.Text = "Recipient's Key:"; $recipientKeyLabel.Font = $defaultFont; $groupBoxEncryptTask.Controls.Add($recipientKeyLabel)
$recipientComboBox = New-Object System.Windows.Forms.ComboBox; $recipientComboBox.Location = New-Object System.Drawing.Point(140, 112); $recipientComboBox.Size = New-Object System.Drawing.Size(340, 23); $recipientComboBox.DropDownStyle = 'DropDownList'; $recipientComboBox.Font = $defaultFont; $groupBoxEncryptTask.Controls.Add($recipientComboBox)
$refreshKeysButton = New-Object System.Windows.Forms.Button; $refreshKeysButton.Location = New-Object System.Drawing.Point(490, 110); $refreshKeysButton.Size = New-Object System.Drawing.Size(100, 27); $refreshKeysButton.Text = 'Refresh'; $refreshKeysButton.Font = $defaultFont; $groupBoxEncryptTask.Controls.Add($refreshKeysButton)
$encryptButton = New-Object System.Windows.Forms.Button; $encryptButton.Location = New-Object System.Drawing.Point(475, 185); $encryptButton.Size = New-Object System.Drawing.Size(150, 45); $encryptButton.Text = 'ENCRYPT'; $panelEncrypt.Controls.Add($encryptButton)
if (Test-Path $logoPath) { $brandingLogoEncrypt = New-Object System.Windows.Forms.PictureBox; $brandingLogoEncrypt.Location = New-Object System.Drawing.Point(15, 185); $brandingLogoEncrypt.Size = New-Object System.Drawing.Size(248, 71); $brandingLogoEncrypt.SizeMode = 'Zoom'; $brandingLogoEncrypt.Image = [System.Drawing.Image]::FromFile($logoPath); $panelEncrypt.Controls.Add($brandingLogoEncrypt) }
$statusLabelEncrypt = New-Object System.Windows.Forms.Label; $statusLabelEncrypt.Location = New-Object System.Drawing.Point(15, 270); $statusLabelEncrypt.Size = New-Object System.Drawing.Size(100, 20); $statusLabelEncrypt.Text = 'Status:'; $statusLabelEncrypt.Font = New-Object System.Drawing.Font("Segoe UI", 9, [System.Drawing.FontStyle]::Bold); $panelEncrypt.Controls.Add($statusLabelEncrypt)
$statusTextBoxEncrypt = New-Object System.Windows.Forms.TextBox; $statusTextBoxEncrypt.Location = New-Object System.Drawing.Point(15, 295); $statusTextBoxEncrypt.Size = New-Object System.Drawing.Size(610, 440); $statusTextBoxEncrypt.Multiline = $true; $statusTextBoxEncrypt.ScrollBars = 'Vertical'; $statusTextBoxEncrypt.ReadOnly = $true; $statusTextBoxEncrypt.Font = New-Object System.Drawing.Font("Consolas", 9); $panelEncrypt.Controls.Add($statusTextBoxEncrypt)

# =============================================================================
# --- IMPORT KEY PANEL CONTROLS --- (Note: Adding to $panelImportKey.Controls)
# =============================================================================
$groupBoxImportKey = New-Object System.Windows.Forms.GroupBox; $groupBoxImportKey.Text = 'Import Public Key to Main Keyring'; $groupBoxImportKey.Location = New-Object System.Drawing.Point(15, 15); $groupBoxImportKey.Size = New-Object System.Drawing.Size(610, 120); $groupBoxImportKey.Font = New-Object System.Drawing.Font("Segoe UI", 9, [System.Drawing.FontStyle]::Bold); $panelImportKey.Controls.Add($groupBoxImportKey)
$importFileLabel = New-Object System.Windows.Forms.Label; $importFileLabel.Location = New-Object System.Drawing.Point(15, 35); $importFileLabel.Size = New-Object System.Drawing.Size(120, 20); $importFileLabel.Text = 'Public Key File:'; $importFileLabel.Font = $defaultFont; $groupBoxImportKey.Controls.Add($importFileLabel)
$importFileTextBox = New-Object System.Windows.Forms.TextBox; $importFileTextBox.Location = New-Object System.Drawing.Point(140, 32); $importFileTextBox.Size = New-Object System.Drawing.Size(340, 23); $importFileTextBox.Font = $defaultFont; $groupBoxImportKey.Controls.Add($importFileTextBox)
$browseImportFileButton = New-Object System.Windows.Forms.Button; $browseImportFileButton.Location = New-Object System.Drawing.Point(490, 30); $browseImportFileButton.Size = New-Object System.Drawing.Size(100, 27); $browseImportFileButton.Text = 'Browse...'; $browseImportFileButton.Font = $defaultFont; $groupBoxImportKey.Controls.Add($browseImportFileButton)
$importKeyPrimaryButton = New-Object System.Windows.Forms.Button; $importKeyPrimaryButton.Location = New-Object System.Drawing.Point(475, 75); $importKeyPrimaryButton.Size = New-Object System.Drawing.Size(115, 35); $importKeyPrimaryButton.Text = 'IMPORT KEY'; $groupBoxImportKey.Controls.Add($importKeyPrimaryButton)
$statusLabelImportKey = New-Object System.Windows.Forms.Label; $statusLabelImportKey.Location = New-Object System.Drawing.Point(15, 150); $statusLabelImportKey.Size = New-Object System.Drawing.Size(100, 20); $statusLabelImportKey.Text = 'Status:'; $statusLabelImportKey.Font = New-Object System.Drawing.Font("Segoe UI", 9, [System.Drawing.FontStyle]::Bold); $panelImportKey.Controls.Add($statusLabelImportKey)
$statusTextBoxImportKey = New-Object System.Windows.Forms.TextBox; $statusTextBoxImportKey.Location = New-Object System.Drawing.Point(15, 175); $statusTextBoxImportKey.Size = New-Object System.Drawing.Size(610, 560); $statusTextBoxImportKey.Multiline = $true; $statusTextBoxImportKey.ScrollBars = 'Vertical'; $statusTextBoxImportKey.ReadOnly = $true; $statusTextBoxImportKey.Font = New-Object System.Drawing.Font("Consolas", 9); $panelImportKey.Controls.Add($statusTextBoxImportKey)

# =============================================================================
# --- OPTIONS PANEL CONTROLS --- (Note: Adding to $panelOptions.Controls)
# =============================================================================
$groupBoxGpgPath = New-Object System.Windows.Forms.GroupBox; $groupBoxGpgPath.Text = 'GPG Executable Path'; $groupBoxGpgPath.Location = New-Object System.Drawing.Point(15, 15); $groupBoxGpgPath.Size = New-Object System.Drawing.Size(610, 80); $groupBoxGpgPath.Font = New-Object System.Drawing.Font("Segoe UI", 9, [System.Drawing.FontStyle]::Bold); $panelOptions.Controls.Add($groupBoxGpgPath)
$gpgPathLabel = New-Object System.Windows.Forms.Label; $gpgPathLabel.Location = New-Object System.Drawing.Point(15, 35); $gpgPathLabel.Size = New-Object System.Drawing.Size(120, 20); $gpgPathLabel.Text = 'Path to gpg.exe:'; $gpgPathLabel.Font = $defaultFont; $groupBoxGpgPath.Controls.Add($gpgPathLabel)
$gpgPathTextBox = New-Object System.Windows.Forms.TextBox; $gpgPathTextBox.Location = New-Object System.Drawing.Point(140, 32); $gpgPathTextBox.Size = New-Object System.Drawing.Size(340, 23); $gpgPathTextBox.Font = $defaultFont; $groupBoxGpgPath.Controls.Add($gpgPathTextBox)
$browseGpgPathButton = New-Object System.Windows.Forms.Button; $browseGpgPathButton.Location = New-Object System.Drawing.Point(490, 30); $browseGpgPathButton.Size = New-Object System.Drawing.Size(100, 27); $browseGpgPathButton.Text = 'Browse...'; $browseGpgPathButton.Font = $defaultFont; $groupBoxGpgPath.Controls.Add($browseGpgPathButton)
$groupBoxTheme = New-Object System.Windows.Forms.GroupBox; $groupBoxTheme.Text = 'Appearance'; $groupBoxTheme.Location = New-Object System.Drawing.Point(15, 110); $groupBoxTheme.Size = New-Object System.Drawing.Size(610, 80); $groupBoxTheme.Font = New-Object System.Drawing.Font("Segoe UI", 9, [System.Drawing.FontStyle]::Bold); $panelOptions.Controls.Add($groupBoxTheme)
$themeLabel = New-Object System.Windows.Forms.Label; $themeLabel.Location = New-Object System.Drawing.Point(15, 35); $themeLabel.Size = New-Object System.Drawing.Size(120, 20); $themeLabel.Text = 'Color Theme:'; $themeLabel.Font = $defaultFont; $groupBoxTheme.Controls.Add($themeLabel)
$themeComboBox = New-Object System.Windows.Forms.ComboBox; $themeComboBox.Location = New-Object System.Drawing.Point(140, 32); $themeComboBox.Size = New-Object System.Drawing.Size(150, 23); $themeComboBox.DropDownStyle = 'DropDownList'; $themeComboBox.Font = $defaultFont; $themeComboBox.Items.Add('Light'); $themeComboBox.Items.Add('Dark'); $themeComboBox.SelectedItem = 'Light'; $groupBoxTheme.Controls.Add($themeComboBox)
$groupBoxFolders = New-Object System.Windows.Forms.GroupBox; $groupBoxFolders.Text = 'Default Folders'; $groupBoxFolders.Location = New-Object System.Drawing.Point(15, 205); $groupBoxFolders.Size = New-Object System.Drawing.Size(610, 80); $groupBoxFolders.Font = New-Object System.Drawing.Font("Segoe UI", 9, [System.Drawing.FontStyle]::Bold); $panelOptions.Controls.Add($groupBoxFolders)
$decryptedFolderLabel = New-Object System.Windows.Forms.Label; $decryptedFolderLabel.Location = New-Object System.Drawing.Point(15, 35); $decryptedFolderLabel.Size = New-Object System.Drawing.Size(120, 20); $decryptedFolderLabel.Text = 'Decrypted File Path:'; $decryptedFolderLabel.Font = $defaultFont; $groupBoxFolders.Controls.Add($decryptedFolderLabel)
$decryptedFolderTextBox = New-Object System.Windows.Forms.TextBox; $decryptedFolderTextBox.Location = New-Object System.Drawing.Point(140, 32); $decryptedFolderTextBox.Size = New-Object System.Drawing.Size(340, 23); $decryptedFolderTextBox.Font = $defaultFont; $groupBoxFolders.Controls.Add($decryptedFolderTextBox)
$browseDecryptedFolderButton = New-Object System.Windows.Forms.Button; $browseDecryptedFolderButton.Location = New-Object System.Drawing.Point(490, 30); $browseDecryptedFolderButton.Size = New-Object System.Drawing.Size(100, 27); $browseDecryptedFolderButton.Text = 'Browse...'; $browseDecryptedFolderButton.Font = $defaultFont; $groupBoxFolders.Controls.Add($browseDecryptedFolderButton)

# =============================================================================
# --- MANAGE KEYS PANEL CONTROLS --- (Note: Adding to $panelManageKeys.Controls)
# =============================================================================
$groupBoxKeyList = New-Object System.Windows.Forms.GroupBox; $groupBoxKeyList.Text = 'Your Keyring'; $groupBoxKeyList.Location = New-Object System.Drawing.Point(15, 15); $groupBoxKeyList.Size = New-Object System.Drawing.Size(610, 400); $groupBoxKeyList.Font = New-Object System.Drawing.Font("Segoe UI", 9, [System.Drawing.FontStyle]::Bold); $panelManageKeys.Controls.Add($groupBoxKeyList)
$keyListView = New-Object System.Windows.Forms.ListView; $keyListView.Location = New-Object System.Drawing.Point(15, 30); $keyListView.Size = New-Object System.Drawing.Size(580, 310); $keyListView.View = 'Details'; $keyListView.FullRowSelect = $true; $keyListView.GridLines = $true; $keyListView.Font = $defaultFont; $groupBoxKeyList.Controls.Add($keyListView)
$keyListView.Columns.Add('Type', 80) | Out-Null; $keyListView.Columns.Add('Key ID', 140) | Out-Null; $keyListView.Columns.Add('User ID', 330) | Out-Null
$refreshManageKeysButton = New-Object System.Windows.Forms.Button; $refreshManageKeysButton.Location = New-Object System.Drawing.Point(15, 350); $refreshManageKeysButton.Size = New-Object System.Drawing.Size(100, 30); $refreshManageKeysButton.Text = 'Refresh'; $refreshManageKeysButton.Font = $defaultFont; $groupBoxKeyList.Controls.Add($refreshManageKeysButton)
$exportKeyButton = New-Object System.Windows.Forms.Button; $exportKeyButton.Location = New-Object System.Drawing.Point(380, 350); $exportKeyButton.Size = New-Object System.Drawing.Size(100, 30); $exportKeyButton.Text = 'Export Key'; $exportKeyButton.Font = $defaultFont; $groupBoxKeyList.Controls.Add($exportKeyButton)
$deleteKeyButton = New-Object System.Windows.Forms.Button; $deleteKeyButton.Location = New-Object System.Drawing.Point(495, 350); $deleteKeyButton.Size = New-Object System.Drawing.Size(100, 30); $deleteKeyButton.Text = 'Delete Key'; $deleteKeyButton.Font = $defaultFont; $groupBoxKeyList.Controls.Add($deleteKeyButton)
$statusLabelManageKeys = New-Object System.Windows.Forms.Label; $statusLabelManageKeys.Location = New-Object System.Drawing.Point(15, 430); $statusLabelManageKeys.Size = New-Object System.Drawing.Size(100, 20); $statusLabelManageKeys.Text = 'Status:'; $statusLabelManageKeys.Font = New-Object System.Drawing.Font("Segoe UI", 9, [System.Drawing.FontStyle]::Bold); $panelManageKeys.Controls.Add($statusLabelManageKeys)
$statusTextBoxManageKeys = New-Object System.Windows.Forms.TextBox; $statusTextBoxManageKeys.Location = New-Object System.Drawing.Point(15, 455); $statusTextBoxManageKeys.Size = New-Object System.Drawing.Size(610, 280); $statusTextBoxManageKeys.Multiline = $true; $statusTextBoxManageKeys.ScrollBars = 'Vertical'; $statusTextBoxManageKeys.ReadOnly = $true; $statusTextBoxManageKeys.Font = New-Object System.Drawing.Font("Consolas", 9); $panelManageKeys.Controls.Add($statusTextBoxManageKeys)

# =============================================================================
# --- THEME APPLY FUNCTION ---
# =============================================================================
function Update-Theme {
    $themeName = $themeComboBox.SelectedItem
    $Theme = if ($themeName -eq 'Dark') { $DarkMode } else { $LightMode }
    $form.BackColor = $Theme.FormBack
    $panelMenu.BackColor = $Theme.MenuBack
    @($panelDecrypt, $panelEncrypt, $panelImportKey, $panelOptions, $panelManageKeys).ForEach({ $_.BackColor = $Theme.FormBack })
    $AllLabels = @(
        $privateKeyLabel, $publicKeyLabel, $inputFileLabel, $outputFileLabel, $passphraseLabel, $statusLabelDecrypt,
        $encryptFileLabel, $encryptOutputLabel, $recipientKeyLabel, $statusLabelEncrypt,
        $importFileLabel, $statusLabelImportKey,
        $gpgPathLabel, $themeLabel, $decryptedFolderLabel, $statusLabelManageKeys
    )
    $AllLabels.ForEach({ $_.ForeColor = $Theme.Text })
    $AllGroupBoxes = @($groupBoxConfig, $groupBoxDecryptTask, $groupBoxEncryptTask, $groupBoxImportKey, $groupBoxGpgPath, $groupBoxTheme, $groupBoxFolders, $groupBoxKeyList)
    $AllGroupBoxes.ForEach({ $_.ForeColor = $Theme.GroupBoxText })
    $AllTextBoxes = @(
        $privateKeyTextBox, $publicKeyTextBox, $inputFileTextBox, $outputFileTextBox, $passphraseTextBox,
        $encryptFileTextBox, $encryptOutputTextBox,
        $importFileTextBox,
        $gpgPathTextBox, $decryptedFolderTextBox
    )
    $AllTextBoxes.ForEach({ $_.BackColor = $Theme.TextBoxBack; $_.ForeColor = $Theme.TextBoxText })
    @($themeComboBox, $recipientComboBox).ForEach({ $_.BackColor = $Theme.TextBoxBack; $_.ForeColor = $Theme.TextBoxText })
    $keyListView.BackColor = $Theme.TextBoxBack; $keyListView.ForeColor = $Theme.TextBoxText
    @($statusTextBoxDecrypt, $statusTextBoxEncrypt, $statusTextBoxImportKey, $statusTextBoxManageKeys).ForEach({ $_.BackColor = $Theme.StatusBack; $_.ForeColor = $Theme.Text })
    $AllBrowseButtons = @(
        $browsePrivateKeyButton, $browsePublicKeyButton, $browseInputFileButton, $browseOutputFileButton,
        $browseEncryptFileButton, $browseEncryptOutputButton, $browseImportFileButton,
        $browseGpgPathButton, $browseDecryptedFolderButton, $refreshKeysButton,
        $refreshManageKeysButton, $exportKeyButton, $deleteKeyButton
    )
    $AllBrowseButtons.ForEach({ Set-ModernButtonStyle -Button $_ -Theme $Theme })
    $MenuButtons.ForEach({ Set-ModernButtonStyle -Button $_ -Theme $Theme -IsMenu $true })
    if ($panelDecrypt.Visible) { $btnShowDecrypt.BackColor = $Theme.MenuSelected }
    if ($panelEncrypt.Visible) { $btnShowEncrypt.BackColor = $Theme.MenuSelected }
    if ($panelImportKey.Visible) { $btnShowImportKey.BackColor = $Theme.MenuSelected }
    if ($panelOptions.Visible) { $btnShowOptions.BackColor = $Theme.MenuSelected }
    if ($panelManageKeys.Visible) { $btnShowManageKeys.BackColor = $Theme.MenuSelected }
    Set-ModernButtonStyle -Button $decryptButton -Theme $Theme -IsPrimary $true
    Set-ModernButtonStyle -Button $decryptAndOpenButton -Theme $Theme -IsPrimary $true
    Set-ModernButtonStyle -Button $encryptButton -Theme $Theme -IsPrimary $true
    Set-ModernButtonStyle -Button $importKeyPrimaryButton -Theme $Theme -IsPrimary $true
}

# =============================================================================
# --- LOGIC AND EVENT HANDLERS ---
# =============================================================================
# --- GPG Key Loader ---
function Load-GpgKeys {
    $gpgExecutablePath = $gpgPathTextBox.Text
    if (-not (Test-Path $gpgExecutablePath)) {
        $statusTextBoxEncrypt.Text = "Cannot load keys: GPG.exe path not set in Options."
        return
    }
    $recipientComboBox.Items.Clear()
    $statusTextBoxEncrypt.Text = "Loading GPG keys from your keyring..."
    $form.Update()
    $keyLines = & $gpgExecutablePath --list-keys --with-colons 2>&1
    $keyMap = New-Object 'System.Collections.Generic.Dictionary[string,string]'
    $currentKeyID = $null
    foreach ($line in $keyLines) {
        $parts = $line -split ':'
        if ($parts[0] -eq 'pub' -and $parts.Length -ge 5) {
            $currentKeyID = $parts[4]
            if ($parts.Length -ge 10 -and -not [string]::IsNullOrWhiteSpace($parts[9])) {
                $uid = $parts[9]
                if (-not $keyMap.ContainsKey($uid)) { $keyMap.Add($uid, $currentKeyID) }
                $currentKeyID = $null
            }
        }
        elseif ($parts[0] -eq 'uid' -and $currentKeyID -and $parts.Length -ge 10) {
            $uid = $parts[9]
            if (-not [string]::IsNullOrWhiteSpace($uid) -and -not $keyMap.ContainsKey($uid)) { $keyMap.Add($uid, $currentKeyID) }
            $currentKeyID = $null
        }
    }
    if ($keyMap.Count -eq 0) { $statusTextBoxEncrypt.Text = "No public keys found in your GPG keyring."; return }
    $sortedKeys = $keyMap.GetEnumerator() | Sort-Object Key
    foreach ($key in $sortedKeys) { $recipientComboBox.Items.Add($key) }
    $recipientComboBox.DisplayMember = 'Key'; $recipientComboBox.ValueMember = 'Value'
    $selectedIndex = 0
    if ($null -ne $script:LastRecipientKey) {
        for ($i = 0; $i -lt $recipientComboBox.Items.Count; $i++) {
            if ($recipientComboBox.Items[$i].Key -eq $script:LastRecipientKey) { $selectedIndex = $i; break }
        }
    }
    $recipientComboBox.SelectedIndex = $selectedIndex
    $statusTextBoxEncrypt.Text = "GPG keys loaded successfully."
}

# --- Button Click Actions (Options) ---
$browseGpgPathButton.Add_Click({ $filePath = Get-FilePath -Title 'Select gpg.exe File' -Filter 'gpg.exe|gpg.exe'; if ($filePath) { $gpgPathTextBox.Text = $filePath } })
$browseDecryptedFolderButton.Add_Click({ $folderPath = Get-FolderPath -Title 'Select Default Folder for Decrypted Files'; if ($folderPath) { $decryptedFolderTextBox.Text = $folderPath } })

# --- Button Click Actions (Decrypt) ---
$browsePrivateKeyButton.Add_Click({ $filePath = Get-FilePath -Title 'Select Private Key File' -Filter 'Secret Key Files (*.sec)|*.sec|All files (*.*)|*.*' -InitialDirectory $keyFolderPath; if ($filePath) { $privateKeyTextBox.Text = $filePath } })
$browsePublicKeyButton.Add_Click({ $filePath = Get-FilePath -Title 'Select Public Key File' -Filter 'Public Key Files (*.pub)|*.pub|All files (*.*)|*.*' -InitialDirectory $keyFolderPath; if ($filePath) { $publicKeyTextBox.Text = $filePath } })
$browseInputFileButton.Add_Click({ $filePath = Get-FilePath -Title 'Select Encrypted File to Decrypt' -Filter 'All files (*.*)|*.*'; if ($filePath) { $inputFileTextBox.Text = $filePath } })
$browseOutputFileButton.Add_Click({ $filePath = Get-SaveFilePath -Title 'Save Decrypted File As' -Filter 'All files (*.*)|*.*'; if ($filePath) { $outputFileTextBox.Text = $filePath } })

# --- Button Click Actions (Encrypt) ---
$browseEncryptFileButton.Add_Click({ $filePath = Get-FilePath -Title 'Select File to Encrypt' -Filter 'All files (*.*)|*.*'; if ($filePath) { $encryptFileTextBox.Text = $filePath } })
$browseEncryptOutputButton.Add_Click({ $filePath = Get-SaveFilePath -Title 'Save Encrypted File As' -Filter 'GPG encrypted file (*.gpg)|*.gpg|All files (*.*)|*.*'; if ($filePath) { $encryptOutputTextBox.Text = $filePath } })
$refreshKeysButton.Add_Click({ Load-GpgKeys })

# --- Button Click Actions (Import Key) ---
$browseImportFileButton.Add_Click({ $filePath = Get-FilePath -Title "Select Recipient's Public Key to Import" -Filter 'Public Key Files (*.pub)|*.pub|All files (*.*)|*.*'; if ($filePath) { $importFileTextBox.Text = $filePath } })
$importKeyPrimaryButton.Add_Click({
    $statusTextBoxImportKey.Text = ""
    $filePath = $importFileTextBox.Text
    if (-not $filePath -or -not (Test-Path $filePath)) { $statusTextBoxImportKey.Text = "ERROR: Please select a valid key file to import."; return }
    $gpgExecutablePath = $gpgPathTextBox.Text
    if (-not (Test-Path $gpgExecutablePath)) { $statusTextBoxImportKey.Text = "ERROR: Path to gpg.exe must be set on the 'Options' tab."; return }
    
    $importKeyPrimaryButton.Enabled = $false; $importKeyPrimaryButton.Text = "Importing..."
    $statusTextBoxImportKey.Text = "Importing $filePath into main GPG keyring..."
    $form.Update()
    
    # --- Import to MAIN keyring (no --homedir) ---
    $importResult = & $gpgExecutablePath --import $filePath 2>&1 | Out-String
    $statusTextBoxImportKey.Text += "`r`n`r`n--- Import Result ---`r`n$importResult"
    
    # --- Automatically refresh the dropdown on the Encrypt tab ---
    $statusTextBoxImportKey.Text += "`r`n`r`nRefreshing key list on Encrypt tab..."
    Load-GpgKeys
    $statusTextBoxImportKey.Text += "`r`nDone."
    
    $importKeyPrimaryButton.Enabled = $true; $importKeyPrimaryButton.Text = "IMPORT KEY"
})

# --- Manage Keys Logic ---
function Load-ManageKeysList {
    $gpgExecutablePath = $gpgPathTextBox.Text
    if (-not (Test-Path $gpgExecutablePath)) { $statusTextBoxManageKeys.Text = "Cannot load keys: GPG.exe path not set."; return }
    $keyListView.Items.Clear()
    $statusTextBoxManageKeys.Text = "Loading keys..."
    $form.Update()

    # Load Public Keys
    $pubLines = & $gpgExecutablePath --list-keys --with-colons 2>&1
    $currentKeyID = $null
    foreach ($line in $pubLines) {
        $parts = $line -split ':'
        if ($parts[0] -eq 'pub' -and $parts.Length -ge 5) {
            $currentKeyID = $parts[4]
            if ($parts.Length -ge 10 -and -not [string]::IsNullOrWhiteSpace($parts[9])) {
                $uid = $parts[9]
                $item = New-Object System.Windows.Forms.ListViewItem("Public")
                $item.SubItems.Add($currentKeyID) | Out-Null
                $item.SubItems.Add($uid) | Out-Null
                $keyListView.Items.Add($item) | Out-Null
                $currentKeyID = $null
            }
        }
        elseif ($parts[0] -eq 'uid' -and $currentKeyID -and $parts.Length -ge 10) {
            $item = New-Object System.Windows.Forms.ListViewItem("Public")
            $item.SubItems.Add($currentKeyID) | Out-Null
            $item.SubItems.Add($parts[9]) | Out-Null
            $keyListView.Items.Add($item) | Out-Null
            $currentKeyID = $null
        }
    }
    
    # Load Secret Keys
    $secLines = & $gpgExecutablePath --list-secret-keys --with-colons 2>&1
    $currentKeyID = $null
    foreach ($line in $secLines) {
        $parts = $line -split ':'
        if ($parts[0] -eq 'sec' -and $parts.Length -ge 5) {
            $currentKeyID = $parts[4]
            if ($parts.Length -ge 10 -and -not [string]::IsNullOrWhiteSpace($parts[9])) {
                $uid = $parts[9]
                $item = New-Object System.Windows.Forms.ListViewItem("Secret")
                $item.SubItems.Add($currentKeyID) | Out-Null
                $item.SubItems.Add($uid) | Out-Null
                $keyListView.Items.Add($item) | Out-Null
                $currentKeyID = $null
            }
        }
        elseif ($parts[0] -eq 'uid' -and $currentKeyID -and $parts.Length -ge 10) {
            $item = New-Object System.Windows.Forms.ListViewItem("Secret")
            $item.SubItems.Add($currentKeyID) | Out-Null
            $item.SubItems.Add($parts[9]) | Out-Null
            $keyListView.Items.Add($item) | Out-Null
            $currentKeyID = $null
        }
    }
    $statusTextBoxManageKeys.Text = "Keys loaded successfully."
}

$refreshManageKeysButton.Add_Click({ Load-ManageKeysList })
$btnShowManageKeys.Add_Click({ if ($keyListView.Items.Count -eq 0) { Load-ManageKeysList } })

$exportKeyButton.Add_Click({
    if ($keyListView.SelectedItems.Count -eq 0) { $statusTextBoxManageKeys.Text = "Please select a key to export."; return }
    $selectedItem = $keyListView.SelectedItems[0]
    $keyType = $selectedItem.Text
    $keyID = $selectedItem.SubItems[1].Text
    $uid = $selectedItem.SubItems[2].Text
    
    if ($keyType -eq "Secret") {
        $statusTextBoxManageKeys.Text = "Exporting secret keys directly from the UI is restricted for security. Please export public keys."
        return
    }

    $savePath = Get-SaveFilePath -Title "Export Public Key" -Filter "Public Key (*.pub)|*.pub|All files (*.*)|*.*"
    if (-not $savePath) { return }
    
    $gpgExecutablePath = $gpgPathTextBox.Text
    $statusTextBoxManageKeys.Text = "Exporting key $keyID..."
    $form.Update()
    
    try {
        & $gpgExecutablePath --export -a $keyID | Out-File -FilePath $savePath -Encoding ascii
        if (Test-Path $savePath) { $statusTextBoxManageKeys.Text = "✅ SUCCESS: Key exported to $savePath" }
    } catch {
        $statusTextBoxManageKeys.Text = "❌ ERROR: $($_.Exception.Message)"
    }
})

$deleteKeyButton.Add_Click({
    if ($keyListView.SelectedItems.Count -eq 0) { $statusTextBoxManageKeys.Text = "Please select a key to delete."; return }
    $selectedItem = $keyListView.SelectedItems[0]
    $keyType = $selectedItem.Text
    $keyID = $selectedItem.SubItems[1].Text
    $uid = $selectedItem.SubItems[2].Text
    
    $confirm = [System.Windows.Forms.MessageBox]::Show("Are you sure you want to delete the $keyType key:`n$uid ($keyID)?`n`nThis action cannot be undone.", "Confirm Delete", [System.Windows.Forms.MessageBoxButtons]::YesNo, [System.Windows.Forms.MessageBoxIcon]::Warning)
    if ($confirm -ne 'Yes') { return }
    
    $gpgExecutablePath = $gpgPathTextBox.Text
    $statusTextBoxManageKeys.Text = "Deleting $keyType key $keyID..."
    $form.Update()
    
    try {
        if ($keyType -eq "Secret") {
            $delResult = & $gpgExecutablePath --batch --yes --delete-secret-key $keyID 2>&1 | Out-String
        } else {
            $delResult = & $gpgExecutablePath --batch --yes --delete-key $keyID 2>&1 | Out-String
        }
        $statusTextBoxManageKeys.Text = "Delete Operation Result:`r`n$delResult"
        Load-ManageKeysList
        Load-GpgKeys # Refresh encrypt tab dropdown
    } catch {
        $statusTextBoxManageKeys.Text = "❌ ERROR: $($_.Exception.Message)"
    }
})

# --- Theme Change Event ---
$themeComboBox.Add_SelectedIndexChanged({ Update-Theme })
$MenuButtons.ForEach({ $_.Add_Click({ Update-Theme }) })


# --- Main Decrypt Logic (Reusable Function) ---
function Invoke-GpgDecryption {
    $statusTextBoxDecrypt.Text = ''
    $form.Update()
    $gpgExecutablePath = $gpgPathTextBox.Text
    if (-not (Test-Path $gpgExecutablePath)) { $statusTextBoxDecrypt.Text = "ERROR: Path to gpg.exe must be set on the 'Options' tab."; return $null }
    if ([string]::IsNullOrWhiteSpace($privateKeyTextBox.Text) -or [string]::IsNullOrWhiteSpace($publicKeyTextBox.Text) -or [string]::IsNullOrWhiteSpace($inputFileTextBox.Text) -or [string]::IsNullOrWhiteSpace($outputFileTextBox.Text)) { $statusTextBoxDecrypt.Text = 'ERROR: All four file paths must be specified...'; return $null }
    $decryptButton.Enabled = $false; $decryptAndOpenButton.Enabled = $false; $decryptButton.Text = "Working..."; $decryptAndOpenButton.Text = "Working..."
    $tempGpgHome = $null
    try {
        $tempGpgHome = Join-Path $env:TEMP ([System.Guid]::NewGuid().ToString()); New-Item -ItemType Directory -Path $tempGpgHome -Force | Out-Null
        $statusTextBoxDecrypt.Text = "Attempting to import keys..."; $form.Update()
        $privateImportResult = & $gpgExecutablePath --homedir $tempGpgHome --batch --allow-secret-key-import --import $privateKeyTextBox.Text 2>&1 | Out-String
        $statusTextBoxDecrypt.Text += "`r`n--- Private Key Import ---`r`n$privateImportResult"; $form.Update()
        $publicImportResult = & $gpgExecutablePath --homedir $tempGpgHome --batch --import $publicKeyTextBox.Text 2>&1 | Out-String
        $statusTextBoxDecrypt.Text += "`r`n--- Public Key Import ---`r`n$publicImportResult"; $form.Update()
        $statusTextBoxDecrypt.Text += "`r`n`r`nAttempting to decrypt $($inputFileTextBox.Text)..."; $form.Update()
        $gpgArgs = @('--homedir', $tempGpgHome, '--trust-model', 'always', '--yes', '--batch')
        $passphrase = $passphraseTextBox.Text; if (-not [string]::IsNullOrWhiteSpace($passphrase)) { $gpgArgs += @('--pinentry-mode', 'loopback', '--passphrase', $passphrase) }
        $gpgArgs += @('--output', $outputFileTextBox.Text, '--decrypt', $inputFileTextBox.Text)
        $decryptResult = & $gpgExecutablePath $gpgArgs 2>&1 | Out-String
        $statusTextBoxDecrypt.Text += "`r`n--- Decryption Result ---`r`n$decryptResult"
        $outputFilePath = $outputFileTextBox.Text
        if ((Test-Path $outputFilePath) -and ((Get-Item $outputFilePath).Length -gt 0)) {
            $statusTextBoxDecrypt.Text += "`r`n`r`n✅ SUCCESS: File decrypted successfully!`r`nOutput saved to: $($outputFileTextBox.Text)`r`n(Note: Any warnings above, like 'Can't check signature', are informational.)"
            return $outputFilePath # Return path on success
        }
        else { $statusTextBoxDecrypt.Text += "`r`n`r`n❌ ERROR: Decryption failed. The output file was not created. See details above." }
    }
    catch { $statusTextBoxDecrypt.Text += "`r`n`r`nFATAL SCRIPT ERROR: $($_.Exception.Message)" }
    finally { $decryptButton.Enabled = $true; $decryptAndOpenButton.Enabled = $true; $decryptButton.Text = "DECRYPT"; $decryptAndOpenButton.Text = "DECRYPT & OPEN"; if ($tempGpgHome -and (Test-Path $tempGpgHome)) { Remove-Item -Path $tempGpgHome -Recurse -Force } }
    return $null # Return null on failure
}
$decryptButton.Add_Click({ Invoke-GpgDecryption | Out-Null })
$decryptAndOpenButton.Add_Click({
    $decryptedFile = Invoke-GpgDecryption
    if ($decryptedFile) {
        try { Invoke-Item -Path $decryptedFile }
        catch { $statusTextBoxDecrypt.Text += "`r`n`r`nERROR: Could not open decrypted file. $($_.Exception.Message)" }
    }
})

# --- Main Encrypt Logic ---
$encryptButton.Add_Click({
    $statusTextBoxEncrypt.Text = ''
    $form.Update()
    $gpgExecutablePath = $gpgPathTextBox.Text
    if (-not (Test-Path $gpgExecutablePath)) { $statusTextBoxEncrypt.Text = "ERROR: Path to gpg.exe must be set on the 'Options' tab."; return }
    if ([string]::IsNullOrWhiteSpace($encryptFileTextBox.Text) -or [string]::IsNullOrWhiteSpace($encryptOutputTextBox.Text) -or ($null -eq $recipientComboBox.SelectedItem)) { $statusTextBoxEncrypt.Text = "ERROR: All fields must be set and a recipient must be selected."; return }
    $selectedRecipient = $recipientComboBox.SelectedItem
    $selectedKeyID = $selectedRecipient.Value
    $encryptButton.Enabled = $false; $encryptButton.Text = "Working..."
    $tempGpgHome = $null
    try {
        $tempGpgHome = Join-Path $env:TEMP ([System.Guid]::NewGuid().ToString()); New-Item -ItemType Directory -Path $tempGpgHome -Force | Out-Null
        $statusTextBoxEncrypt.Text = "Exporting recipient's public key ($($selectedRecipient.Key))..."; $form.Update()
        $tempKeyFile = Join-Path $tempGpgHome "recipient.pub"; & $gpgExecutablePath --export -a $selectedKeyID -o $tempKeyFile
        $importResult = & $gpgExecutablePath --homedir $tempGpgHome --import $tempKeyFile 2>&1 | Out-String; Remove-Item $tempKeyFile
        $statusTextBoxEncrypt.Text += "`r`n--- Public Key Import ---`r`n$importResult"; $form.Update()
        $statusTextBoxEncrypt.Text += "`r`n`r`nAttempting to encrypt $($encryptFileTextBox.Text)..."; $form.Update()
        $gpgArgs = @('--homedir', $tempGpgHome, '--trust-model', 'always', '--output', $encryptOutputTextBox.Text, '--encrypt', '--recipient', $selectedKeyID, $encryptFileTextBox.Text)
        $encryptResult = & $gpgExecutablePath $gpgArgs 2>&1 | Out-String
        $statusTextBoxEncrypt.Text += "`r`n--- Encryption Result ---`r`n$encryptResult"
        $outputFilePath = $encryptOutputTextBox.Text
        if ((Test-Path $outputFilePath) -and ((Get-Item $outputFilePath).Length -gt 0)) {
            $statusTextBoxEncrypt.Text += "`r`n`r`n✅ SUCCESS: File encrypted successfully!`r`nOutput saved to: $($outputFilePath)"
        }
        else { $statusTextBoxEncrypt.Text += "`r`n`r`n❌ ERROR: Encryption failed. The output file was not created. See details above." }
    }
    catch { $statusTextBoxEncrypt.Text += "`r`n`r`nFATAL SCRIPT ERROR: $($_.Exception.Message)" }
    finally { $encryptButton.Enabled = $true; $encryptButton.Text = "ENCRYPT"; if ($tempGpgHome -and (Test-Path $tempGhome)) { Remove-Item -Path $tempGpgHome -Recurse -Force } }
})


# =============================================================================
# --- Settings Management (Load on Start, Save on Close) ---
# =============================================================================
$settingsFilePath = Join-Path $PSScriptRoot "settings.json"
if (Test-Path $settingsFilePath) {
    try {
        $settings = Get-Content $settingsFilePath -Raw | ConvertFrom-Json
        if ($null -ne $settings) {
            $gpgPathTextBox.Text = $settings.GpgExePath
            $privateKeyTextBox.Text = $settings.PrivateKeyPath
            $publicKeyTextBox.Text = $settings.PublicKeyPath
            $decryptedFolderTextBox.Text = $settings.DecryptedFolderPath
            if ($settings.Theme -and $themeComboBox.Items.Contains($settings.Theme)) { $themeComboBox.SelectedItem = $settings.Theme }
            if ($settings.LastDecryptOutput) { $outputFileTextBox.Text = $settings.LastDecryptOutput }
            if ($settings.LastEncryptOutput) { $encryptOutputTextBox.Text = $settings.LastEncryptOutput }
            $script:LastRecipientKey = $settings.LastRecipientKey
        }
    }
    catch { } # Silently ignore
}
$form.Add_FormClosing({
    $settingsToSave = @{
        GpgExePath          = $gpgPathTextBox.Text
        PrivateKeyPath      = $privateKeyTextBox.Text
        PublicKeyPath       = $publicKeyTextBox.Text
        DecryptedFolderPath = $decryptedFolderTextBox.Text
        Theme               = $themeComboBox.SelectedItem
        LastDecryptOutput   = $outputFileTextBox.Text
        LastEncryptOutput   = $encryptOutputTextBox.Text
        LastRecipientKey    = if ($null -ne $recipientComboBox.SelectedItem) { $recipientComboBox.SelectedItem.Key } else { $null }
    }
    $settingsToSave | ConvertTo-Json | Set-Content $settingsFilePath -Force
})

# --- Initial Load ---
Update-Theme # Apply the loaded (or default) theme on startup
. $MenuClickHandler -Button $btnShowDecrypt -Panel $panelDecrypt # Show Decrypt panel first
Update-Theme # Call *again* to make sure the active menu button is highlighted

if (Test-Path $gpgPathTextBox.Text) { Load-GpgKeys }

# --- Display Form ---
$form.ShowDialog() | Out-Null