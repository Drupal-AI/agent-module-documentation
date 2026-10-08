<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Drush commands (d7_import_webform)

`src/Commands/D7ImportWebformCommands.php`, registered in `drush.services.yml` (service
`d7_import_webform.commands`, constructed with `@d7_import_webform.webform_importer`, tag
`drush.command`). CLI only.

| Command | Alias | Argument | Purpose |
|---------|-------|----------|---------|
| `d7-import:webforms` | `d7iwf` | webforms.xml | Import D7 webforms as D11 Webform entities |
| `d7-import:webforms-purge` | `d7iwfp` | — | Delete **all** Webform config entities on the site |

## Install / enable

```bash
ddev composer require drupal/webform
ddev drush en d7_import_webform -y   # also enables base d7_import
```

## Usage

```bash
# standalone
ddev drush d7-import:webforms /path/to/export/webforms.xml

# or as part of the full parent import (auto-runs this stage if enabled)
ddev drush d7-import:all /path/to/export/

# start over
ddev drush d7-import:webforms-purge
```

## XML loading

`loadXmlFile()` mirrors the parent module: `file_get_contents`, strip invalid XML 1.0 control
chars (`preg_replace('/[\x00-\x08\x0B\x0C\x0E-\x1F]/', '', …)`), then `\DOMDocument::loadXML()`
with `libxml_use_internal_errors(TRUE)` and line-by-line error logging. `displayResult()` prints
imported/skipped counts and per-error warnings.

## Notes

- `d7-import:webforms-purge` deletes **every** Webform entity, not only imported ones — it is a
  blanket wipe. The importer itself never overwrites an existing form (it skips by id), so purge
  is the way to force a re-import.
- Diagnostics go to the `d7_import_webform` log channel (`drush ws`).
