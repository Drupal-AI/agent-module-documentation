# The `dynamic_reference_selection_views` selection handler

File: `src/Plugin/EntityReferenceSelection/DynamicReferenceSelectionViewsSelection.php`.

An **EntityReferenceSelection** plugin (core plugin type) declared with a PHP attribute:

```php
#[EntityReferenceSelection(
  id: "dynamic_reference_selection_views",
  label: new TranslatableMarkup("Dynamic Reference Selection: Make field dependent using views"),
  group: "dynamic_reference_selection_views",
  weight: 0,
)]
class DynamicReferenceSelectionViewsSelection extends PluginBase
  implements SelectionInterface, ContainerFactoryPluginInterface
```

It is **View-backed**, not query-backed: `entityQueryAlter()` is empty and there is no
`getStorage()->getQuery()`. The referenceable set is produced by executing a Views **Entity Reference**
display, with the parent field value injected as the first contextual-filter argument.

## Injected dependencies (`create()`, `.php:78`)

`entity_type.manager`, `module_handler`, `current_user`, `dynamic_reference_selection.util`.
Note: `create()` also passes `$container->get('messenger')` as a 5th positional arg, but the
constructor has no matching parameter and no `$messenger` property — so `$this->messenger` (used only
on the error path in `initializeView()`) is effectively unset. Harmless on the happy path.

## SelectionInterface methods

- **`getReferenceableEntities($match, $match_operator, $limit)`** (`.php:455`) — resolves the parent
  value via `getParentFieldValue()`, builds `arguments = [$parent_value] + configured_arguments`,
  calls `initializeView()` then `$this->view->executeDisplay($display, $arguments)`, and returns
  `$return[$bundle][$entity_id] = $entity->label()`.
- **`countReferenceableEntities()`** (`.php:491`) — runs the above then returns
  `$this->view->pager->getTotalItems()`.
- **`validateReferenceableEntities(array $ids)`** (`.php:500`) — re-runs the view constrained to the
  submitted ids (`getValidIds()`, `.php:531`) and returns the ids the view still returns; this is what
  stops a user submitting a target the current parent value doesn't allow.
- **`entityQueryAlter(SelectInterface $query)`** — empty (no query alteration).
- **`validateConfigurationForm()` / `submitConfigurationForm()`** — empty.

## Parent value resolution — `getParentFieldValue()` (`.php:566`)

Order: request parameter named after the configured `parent_field`
(`$this->util->request->get($field)`) → the entity's own field value → nested-entity (Paragraph) value.
An entity-autocomplete string `Label (123)` is reduced to the id via
`preg_match('/\((\d+)\)$/', …)`. Array values are `implode(',', …)` so a multi-value parent becomes a
comma list passed to a "Allow multiple values" contextual filter. The value is passed as a **View
argument** (contextual filter), i.e. handled by the argument plugin — it is not concatenated into raw
SQL.

## The AJAX callback — `updateDependentField(array $form, FormStateInterface $form_state)` (static, `.php:138`)

Bound as the parent widget's `#ajax['callback']` by the module's `hook_field_widget_..._form_alter`.
Flow:

1. Find the acting entity/subform (unwinds Paragraph `subform` nesting; may `create()` a transient
   paragraph of the widget's `#paragraph_type`).
2. Read `$children = $trigger_field['#ajax']['br_children']` (the dependent child field names).
3. For each child whose `handler == 'dynamic_reference_selection_views'`: load
   `Views::getView(view_name)`, take the parent value from `$trigger_field['#value']` (autocomplete →
   id via regex; checkbox → the full list from `$form_state`; array → imploded), optionally convert to
   UUIDs (`convertEntityIdsToUuids()`, `.php:245`), `setArguments()`, `setDisplay()`, `preExecute()`,
   `build()`, then `getViewOptions()`.
4. Emit `new UpdateOptionsCommand($html_field_id, $options, $formatter, $multiple)` per child.

`getViewOptions()` (`.php:260`) renders the view's `style_plugin`, then for each row stores
`['key' => row_key, 'value' => Html::decodeEntities(strip_tags($rendered))]`, sorts by value, and
prepends a `_none => "-Select-"` option. Labels are therefore **plain text** (tags stripped) and the
JS inserts them with `document.createTextNode` / `new Option(value, key)` — no HTML injection sink.

## `initializeView()` (`.php:425`)

Calls `Views::getView()` and **`$this->view->access($display_name)`** (returns FALSE + a warning if
the view is missing/inaccessible), then `setDisplay()` and stores
`entity_reference_options` (`match`, `match_operator`, `limit`, `ids`) on the display handler so core's
entity-reference display can honour them.

## Extending

There's nothing plugin-based to override here for a normal integration — you configure it per field
(see [../configure/dependent-fields.md](../configure/dependent-fields.md)). To change the *element*
that gets built, use the reacts-on / event mechanism in
[reacts-on.md](reacts-on.md) rather than subclassing this handler.
