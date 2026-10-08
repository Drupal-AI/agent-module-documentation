<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The `bs_slider_entity_reference_revisions` formatter

```bash
composer require drupal/bs_slider drupal/entity_reference_revisions
drush en bs_slider_entity_reference_revision -y
```

## Plugin

`BsSliderEntityReferenceRevisionFormatter`
(`src/Plugin/Field/FieldFormatter/BsSliderEntityReferenceRevisionFormatter.php`):

- `@FieldFormatter(id = "bs_slider_entity_reference_revisions", label = "BS Slider", field_types =
  {entity_reference_revisions})`.
- Extends `entity_reference_revisions`' `EntityReferenceRevisionsEntityFormatter` and uses
  `Drupal\bs_slider\Plugin\Field\FieldFormatter\BsSliderFormatterTrait` (which holds the
  `bs_slider_configuration.manager` as `$this->manager` and builds the optionset select).
- Constructor DI: adds `logger.factory`, `entity_display.repository`, and
  `bs_slider_configuration.manager` to the ERR base constructor.

## Settings

`defaultSettings()` = `['bs_slider' => 'default', 'link' => FALSE] + parent::defaultSettings()`.

- `bs_slider` — the optionset id (select added by `settingsForm()` via the trait's
  `getSettingsFormElements()`, `#required`).
- `link` + all inherited ERR settings (view mode, etc.) from the base formatter.

`settingsForm()` = parent ERR form **plus** the optionset select. `settingsSummary()` = parent
summary plus `BS Slider: {label}`.

## Render path

`viewElements($items, $langcode)`:

1. Early return `[]` if the field is empty.
2. `$build = parent::viewElements($items, $langcode)` — renders each referenced revisioned entity
   (respecting the referenced entity's own view mode and access).
3. Loads the plugin (`manager->getPlugin($bs_slider)`) and optionset
   (`manager->entityLoad($bs_slider)`).
4. `$plugin->view($build, $bs_slider, ['view_mode' => $this->viewMode])` — wraps the items in the
   slider render array (`#theme => bs_slider`).

## Config example (view display)

```yaml
# core.entity_view_display.node.page.default
content:
  field_paragraph_slides:          # an entity_reference_revisions field
    type: bs_slider_entity_reference_revisions
    label: hidden
    settings:
      bs_slider: homepage_carousel
      view_mode: default
      link: false
```

## Notes

- The referenced entities are rendered by ERR first, so their access and view-mode handling are
  honored before the slider wraps them.
- Requires an enabled library submodule to supply the plugin named by the chosen optionset.
