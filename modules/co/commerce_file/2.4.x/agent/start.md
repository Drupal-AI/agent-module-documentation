# commerce_file — agent start

Sells access to downloadable files on top of **Commerce License**. Add the `commerce_file` entity
trait to a product variation type → variations get a required private-file field; purchase creates
a `commerce_file` **License** that unlocks the file(s). Access is enforced by a file access hook +
a dedicated download route; downloads are counted against optional limits. Depends on
`commerce_license` + core `file`.

## Capabilities

- [Set up & configure (trait, license type, download limits, checkout pane)](configure/setup.md) —
  the settings form, `commerce_file.settings` keys, the product-variation trait/field, per-license
  limits, and the S3/Flysystem redirect.
- [Access & download API (services, hooks, controller)](api/file-access.md) — `LicenseFileManager`
  (`isLicensable`, `getActiveLicenses`, `canDownload`), the `hook_file_access` / `hook_file_download`
  logic, `FileDownloadController`, and the `DownloadLogger`.
- [Permissions](permissions/permissions.md) — the single `bypass license control` permission.

Provides no new plugin *types*; it ships plugin *implementations* (Commerce license type, checkout
pane, entity trait, field formatter/widget, a Views field) documented in the API doc.
