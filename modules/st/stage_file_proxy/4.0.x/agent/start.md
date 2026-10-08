# stage_file_proxy — agent start

Fetches missing public files on demand from a production `origin` server so dev/staging
sites need no full files directory. A `KernelEvents::REQUEST` subscriber intercepts requests
under the public files path and either downloads the file (default) or serves a `301` to the
origin (hotlink). Depends on core `image`. Dev-only — do **not** enable on production.
Config UI: **Admin → Config → System → Stage File Proxy Settings**
(`/admin/config/system/stage_file_proxy`); settings route `stage_file_proxy.admin_form`,
config object `stage_file_proxy.settings`.

- Set the origin URL & all proxy settings (settings.php or UI) → [configure/stage_file_proxy.md](configure/stage_file_proxy.md)
- Bulk-download / warm all files from the origin (Drush) → [drush/stage_file_proxy.md](drush/stage_file_proxy.md)
- Services, the on-demand fetch flow, and the excluded-paths event → [api/stage_file_proxy.md](api/stage_file_proxy.md)
