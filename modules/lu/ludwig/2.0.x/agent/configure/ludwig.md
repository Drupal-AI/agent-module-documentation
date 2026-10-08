# The Packages report & non-Composer download workflow

Ludwig has **no settings form and no config object** — its "configuration" is the Packages
report, which is also where downloads happen. `configure` in `ludwig.info.yml` points at the
`ludwig.packages` route.

## Routes (`ludwig.routing.yml`)

| Route | Path | Behavior | Permission |
|---|---|---|---|
| `ludwig.packages` | `/admin/reports/packages` | Lists all declared packages **and downloads any `Missing` ones on load**, then flushes caches. | `access site reports` (core) |
| `ludwig.packages_skip` | `/admin/reports/packages_skip` | Same report **without** downloading (inspect only). | `access site reports` (core) |

Both are served by `PackageController::page()`. Menu link lives under **Reports**
(`system.admin_reports`); local tasks let you switch between the two views. There is **no
Drush command** in 2.0.x.

## The non-Composer workflow

1. A module ships a `ludwig.json` declaring its libraries (see [api/ludwig.md](../api/ludwig.md)).
2. Enable the module. Its libraries show as **Missing** on the report.
3. Visit `/admin/reports/packages`. Ludwig fetches each missing archive (Guzzle HTTP GET),
   extracts it (archiver manager), and copies it into
   `<module>/lib/<vendor>-<name>/<version>/`. Caches are flushed automatically.
4. The **"Download missing packages (N)"** action button links back to the same route to
   re-run the download for any that failed. Use `/admin/reports/packages_skip` to view
   without re-downloading.

The extension directory must be **writable** for downloads to succeed (otherwise Ludwig
throws "The extension directory … is not writable.").

## Report columns

`Package` (name + description/homepage), `Namespace`, `Paths`, `Resource`
(`psr-4` / `psr-0` / `files` / `classmap` / `legacy` / `inactive` / `unknown` …), `Version`,
`Required by` (the requiring module), and `Status`.

## Status values (from `PackageManager::getPackages()`)

| Status | Meaning |
|---|---|
| `Installed` | Downloaded and autoloadable (PSR-4/PSR-0), or a `files`/`classmap` lib wired via `ludwig.require_once`. |
| `Missing` | Not yet downloaded — the report will fetch it. |
| `Not installed` | A `files`/`classmap` lib present on disk but not yet required via the `ludwig.require_once` service. |
| `Overridden` | A lower version of a package also required elsewhere; the highest version wins. |
| `Not supported` | `target-dir` / `exclude-from-classmap` autoload types. |
| `Inactive` | Library `composer.json` has no `autoload` section. |
| `Unknown type` / legacy | Unrecognized or deprecated (`include-path`) autoload type. |

## Update Manager reminder

`ludwig_form_update_manager_update_form_alter()` adds a warning next to Ludwig-managed
modules on the core Update Manager form, reminding maintainers to download all required
libraries via the Packages page **before** running "Run database updates".
