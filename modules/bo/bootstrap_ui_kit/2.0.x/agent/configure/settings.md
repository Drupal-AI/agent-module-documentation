# Settings form, config keys & permissions

## Settings form — route `bootstrap_ui_kit.settings`

Path `/admin/appearance/bootstrap_ui_kit/settings`, form
`Drupal\bootstrap_ui_kit\Form\BootstrapUiKitSettingsForm` (`ConfigFormBase`, form id
`bootstrap_ui_kit_settings_form`), requires permission `administer site configuration`. This is the
`configure:` route in `.info.yml` and the menu link `bootstrap_ui_kit.settings` under
*Configuration → User interface*. Editable config: **`bootstrap_ui_kit.settings`**.

Fields (`BootstrapUiKitSettingsForm::buildForm`):

| Field | Config key | Type | Notes |
|---|---|---|---|
| Enable Developer Kit | `enable_dev_kit` | boolean | Gates the "dev mode" code-snippet modals on `/ui-kit`. Only takes effect for users who also hold `access bootstrap ui kit dev mode`. |
| Icons source folder | `icons_source_folder` | string | A path **relative to `DRUPAL_ROOT`** (leading slash added, trailing stripped on save). The folder is scanned with `DirectoryIterator` for `*.svg`; each filename (minus `.svg`) becomes a selectable icon. Default `/modules/contrib/bootstrap_ui_kit/vendor/twbs/bootstrap-icons/icons`. |
| Icons sprite file | `icons_sprite_file` | string | Path (leading slash normalised) to an SVG sprite. Rendered inline at page bottom by `hook_preprocess_html` (see below). Default `/modules/contrib/bootstrap_ui_kit/vendor/twbs/bootstrap-icons/bootstrap-icons.svg`. |
| Icon multiselect grid | `selected_icons` | sequence(string) | The checkbox grid is rendered client-side by `js/bootstrap_ui_kit.admin_icons.js` from `drupalSettings.bootstrap_ui_kit.icons`; on submit, `submitForm` walks `$form_state->getUserInput()` for each available icon name and stores the checked ones. Empty ⇒ all icons in the source folder are shown on the iconography section. |

`submitForm` writes all four keys to `bootstrap_ui_kit.settings`. The attached admin library is
`bootstrap_ui_kit/bootstrap_ui_kit.admin_icons`; `drupalSettings.bootstrap_ui_kit` receives `icons`,
`icons_total`, `icons_sprite_file`, `selected_icons`.

## Sprite injection — `hook_preprocess_html`

`bootstrap_ui_kit_preprocess_html()` (`.module`) reads `icons_sprite_file`; if the file
`is_readable()`, its contents are `file_get_contents()`-loaded and injected into
`$variables['page_bottom']['bootstrap_ui_kit_icons']` as an `inline_template`
(`<span class="d-none bootstrap-ui-kit__icons-sprite">…</span>`). This runs on **every** page so the
SVG `<symbol>` sprite is available site-wide for `<use href="#icon">` references.

## Iconography loading — `hook_preprocess_page__ui_kit`

`bootstrap_ui_kit_preprocess_page__ui_kit()` reads `icons_source_folder`, iterates the directory for
`*.svg`, and sets `$variables['iconography_set']` to either the intersection with `selected_icons`
(when any are selected) or the full list.

## `bootstrap_ui_kit.settings` config schema

Schema type is a `config_object` (`config/schema/bootstrap_ui_kit.schema.yml`). Top-level keys:
`enable_dev_kit` (boolean), `icons_source_folder` (string), `icons_sprite_file` (string),
`selected_icons` (sequence of string), `glossary` (sequence of `bootstrap_ui_kit.glossary_group`).
The full `glossary` sub-schema (groups → sections → components → props/slots) is documented in
[glossary.md](glossary.md). Install defaults ship in `config/install/bootstrap_ui_kit.settings.yml`
with two seeded groups (`foundations`, `components`) and their empty sections.

## Permissions (`bootstrap_ui_kit.permissions.yml`)

| Permission | Grants |
|---|---|
| `access bootstrap ui kit` | View the `/ui-kit` page (route `bootstrap_ui_kit.ui_kit`). Checked in `hook_preprocess_page__ui_kit` to set the `access` template flag. |
| `access bootstrap ui kit dev mode` | Reveals the developer modal with example code snippets on `/ui-kit`; combined with `enable_dev_kit` config it sets the `dev_mode` flag. |

All three admin forms (`bootstrap_ui_kit.settings`, `.glossary`, `.sections`, `.component`) are gated
by `administer site configuration`, not by the two module permissions above. The template also exposes
`can_edit_ui_kit = currentUser has 'administer site configuration'`.
