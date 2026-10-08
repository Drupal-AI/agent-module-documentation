<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Library install & the `use_cdn` setting

DataTables needs the jQuery DataTables JavaScript **library** at runtime. The module ships one
site-wide setting to choose local vs CDN.

## Config object

```yaml
# datatables.settings   (config/install default)
use_cdn: false
```

- `use_cdn: false` — load the library from the local `/libraries` folder (the
  `datatables/datatables_core` library points at `/libraries/datatables/js/dataTables.min.js`
  and `/libraries/datatables.net-dt/css/...`).
- `use_cdn: true` — `datatables_library_info_alter()` rewrites the `datatables_core` library to
  load `https://cdn.datatables.net/2.3.8/js/dataTables.min.js` (+ matching CSS) as external assets.

Settings form `DatatablesSettingsForm` (route `datatables.settings` →
`/admin/config/services/datatables`, permission **`administer site configuration`**). It has a
single **"Use CDN"** checkbox; on change it also clears the library discovery cache
(`library.discovery.collector`) so the new source takes effect.

### Scriptable

```php
\Drupal::configFactory()->getEditable('datatables.settings')->set('use_cdn', TRUE)->save();
// after toggling, clear caches so the library source updates:
\Drupal::service('library.discovery.collector')->clear();
```

`drush cget datatables.settings use_cdn`.

## Installing the library locally

Recommended via Asset Packagist / Composer, e.g.
`composer require npm-asset/datatables.net-dt:^2.3.8` with an `installer-paths` entry mapping it
into `web/libraries/datatables`. Then leave `use_cdn: false`.

## Requirements check

`hook_requirements()` (runtime) reports the library status on the status report
(`/admin/reports/status`): if `use_cdn` is true it reports "Loaded via CDN (v2.3.8)"; otherwise
it checks `DRUPAL_ROOT/libraries/datatables/datatables` for the essential CSS/JS and a compatible
version, flagging an error if assets are missing.
