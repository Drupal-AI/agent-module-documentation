<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configuration — canvas_page_metatag.settings

## Install / enable
`drush en canvas_page_metatag -y`. Dependencies (`canvas`, `metatag`,
`metatag_open_graph`, `metatag_facebook`, `metatag_twitter_cards`) enable automatically.
Core `^10.3 || ^11.1`.

## Route & permission
- Route `canvas_page_metatag.settings` → path `/admin/config/search/canvas-page-metatag`,
  `_form: \Drupal\canvas_page_metatag\Form\SettingsForm`.
- Requirement: `_permission: 'administer site configuration'`.
- Menu link `canvas_page_metatag.settings` under `system.admin_config_search`
  (Configuration → Search and metadata).

## Config object
`canvas_page_metatag.settings` (config_object, schema in
`config/schema/canvas_page_metatag.schema.yml`). Five booleans, all default `true`
(`config/install/canvas_page_metatag.settings.yml`):

| Key | Effect when TRUE |
|-----|------------------|
| `expose_basic_fields` | Restore the Basic group as a details section and force `#access = TRUE` on the `description`, `abstract`, `keywords` tags plus Metatag's `preamble`/`tokens`/`image_help`/`intro_text` help elements. |
| `expose_advanced` | Force `#access = TRUE` on the Advanced group and attach the Robots-checkboxes repair. |
| `expose_open_graph` | Leave the Open Graph group visible (when FALSE, forces `#access = FALSE`). |
| `expose_facebook` | Leave the Facebook group visible (when FALSE, forces `#access = FALSE`). |
| `expose_twitter_cards` | Leave the Twitter Cards group visible (when FALSE, forces `#access = FALSE`). |

Note the asymmetry (see `SettingsForm::buildForm`/`submitForm` and the hook): Basic and
Advanced are *opt-in re-exposure* (only shown when TRUE); Open Graph/Facebook/Twitter
Cards are *opt-out hiding* (shown by default, hidden only when FALSE).

## Form
`SettingsForm` extends `ConfigFormBase`, `getFormId() = 'canvas_page_metatag_settings'`,
`getEditableConfigNames() = ['canvas_page_metatag.settings']`. Five checkboxes bound to the
keys above; `submitForm()` casts each to `(bool)` and saves.

## Rendering / defaults
This module never renders tags. Once the Metatag submodules are enabled, Metatag's own
page-attachment code emits the saved tags into `<head>`. Site-wide / per-bundle defaults
are still managed at `/admin/config/search/metatag`; per-page values are edited on the
Canvas page form. Editing a page's metatag values is governed by that page's normal edit
permission, not by this module.
