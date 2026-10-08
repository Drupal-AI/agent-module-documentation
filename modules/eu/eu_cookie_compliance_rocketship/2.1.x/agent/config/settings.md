<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Settings, config objects, install & uninstall

## Install & enable

```bash
composer require drupal/eu_cookie_compliance_rocketship
drush en eu_cookie_compliance_rocketship -y
```

Pulls in the three required modules (`eu_cookie_compliance`, `cookie_content_blocker`,
`eu_cookie_compliance_gtm`). The `iframe` and `video_embed_field` modules are only needed if you use
the matching formatters — the module does not depend on them, it only *alters* their formatters when
present (`hook_field_formatter_info_alter`).

## Settings form / route / permission

- Route: `eu_cookie_compliance_rocketship.admin_settings_form`
  → path `/admin/config/system/eu-cookie-compliance/rocketship`, `_admin_route: TRUE`.
- Requirement: `_permission: 'administer rocketship eucc settings'` (the module's only permission,
  `eu_cookie_compliance_rocketship.permissions.yml`).
- Form class: `Drupal\eu_cookie_compliance_rocketship\Form\SettingsForm` (extends `ConfigFormBase`,
  form id `eu_cookie_compliance_rocketship_form`).
- Surfaced as a local task tab and a menu link under the EU Cookie Compliance settings
  (`.links.task.yml` base_route `eu_cookie_compliance.settings`; `.links.menu.yml` parent
  `eu_cookie_compliance`). Note: `data.json` `configure` is null because `.info.yml` declares no
  `configure:` key.

## Config object: `eu_cookie_compliance_rocketship.settings`

The only editable config of the form (`getEditableConfigNames()`), schema in
`config/schema/eu_cookie_compliance_rocketship.settings.yml`, install defaults in
`config/install/eu_cookie_compliance_rocketship.settings.yml`:

| Key | Type | Install default | Effect |
|---|---|---|---|
| `css_structural` | boolean | `1` | Attach library `eu_cookie_compliance_rocketship/css_structural` (basic CSS). |
| `css_extra` | boolean | `1` | Attach library `eu_cookie_compliance_rocketship/css_extra` (design CSS). |
| `language_switcher` | boolean | `1` | Render the in-popup language switcher (see theming doc). |
| `accept_all_label` | label | `"Accept all cookies"` | Text of the injected Accept-all button. |
| `manage_categories_label` | label | `"Manage cookies"` | Text of the Manage-cookies button. |
| `accept_selection_label` | label | `"Save preferences"` | Text of the Save-preferences button. |
| `accept_minimal_label` | label | `"Continue with essential cookies"` | Text of the Accept-necessary-only button. |

`submitForm()` saves all seven keys, then invalidates cache tag
`eu_cookie_compliance_rocketship:attachments` **and** the cache tags of `eu_cookie_compliance.settings`
(because the language switcher is rendered to a cached string inside the popup variables).

The form is config-translatable: `eu_cookie_compliance_rocketship.config_translation.yml` exposes
`eu_cookie_compliance_rocketship.settings` on the settings route.

## Install-time config seeding (`hook_install`)

`eu_cookie_compliance_rocketship_install($is_syncing)`:

- Returns early when `$is_syncing` (config import) so it never clobbers imported config.
- Otherwise it reads the shipped object
  `eu_cookie_compliance_rocketship.eu_cookie_compliance.settings`
  (`config/install/…`, an opinionated `eu_cookie_compliance.settings` payload: popup text, EN copy,
  `method: categories`, exclude paths, etc.) and **overwrites** the live `eu_cookie_compliance.settings`
  with it (`$settings->setData($cfg->get())->save()`), then deletes the temporary object.
- Repeats for each installed language, reading
  `config/install/language/<langcode>/eu_cookie_compliance_rocketship.eu_cookie_compliance.settings`
  (DE/FR/NL shipped) into the language config override for `eu_cookie_compliance.settings`.
- Operational note: enabling this module **replaces** any existing EU Cookie Compliance popup
  settings with the Rocketship defaults. Enable it on a fresh/Rocketship site, or re-apply your own
  `eu_cookie_compliance.settings` afterwards. Installing from config sync avoids the overwrite.

The four cookie categories (`eu_cookie_compliance.cookie_category.{necessary,functional,analytics,
marketing}`, each with DE/FR/NL translations) install as normal `config/install` config. Each carries
`eu_cookie_compliance_gtm.gtm_data` third-party settings (e.g. `necessary: '@status'`) and a
`checkbox_default_state` (`necessary` = `required`).

## Uninstall

`hook_uninstall` lists all `eu_cookie_compliance.cookie_category.*` config and deletes it — including
categories added after install. It does **not** restore the pre-install `eu_cookie_compliance.settings`.

## Update hooks

- `update_8001`: sets `language_switcher = 1`.
- `update_8002`: sets the four button-label defaults (`accept_all_label` etc.).
