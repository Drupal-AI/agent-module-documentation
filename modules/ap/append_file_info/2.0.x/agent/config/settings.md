<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Settings, config objects & schema

## Install & enable

```bash
composer require drupal/append_file_info
drush en append_file_info -y
drush cr   # theme override needs a registry rebuild (hook_install resets it)
```

No declared `.info.yml` dependencies; relies on core **`file`** and (for the filter) core
**`filter`**, both normally present. No sub-modules, no permissions of its own, no Drush.

## Site-wide settings form

- Route **`append_file_info.settings`** → `/admin/config/content/append-file-info`
  (`append_file_info.routing.yml`), permission **`administer site configuration`**.
- Menu link `append_file_info.settings` under `system.admin_config_content`
  (*Configuration → Content*), title "Append file info".
- Form `src/Form/AppendFileInfoSettingsForm.php` (`extends ConfigFormBase`, form id
  `append_file_info_settings_form`). One `radios` element **`display`**:
  `both` (default) / `extension` / `filesize`. `submitForm()` writes it to the config object.
- `configure: append_file_info.settings` is declared in `.info.yml` (the "Configure" link on the
  Extend page).

This site-wide value drives the **theme override** (`ThemeHooks::preprocessFileLink` reads
`append_file_info.settings.display`).

## Config objects

**`append_file_info.settings`** — config object, key `display` (string). Read by the theme
override; edited by the settings form.

**`filter_settings.append_file_info_filter`** — the **per-text-format** filter settings, key
`display` (string). Each text format that enables the filter stores its own `display`, independent
of the site-wide object. See [../filters/append-file-info-filter.md](../filters/append-file-info-filter.md).

## Schema (`config/schema/append_file_info.schema.yml`)

```yaml
filter_settings.append_file_info_filter:
  type: mapping
  mapping:
    display: { type: string, label: 'File information display mode' }

append_file_info.settings:
  type: config_object
  mapping:
    display: { type: string, label: 'File information display mode' }
```

No `config/install/` defaults ship; the config object is created on first save (until then the
override falls back to `both` via `?? 'both'`).

## Updates

`append_file_info.install`:
- `hook_install()` → `theme.registry->reset()`.
- `hook_update_8101()` → iterates all `filter.format.*` config and removes a stale
  `filters.append_file_info_filter.settings.title` key left by older versions.
