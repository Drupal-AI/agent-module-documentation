<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# bert field widget

`src/Plugin/Field/FieldWidget/Bert.php` — `class Bert extends WidgetBase implements
ContainerFactoryPluginInterface`.

```
@FieldWidget(
  id = "bert",
  label = "Better Entity Reference Table",
  multiple_values = TRUE,
  field_types = { "entity_reference" }
)
```

`multiple_values = TRUE` means the widget receives the whole field item list at once and
`massageFormValues()` returns the full id array.

## Enable

1. `drush en bert` (or install via Composer `drupal/bert`).
2. Structure → *(entity type)* → Manage form display → set an entity-reference field's widget to
   **Better Entity Reference Table**.
3. Saving the form display triggers `bert_entity_presave()` (`bert.module`), which sets that
   field's `handler` setting to `bert:<target_entity_type>` if it isn't already — so the bert
   selection handler is applied automatically. The reference method can also be changed by hand on
   the field edit page.

## Widget settings (`defaultSettings()` / `settingsForm()`)

| Setting | Default | Meaning |
|---|---|---|
| `list` | `title` | List-formatter plugin id — how each row's entity is rendered (see plugins/formatters.md). Options come from `listFormatterManager->getDefinitions()`. |
| `add` | `select` | Add control: `select`, `radios`, `auto_complete`, or `none` (constants `ADD_SELECTION_*`). `none` hides the add control entirely. |
| `add_placeholder` | `Select an entity` | Placeholder text; only shown/used for the autocomplete add mode (`#states` visibility). |
| `disable_duplicate_selection` | `TRUE` | Removes already-referenced ids from the option set / passes them to the handler so the same entity can't be added twice. |
| `disable_remove` | `FALSE` | Hides the per-row Remove button and the Operations header column. |
| `disable_drag_and_drop` | `FALSE` | Turns off tabledrag weight ordering even on multi-value fields. |
| `wrapper` | `TRUE` | When on, wraps the element in a `fieldset` (class `bert`); when off, uses `form_element`. |

`settingsSummary()` prints the list formatter, the add mode, and (autocomplete only) the
placeholder.

## How the element is built (`formElement()`)

- Sets `#type => 'bert'`, wraps in a `<div id="{unique}">` for AJAX replacement, attaches
  `library => ['bert/default']`.
- Computes a per-field `storageKey` = `['bert', ...$field_parents, $fieldName, 'entities']` and a
  `buttonBaseId = sha1(...)` used to name the add/remove buttons uniquely.
- `getEntities()` seeds form-state storage from `$items->referencedEntities()` on first build,
  then loads current ids via the target-type storage (missing ids are filtered out).
- If no entities yet and `add !== none`, renders only the add control. Otherwise renders the
  table (`getList()`), and appends the add control unless cardinality is reached or `add == none`.

### The table (`getList()`)

- `#type => table`, `#empty => "No items added."`, id `{html}-table`.
- Multi-value + not `disable_drag_and_drop` → `#tabledrag` order group `bert-order-weight`, and
  each row gets a `draggable` class + a `#type => weight` element.
- Header = `['', ...$listPlugin->getHeader(), (Operations if !disable_remove), (weight if
  multiple)]`. The leading empty column holds a hidden `entity` element (the id) and is hidden by
  `css/default.css`.
- Each row: hidden `entity` (id) + the list plugin's `getCells($entity)` + optional Remove button
  (`#depth => 2`, `#name => remove_{ind}_{base}`) + optional weight.

### Add controls (`getAdd()` → `getAddBySelect` / `getAddByRadios` / `getAddByAutoComplete`)

- **Select/Radios**: options from the field storage's options provider
  (`getSettableOptions($currentUser)`); ignored ids (duplicates) are unset; each option is wrapped
  in `FieldFilteredMarkup::create()`. Radios reuse the select build minus the `_none` option.
- **Autocomplete**: an `entity_autocomplete` element with `#selection_handler` =
  the field's `handler`, `#selection_settings` merged with `ignored_entities`, and
  `#validate_reference => FALSE`. If the field's core handler has autocreate on,
  `getAutocreateBundle()` computes the bundle and adds `#autocreate` (uid = parent owner or
  current user).

## AJAX add/remove (static `submit()` + `ajaxCallback()`)

- The hidden submit button (built once as `$button`) drives all add/remove actions via
  `#ajax` with `trigger_as`. `submit()` reads current ids from user input, then by button name:
  - `select` / `auto_complete` → appends the newly chosen id (`getNewEntity()`; autocomplete runs
    `EntityAutocomplete::extractEntityIdFromAutocompleteInput()` and clears the search box).
  - `remove` → unsets the id at the row index.
  - Writes the resulting id list back to form-state storage under `storageKey` and
    `setRebuild(TRUE)`.
- `ajaxCallback()` returns the rebuilt element subtree (via `#array_parents` + `#depth`).
- `massageFormValues()` flattens the stored `list` rows (and an autocreated `add.entity.entity`)
  into a plain array of ids for saving.
- `flagErrors()` rewrites the core NotNull violation message to "@name field is required." for
  better UX (borrowed from entity_browser).

## Notes

- The widget only changes editing UX; saved values are ordinary entity_reference ids. Removing the
  widget leaves the data intact.
- `css/default.css` (library `bert/default`) hides the leading id column and tidies drag/table
  spacing; there is no JavaScript of the module's own beyond core tabledrag/autocomplete/AJAX.
