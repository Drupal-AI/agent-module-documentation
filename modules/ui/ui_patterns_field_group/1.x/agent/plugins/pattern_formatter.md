<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Field-group formatter: `pattern_formatter`

`src/Plugin/field_group/FieldGroupFormatter/PatternFormatter.php`

```php
@FieldGroupFormatter(
  id = "pattern_formatter",
  label = @Translation("Pattern"),
  description = @Translation("Wrap fields as a pattern."),
  supported_contexts = { "view" }
)
```

`class PatternFormatter extends FieldGroupFormatterBase implements ContainerFactoryPluginInterface`
and `use PatternDisplayFormTrait` (from `ui_patterns`). `supported_contexts = {"view"}` means it is
offered on **entity view displays only**, not on entity forms.

`create()` injects `plugin.manager.ui_patterns` (`UiPatternsManager`),
`plugin.manager.ui_patterns_source` (`UiPatternsSourceManager`) and `module_handler`; the constructor
also instantiates `Utility\EntityFinder`.

## Methods

| Method | Behavior |
| --- | --- |
| `settingsForm()` | Removes the base `id` and `classes` elements. If the group has children, calls `PatternDisplayFormTrait::buildPatternDisplayForm($form, 'entity_display', $context, $settings)` with `context = {entity_type, entity_bundle, entity_view_mode, limit: <group children>}` — so only the group's own children are offered as sources. If no children, shows the "add fields and save first" message. |
| `settingsSummary()` | Adds `Pattern: <label>` (pattern definition's label, or "None"). |
| `defaultContextSettings($context)` | Defaults `pattern => ''`, `pattern_mapping => []`, `pattern_variant => ''`. |
| `preRender(&$element, $rendering_object)` | Calls parent, then `preRenderGroup($element, $this->group->group_name, $rendering_object)`. |
| `preRenderGroup(&$element, $group_name, $rendering_object)` | Recursive mapping engine (below). |
| `addRenderContext(&$element, $format_settings)` | Turns the element into a pattern render array (below). |

## Runtime: how a group becomes a pattern

`preRenderGroup()` looks up the group in `$rendering_object['#fieldgroups'][$group_name]`, then:

- **If `format_type == 'pattern_formatter'`** — iterates `format_settings['pattern_mapping']`. For
  each mapped field:
  - if `plugin == 'fieldgroup'` and `source === '_label'` → renders the group label as
    `['#markup' => $group->label]`;
  - if `plugin == 'fieldgroup'` (other) → **recurses** into the nested group
    (`preRenderGroup($element[$source], $source, ...)`), so nested pattern groups render inside-out;
  - moves the source's render array into `$element['#fields'][$destination][$source]`.
  Then calls `addRenderContext()`.
- **Otherwise** — falls back to core `field_group_pre_render($element, $group, $rendering_object)`,
  so non-pattern groups behave normally.

`addRenderContext()` sets on the element:

- `#type = 'pattern'`, `#id = format_settings['pattern']`, optional `#variant`,
  `#multiple_sources = TRUE`;
- `#context` = `type: 'field_group'`, `group_name`, `entity_type`, `bundle`, `view_mode`, and
  `entity` (resolved by `EntityFinder::findEntityFromFields($element['#fields'])`, which recursively
  finds the first `#object` that is a `ContentEntityBase`);
- `#pattern_pre_rendered = TRUE` — a guard so a group shared across nested renders is only processed
  once (nested groups can render in any order).

## EntityFinder utility

`src/Utility/EntityFinder.php` — `findEntityFromFields(array $fields): ?ContentEntityBase` walks the
fields render array with a `RecursiveIteratorIterator` and returns the first value keyed `#object`
that is a `ContentEntityBase`, so the pattern context carries the entity being displayed.
