<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Defining components (patterns) and field rendering

Component blocks does not define components itself — it derives blocks from **UI Patterns 1.x**
definitions. Declare patterns in a `MODULE_OR_THEME.ui_patterns.yml` in any custom module or theme,
then `drush cr` so the deriver discovers them and creates the matching blocks.

## Pattern definition (`*.ui_patterns.yml`)

```yaml
image_panel:
  label: Image Panel
  use: "@some_namespace/layout/src/templates/patterns/section-media.twig"
  variants:
    default:
      label: Default
  fields:
    title:
      label: Title
    body:
      label: Body
    media:
      label: Media
    tag:
      label: Wrapper tag
      ui: false        # not editable in the block form; uses `default`
      default: div
  settings:
    modifier:
      type: textfield
      label: Modifier
  libraries:
    - some_theme/image-panel
```

Keys the block plugin consumes (read via `plugin.manager.ui_patterns` → the pattern definition):

| Key | Effect in component_blocks |
| --- | --- |
| `label` | Used in the derivative `admin_label` ("<label> with fields from <entity>"). |
| `fields` | Each becomes a **Source** row in the block form; the field name must match the Twig variable. |
| `fields.<f>.ui: false` | Field is hidden from the block form and forced to its `default` (fixed). |
| `fields.<f>.default` | Default value for the field (used for `ui: false` fields and as the initial fixed value). |
| `variants` | If present, a **Variant** select appears; the chosen key is passed as `#variant`. |
| `settings` | Editable only when `ui_patterns_settings` is installed; passed as `#settings`. |
| `use` | The Twig template (a `@namespace/…` reference or a path). Rendered by UI Patterns' `#type => pattern`. |
| `libraries` | Attached to the block render array when it renders. |

Each `fields.<name>` key must equal the variable used in the component's Twig template, e.g.
`{{ title }}`, `{{ body }}`, `{{ media }}`.

## Field render theme hook

`component_blocks.module` implements `hook_theme()` registering `field__component_block` (render
element `element`, **base hook `field`**), template `templates/field--component-block.html.twig`. When a
pattern field is sourced from an entity field, `build()` wraps the formatter output as
`['#theme' => 'field__component_block'] + $formatter_output` so the field's items render inside the
component without the standard field wrapper. The template outputs contextual links (`title_suffix`) then
each item's `content` inside `{% apply spaceless %}`.

## Block markup suggestion (outside Layout Builder)

`hook_theme_suggestions_block_alter()` (in the `.module`): when a `component_blocks` block is rendered
**not** in a Layout Builder route (no `section_storage` route parameter), it adds a `block__bare`
theme suggestion and pushes the block `#attributes` down onto the content, so the component markup is
emitted without the default block chrome. In Layout Builder it returns early and leaves default block
theming in place.

## Discovery notes

- Only **content** entity types produce derivatives (one block per pattern per content entity type).
- New or changed pattern definitions require a cache rebuild before their blocks appear.
- `test_dependencies` reference `components`, `ui_patterns_library`, `ui_patterns_settings` — the
  ecosystem the module is built against; `ui_patterns_settings` unlocks the pattern `settings` form.
