<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configuration, mapping format & helper functions

## Install & enable

```bash
composer require drupal/env_link_fixer
drush en env_link_fixer -y
```

No composer requirements beyond `drupal/core` (`composer.json` `require` = core `^9.2 || ^10 || ^11`;
the `.info.yml` `core_version_requirement` is `^8 || ^9 || ^10 || ^11`). `.info.yml` declares **no
module dependencies**, but the field widget/formatter only apply to **`link`** fields (core `link`
module) and the filter extends core `filter`.

## Settings form

- Route `env_link_fixer.admin_form` -> path `/admin/config/system/env_link_fixer`, form
  `\Drupal\env_link_fixer\Form\SettingsForm`, permission `administer env_link_fixer settings`.
- Menu link `env_link_fixer.admin_form` under `system.admin_config_system`
  (`env_link_fixer.links.menu.yml`), weight -10.
- `SettingsForm` (extends `ConfigFormBase`, form id `env_link_fixer_settings`) edits config object
  `env_link_fixer.settings`, exposing one field: **`mapping`** (textarea). `submitForm()` saves
  `$form_state->getValue('mapping')` into `env_link_fixer.settings:mapping`.

## Config object & schema

- `config/install/env_link_fixer.settings.yml` ships `mapping: ''` and `domain_names: ''` (the latter is
  a leftover default; only `mapping` is used by the settings form and read by the code).
- `config/schema/env_link_fixer.schema.yml` defines `env_link_fixer.settings` (`config_object`) with
  key `mapping` (string), and `filter_settings.env_link_fixer_strip_domain` with key `domain_names`
  (string) — the per-filter-instance setting.

## Mapping storage format

`mapping` is a newline-separated string, parsed by `env_link_fixer_convert_storage_to_array()`:

- A line `hostname|value` maps that hostname to the domain(s) in `value`.
- A line with **no `|`** uses the current request hostname (`env_link_fixer_get_hostname()`) as the key.
- `value` may be a single domain, or several comma-separated domains (split and trimmed).

Example (site-wide config `mapping`):

```
local.example.com|www.example.com,example.com
```

## Helper functions (`env_link_fixer.module`)

- `env_link_fixer_standard_mapping()` — reads config `env_link_fixer.settings:mapping`, converts to an
  array, then `array_merge_recursive` with `env_link_fixer_custom_mappings()`. Statically cached.
- `env_link_fixer_domains_to_strip($hostname='', $domain_names=[])` — returns the domain list for a
  hostname; defaults hostname to the request host and `$domain_names` to the standard mapping.
- `env_link_fixer_get_hostname()` — `\Drupal::request()->getHost()`.
- `env_link_fixer_convert_storage_to_array($string)` — parses the storage format above (statically
  cached by md5 of the input).
- `env_link_fixer_strip_domain($text, $hostname='', $domain_names=[])` — the HTML rewriter (see
  [../filters/strip_domain.md](../filters/strip_domain.md)).
- `env_link_fixer_disabled()` — `Settings::get('env_link_fixer_disabled', FALSE)`; when TRUE every
  entry point short-circuits and returns input unchanged.
- `env_link_fixer_custom_mappings()` — reads `Settings::get('env_link_fixer_custom_mappings', [])` and
  normalizes each value to an array (comma-split strings).

## settings.php overrides

Disable all logic (recommended on production, so output is untouched):

```php
$settings['env_link_fixer_disabled'] = TRUE;
```

Add environment-specific mappings, merged with config:

```php
$settings['env_link_fixer_custom_mappings'] = [
  'local.example.com' => 'www.example.com,example.com',
  'local.example.net' => ['www.example.net', 'example.net'],
];
```
