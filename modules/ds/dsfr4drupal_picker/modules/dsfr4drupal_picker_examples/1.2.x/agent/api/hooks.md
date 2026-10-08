<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Example hook implementations

All logic lives in `src/Hook/Dsfr4drupalPickerExamplesHooks.php` (autowired via `dsfr4drupal_picker_examples.services.yml`; procedural `#[LegacyHook]` wrappers in `dsfr4drupal_picker_examples.module` delegate to it). Enable the submodule to see the effects; nothing is written to config or content.

## Install / enable
- `drush en dsfr4drupal_picker_examples -y` (pulls in `dsfr4drupal_picker`).
- No configuration, no update hooks, no permissions.

## Hooks and what each shows

- `library_info_alter($libraries, $extension)` — when `$extension === 'dsfr4drupal_picker'`, appends `modules/examples/css/icons.custom.css` to the parent's `dsfr.icons` library CSS. Pattern for injecting your own glyph stylesheet into the picker.

- `dsfr4drupal_picker_icons()` — returns `['custom' => ['example-icon-thumbsup', 'example-icon-thumbsdown']]`, i.e. a new icon group `custom` with two glyphs. Provider hook for adding icons.

- `dsfr4drupal_picker_icons_alter(&$icons)` — `unset($icons['buildings'])`, removing the built-in `buildings` icon group. Alter hook for hiding groups.

- `dsfr4drupal_picker_pictograms()` — returns `['custom' => ['custom/drupal-logo']]`, a new pictogram group `custom` with one entry. Provider hook for adding pictograms.

- `dsfr4drupal_picker_pictograms_alter(&$icons)` — `unset($icons['buildings'])`, removing the built-in `buildings` pictogram group.

- `dsfr4drupal_picker_pictogram_path_alter($pictogram, &$path)` — splits `$pictogram` on `/`; when the group is `custom`, rewrites `$path` to `core/misc/logo/<filename>.svg`. Shows how a custom pictogram identifier is mapped to an actual SVG file for rendering.

## The example stylesheet
`css/icons.custom.css` defines `.example-icon-thumbsup::before { content: "👍" }` and `.example-icon-thumbsdown::before { content: "👎" }`, plus `fr-icon--lg/sm/xs` size overrides. The `.libraries.yml` `icons` library also references this file. Glyphs are rendered purely by CSS `::before` content on a class name.
