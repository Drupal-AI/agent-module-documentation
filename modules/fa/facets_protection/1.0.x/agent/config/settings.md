<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configuration, route & permission

## Settings form

- File/class: `src/Form/SettingsForm.php` → `Drupal\facets_protection\Form\SettingsForm extends ConfigFormBase`.
- Form id: `facets_protection_settings_form`. Editable config: `facets_protection.settings`.
- Route: `facets_protection.settings` (`facets_protection.routing.yml`), path
  `/admin/config/search/facets/facets_protection`, `_form` = the SettingsForm, `_title` =
  "Facets Protection Settings", `options._admin_route: TRUE`.
- Admin menu link: `facets_protection.settings` (`*.links.menu.yml`) parented under
  `entity.facets_facet.collection` (the Facets admin collection), `menu_name: admin`.

## Permission

`facets_protection.permissions.yml` declares one permission:

- `administer facets_protection settings` — title "Administer Facets Protection",
  `restrict access: true`. It is the sole requirement (`_permission`) on the settings route. Grant only
  to trusted administrators. The module defines no other permission and no per-visitor exemption — the
  token check applies uniformly to every request that reaches the subscriber.

## Config object `facets_protection.settings`

Defaults in `config/install/facets_protection.settings.yml`; schema in
`config/schema/facets_protection.schema.yml` (type `config_entity`):

| Key | Type | Default | Meaning |
|-----|------|---------|---------|
| `enabled` | boolean | `true` | Master on/off. When false, the subscriber returns immediately and never blocks. |
| `ttl` | integer | `1800` | Token time-to-live in seconds. Current **and** previous token are accepted, so effective max validity is `2 × ttl`. |
| `template` | string | `facets_protection_blocking_site` | Which blocking template renders — `facets_protection_blocking_site` ("Link changed") or `facets_protection_blocking_human_site` ("Approve Human"). See [../theming/blocking-pages.md](../theming/blocking-pages.md). |

Form elements map 1:1 to these keys (`buildForm()`/`submitForm()`): `enabled` (checkbox), `ttl`
(number), `template` (select with the two options above). Values are read back with `?? <default>`
throughout the code, so a fresh install behaves as if enabled with ttl 1800 and the default template
even before the form is saved.

## Install / uninstall

- `facets_protection.install`: `hook_uninstall()` deletes state key `facets_protection_data` and calls
  `Cache::invalidateTags(['facets_protection'])`. No schema/update hooks.
- Enabling requires `drupal/facets`. After changing `ttl` or `template`, clear caches so facet blocks
  re-render with the current token (the block cache uses the `facets_protection` cache context/tag).
