<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Field-group formatter: `component_formatter`

`src/Plugin/field_group/FieldGroupFormatter/ComponentFormatter.php`

```php
@FieldGroupFormatter(
  id = "component_formatter",
  label = @Translation("Component"),
  description = @Translation("Wrap fields in a component."),
  supported_contexts = { "view" }
)
```

`class ComponentFormatter extends FieldGroupFormatterBase implements ContainerFactoryPluginInterface`
and `use ComponentSettingsFormBuilderTrait` (from `ui_patterns`). `supported_contexts = {"view"}`
means it is offered on entity **view** displays only, not on entity forms.

`create()` injects `plugin.manager.sdc` (as `ComponentPluginManager`) and
`ui_patterns.chain_context_entity_resolver` (`ChainContextEntityResolverInterface`). The constructor
calls the field_group base with `configuration['group'|'settings'|'label']` and keeps the full
`$configuration`.

## Methods

| Method | Behavior |
| --- | --- |
| `settingsForm()` | Parent form, then `unset($form['id'])` and `unset($form['classes'])`. On the `FieldGroupAddForm` it just adds a `#markup` notice ("Component selection and setting are done in the group edit form."). Otherwise it builds injected contexts (`entity_type`, `bundle`, `ui_patterns:form_state`, `ui_patterns_field_group` = `(array) group`), resolves an `entity` context via `chainContextEntityResolver->guessEntity()` when possible, and sets `$form['ui_patterns'] = $this->buildComponentsForm($form_state, $injected_contexts)` — the full UI Patterns component picker. |
| `settingsSummary()` | Lists component definitions from the manager and shows `Component ":component" selected.` (or "No component selected."). |
| `defaultContextSettings($context)` | `parent::defaultContextSettings() + getComponentFormDefault()` → adds `ui_patterns => {component_id, variant_id, slots, props}`. |
| `getComponentSettings()` | Returns `$this->getSettings()` — the adapter the `ComponentSettingsFormBuilderTrait` uses to read stored config. |
| `preRender(&$element, $rendering_object)` | Turns the group into a component renderable (below). |

## Runtime: how a group becomes a component

`preRender()`:

1. Calls `parent::preRender()`.
2. Copies the element's render `#properties` into a fresh `$build`.
3. Reads the entity from the rendering object: `$entity = $rendering_object['#' . $group->entity_type]`.
4. Builds `$source_contexts`:
   - `entity` → `EntityContext::fromEntity($entity)` (or `NULL`),
   - `entity_type` (string), `bundle` (string),
   - `ui_patterns_field_group` → `(array) $group` (the group config object cast to array),
   - `ui_patterns_field_group:element` → the whole `$element` render array (so child fields are
     reachable — this is what `field_group_child` reads).
5. `$build['component'] = $this->buildComponentRenderable(source_contexts: $source_contexts)` — a
   `#type => component` render element whose `#component` is `config['ui_patterns']['component_id']`,
   `#ui_patterns` is the stored slot/prop configuration, and `#source_contexts` are the contexts
   above.
6. Replaces `$element` with `$build`.

From there UI Patterns 2.x renders the SDC: each configured slot/prop resolves its value from its
source, including the two sources this module adds (see [sources.md](sources.md)). This module does
**not** itself echo any field or label value into markup — output goes through the component render
pipeline and its sources.

## EntityFinder utility

`src/Utility/EntityFinder.php` — `findEntityFromFields(array $fields): ?ContentEntityBase` walks a
render array with a `RecursiveIteratorIterator` and returns the first value keyed `#object` that is a
`ContentEntityBase`. A helper for locating the displayed entity inside a fields array; the formatter
itself resolves the entity from the rendering object rather than through this class.
