<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Settings form, config, routes, collection page (dsfr4drupal_colors)

## Routes (`dsfr4drupal_colors.routing.yml`)

| Route | Path | Handler | Permission |
|-------|------|---------|------------|
| `dsfr4drupal_colors.collection` | `/admin/config/user-interface/dsfr4drupal-colors` | `ColorsController::collection` | `administer site configuration` |
| `dsfr4drupal_colors.settings` | `/admin/config/user-interface/dsfr4drupal-colors/settings` | `SettingsForm` | `administer site configuration` |

Menu link `dsfr4drupal_colors.collection` sits under *Configuration → User interface*
(`system.admin_config_ui`); `settings` is its child. Local tasks (`.links.task.yml`) expose
*Colors* and *Settings* tabs under the collection route.

## Settings form — `SettingsForm`

`src/Form/SettingsForm.php` extends `ConfigFormBase` (marked `@internal`).
`getFormId()` = `dsfr4drupal_colors_settings_form`; editable config `dsfr4drupal_colors.settings`.

- Single element `scheme`: radios `light` / `dark`, required, bound with `#config_target`
  `dsfr4drupal_colors.settings:scheme`. Controls whether the widget/box form palette renders in
  the light or dark DSFR colors (read by `ColorBoxElement::preRenderColorBox`).

## Config object — `dsfr4drupal_colors.settings`

- `config/install/dsfr4drupal_colors.settings.yml`: `scheme: light`.
- `config/schema/dsfr4drupal_colors.schema.yml`: `dsfr4drupal_colors.settings` (config_object) with
  string `scheme`. The file also declares field-settings / value / widget / formatter schemas
  (`field.field_settings.color_field_type`, `field.value.dsfr4drupal_color_field_type`,
  `field.widget.settings.dsfr4drupal_color_field_widget_box`,
  `field.formatter.settings.dsfr4drupal_color_field_formatter_{css,swatch}`).

## Collection page — `ColorsController::collection`

`src/Controller/ColorsController.php` extends `ControllerBase`; injects the helper service.
Read-only render array: a count paragraph plus two `details` (light mode open, dark mode closed),
each an `item_list` of every available color (`ColorsHelper::getColorsAvailable()`), rendering the
`color-swatch` component (30×30) next to the color name. The light/dark containers carry
`ColorsHelperInterface::CLASS_THEME_LIGHT` / `CLASS_THEME_DARK`. Attaches library
`dsfr4drupal_colors/collection`. Takes no user input.

## Configure (operate)

1. Enable: `drush en dsfr4drupal_colors` (installs the colors CSS file — see api/helper.md).
2. Ensure the DSFR asset library is at `libraries/dsfr/dist/`.
3. Visit `/admin/config/user-interface/dsfr4drupal-colors` to preview the palette, and *Settings*
   to choose the light/dark form palette.
