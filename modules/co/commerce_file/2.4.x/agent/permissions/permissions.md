# commerce_file — permissions

One permission (`commerce_file.permissions.yml`):

| Permission | Gates |
|---|---|
| `bypass license control` | Download/view any licensable file **without** holding a license, and skip download-limit enforcement and download logging. Marked `restrict access: true` (grant only to trusted staff). |

Checked in `commerce_file_file_access()`, `FileDownloadController::access()`,
`LicenseFileManager::canDownload()`, and `shouldLogDownload()`. The core Commerce License
permission **`administer commerce_license`** is treated the same way throughout (bypasses access
checks, limits, and logging) and also gates the module's settings form
(`/admin/commerce/config/licenses/file`).
