<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# imagestyles — settings form & config object

## Route & access

`imagestyles.routing.yml`:

- Route id `imagestyles.imagestyles_settings`, path `admin/config/media/image-styles/imagestyles`.
- `_form: \Drupal\imagestyles\Form\SettingsForm`, `_title: 'Image Styles Display'`.
- `requirements: _permission: 'access administration pages'` (a broad admin permission — not a
  dedicated one; the module ships no `*.permissions.yml`).
- `options: _admin_route: TRUE`.
- Menu link `imagestyles.links.menu.yml` → title "Image Styles Display", `parent:
  entity.image_style.collection`, `weight: 99` (a tab/child under Admin → Config → Media → Image
  styles). Note: `imagestyles.info.yml` has **no `configure:` key**, so this form is reached via
  the menu link, not the module-list "Configure" link.

## The form: `SettingsForm`

`src/Form/SettingsForm.php`, extends `Drupal\Core\Form\ConfigFormBase`.

- `getFormId()` → `imagestyles_settings`.
- `getEditableConfigNames()` → `['imagestyles.settings']`.
- `buildForm()` builds `$options` from `ImageStyle::loadMultiple()` (key = style machine name,
  value = `$style->label()`), then adds `$options['original'] = 'Original'`. Renders a single
  `#type => 'checkboxes'` element `expanded_styles`, `#default_value` = current
  `imagestyles.settings:expanded_styles` (`?? []`).
- `submitForm()` calls `parent::submitForm()` then saves
  `->set('expanded_styles', $form_state->getValue('expanded_styles'))`.

## Config object: `imagestyles.settings`

- Single key: **`expanded_styles`** — a map of `{style_machine_name|original: 0|"style_machine_name"}`
  as produced by a Drupal `checkboxes` element (checked entries hold the option key, unchecked
  hold `0`). Consumed by the preprocess hook as `!empty($config[$style_name])` to decide whether a
  style's `details` element opens by default.
- **No config schema** ships (`config/schema/` does not exist), so Drupal emits a "no schema"
  notice for this object under strict schema checking (e.g. in tests). **No `config/install`
  default** ships either — the object exists only after the form is first saved; until then the
  media page treats it as empty (all previews collapsed).

## Reset / inspect via Drush

```
drush config:get imagestyles.settings
drush config:set imagestyles.settings expanded_styles.thumbnail thumbnail   # expand one style
drush config:delete imagestyles.settings                                     # back to all-collapsed
```
