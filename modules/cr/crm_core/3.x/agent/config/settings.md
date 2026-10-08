<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# CRM Core — general settings & CRM theme

## Enable

`drush en crm_core -y`. The base module has no module dependencies. In practice you also enable
`crm_core_contact` (and others) to get any entities.

## Settings form

`Form\SettingsForm` (`getFormId()` = `crm_core_settings_form`), route `crm_core.settings` at
`/admin/config/crm-core/settings`, permission `administer crm-core`. It edits the single config
object `crm_core.settings`.

- One field: **CRM Theme** → form key `crm_core_custom_theme`, a select of all enabled themes
  plus a `'' => Default` option. Submitted into `crm_core.settings:custom_theme`.
- The form builds its option list from `theme_handler->listInfo()` (only `status == 1` themes).

## Config object

`crm_core.settings` (schema `config_object`):

| Key | Type | Default | Meaning |
|-----|------|---------|---------|
| `custom_theme` | string | `''` | Machine name of the theme to force on `/crm-core` pages, or empty for the site default. |

## Theme negotiator

`Theme\CrmCoreNegotiator` (service `theme.negotiator.admin_theme.crm_core`, tag
`theme_negotiator` priority `-39`):

- `applies()` returns TRUE only when `custom_theme` is non-empty **and** the current route's path
  begins with `/crm-core`.
- `determineActiveTheme()` returns the configured `custom_theme` (or NULL).

So setting a CRM theme swaps the theme for every `/crm-core/...` page (contact/activity listings
and forms) without affecting the rest of the site. Bundle-type admin pages live under
`/admin/structure/crm-core` and `/admin/config/crm-core`, which do **not** start with `/crm-core`
and therefore keep the normal admin theme.
