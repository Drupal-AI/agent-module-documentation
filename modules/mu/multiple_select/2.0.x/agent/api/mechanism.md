# How it works (mechanism)

The whole module is `multiple_select.module` + one JS file + a config admin form. No services,
plugins, hooks-for-you, or Drush.

## Form alter targets

Four `hook_form_*_alter` implementations all delegate to the internal `multiple_select()`
callback:

- `multiple_select_form_node_form_alter`
- `multiple_select_form_media_form_alter`
- `multiple_select_form_taxonomy_term_form_alter`
- `multiple_select_form_site_setting_entity_form_alter`

So the helper is only ever added on **node, media, taxonomy_term, and site_setting_entity**
edit forms — not on user, custom-config, or arbitrary entity forms.

## The `multiple_select()` callback

1. Reads `multiple_select.settings:table`, `json_decode`s it (returns early if unset).
2. Determines the current entity type + form id, and for each registered
   `"<entity>-<bundle>"` key whose bundle part matches the form id, iterates form elements.
3. For each element it injects the master checkbox **only when**:
   - the field name is in the configured list for that bundle, **and**
   - `$form[$item]['widget']['#type'] == 'checkboxes'` (i.e. the "Check boxes" widget).
4. It adds `$form['checkall<field>']` — a `#type => checkbox` titled
   *"Select All / Uncheck All &lt;field label&gt;"*, weighted just above the field, with
   `#attributes['id'] = "multiple_select-<field>"`, and attaches the
   `multiple_select/selectall` library.
5. Default value: on an existing (non-new) entity, the master is pre-checked (`1`) when the
   number of stored values equals the number of options (all already selected).
6. **Field Group cooperation:** if `field_group` is enabled and the field sits in a container,
   the master checkbox is moved inside that container with weight `-10`.

## The JavaScript (`js/selectall.js`)

Selects every element whose id starts with `multiple_select`. For each master checkbox it
derives the field wrapper id (`multiple_select` → `edit`, underscores → dashes) and:
- on master change, sets every `.form-checkbox` inside the wrapper checked/unchecked;
- on any child change, re-checks the master iff every child is checked.

## Consequences an agent should know

- Nothing happens for single-value fields or for multi-value fields shown with a widget other
  than "Check boxes" (e.g. select list, autocomplete) — the `#type == 'checkboxes'` guard.
- The master checkbox is a **pseudo-field**: it is not saved to the entity; it only drives the
  real checkboxes client-side.
- The config value is a **JSON string**, so tooling must encode/decode it rather than treat it
  as a normal nested config array.
