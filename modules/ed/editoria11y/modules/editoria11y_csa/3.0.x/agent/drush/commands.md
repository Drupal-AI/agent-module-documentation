# Drush commands (license)

`src/Drush/Commands/Editoria11yCsaCommands.php` manages the CSA membership license via the
`LicenseManager` service (key stored with the Key module).

| Method | Purpose |
|---|---|
| `setKey(<licenseKey>)` | Store the license key. |
| `activate()` | Activate the license. |
| `deactivate()` | Deactivate the license. |
| `checkStatus()` | Report current license status. |
| `lock()` | Lock the license (maintenance). |
| `unlock()` | Unlock the license. |

Run via `drush` using the command names registered by the class (Drush `#[Command]`
attributes). Requires the `key` module; a `LicenseUninstallValidator` guards uninstall while a
license is active.
