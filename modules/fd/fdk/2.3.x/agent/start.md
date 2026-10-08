<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Field Display Kit (fdk) — agent index

Adds per-display fine-tuning of field output (label text/tag, whole-field wrapper, per-item wrapper,
classes, attributes, item linking, delimiter) via **field formatter third-party settings** plus an FDK
`field.html.twig` override. Version 2.3.0. Core `^9.3 || ^10 || ^11`. License GPL-2.0-or-later.

## Dependencies

- No required module or Composer dependencies (no `composer.json` shipped; `fdk.info.yml` lists none).
- **Optional** `drupal/token`: when enabled, the settings form shows token-tree links and tokens are
  replaced in attribute values and in the item link `href` (`\Drupal::moduleHandler()->moduleExists('token')`).

## What it provides (from source)

- **Formatter third-party settings** — `fdk_field_formatter_third_party_settings_form()` and
  `fdk_field_formatter_settings_summary_alter()` (in `fdk.module`) delegate to
  `FDKHelper::settingsForm()` / `FDKHelper::formatter_settings_summary_alter()` (`src/FDKHelper.php`).
  Settings stored under config schema `field.formatter.third_party.fdk` (`config/schema/fdk.schema.yml`).
  → [config/formatter-settings.md](config/formatter-settings.md)
- **Field rendering** — `fdk_preprocess_field()` maps the saved settings onto the field render variables,
  and FDK's `templates/field.html.twig` consumes them (`field_wrapper_tag`, `label_tag`,
  `field_item_wrapper_tag`, `field_delimiter`). `fdk_theme_registry_alter()` swaps FDK's template in for
  core's — only when the field template still comes from `core`. → [theming/field-rendering.md](theming/field-rendering.md)
- **Report route** `fdk.reports` — path `/admin/reports/fdk`, controller
  `\Drupal\fdk\Controller\FDKController::report()`, permission `administer site configuration`
  (`fdk.routing.yml`, `fdk.links.menu.yml`). Lists field templates in active themes that are missing
  FDK's variables (`FDKHelper::getIncompatibleFieldTemplates()`). → [reports/incompatible-templates.md](reports/incompatible-templates.md)
- **Theme hook** `fdk_settings_summary` (`fdk_theme()`) rendered by
  `templates/fdk-settings-summary.html.twig` for the formatter settings summary.
- **`hook_form_alter`** — on Layout Builder forms and `entity_view_display_edit_form`, adds a warning
  message linking to the report when incompatible templates may exist.

## What it does NOT provide

No permissions of its own, no settings form / config route (`configure` is null), no config/install,
no entities, no plugin types, no services, no Drush. The only route is the read-only report.

## Install / operate

1. `composer require drupal/fdk` then `drush en fdk -y` (optionally enable `token`).
2. Configure per field on any bundle's **Manage display** (or in Layout Builder) — open a field's
   formatter settings and use the **Field Display Kit Settings** section. No central config page.
3. If a theme overrides `field.html.twig`, base that override on FDK's template; check
   `/admin/reports/fdk` for incompatible templates.
