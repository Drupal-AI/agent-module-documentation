# Field: `taxonomy_class`

The module adds one **base field** to the `taxonomy_term` entity type (all vocabularies) via
`taxonomy_class_entity_base_field_info()` in `taxonomy_class.module`. It is not a field-type/widget
plugin and is not stored per-bundle config — it is a base field present on every term.

| Property | Value |
|----------|-------|
| Field name | `taxonomy_class` |
| Entity type | `taxonomy_term` (all vocabularies) |
| Type | `string` (`BaseFieldDefinition::create('string')`) |
| Label | `CSS class(es)` |
| Form widget | `string_textfield`, weight `35` |
| Display configurable (form) | yes (`setDisplayConfigurable('form', TRUE)`) |
| Cardinality | 1 (single value; only the first value is ever output) |
| Stored in config | no — value lives on each term entity |

## On the term edit form

`taxonomy_class_form_taxonomy_term_form_alter()` places the field into a collapsed `details`
element titled "Taxonomy Class settings" in the form's `advanced` (sidebar) group:

- The alter first checks `\Drupal::currentUser()->hasPermission('administer taxonomy classes')`
  and **returns early** if the user lacks it, so the field is not exposed to unprivileged editors.
- The group markup: `#type => 'details'`, `#group => 'advanced'`, `#open => FALSE`,
  wrapper class `taxonomy-class-form`; the field is reparented via
  `$form['taxonomy_class']['#group'] = 'taxonomy_class_group'`.
- The description shown is "Assign CSS classes to the taxonomy term."

Editors may enter multiple space-separated classes, but note that only the first value of the
field is ever rendered (see [../theme/class-output.md](../theme/class-output.md)); a space-separated
string entered in the single textfield is stored and output verbatim as one class value.

## Set / read programmatically

```php
// Set (and persist) the class on a term.
$term->set('taxonomy_class', 'featured cat-news')->save();

// Read the stored value.
$value = $term->get('taxonomy_class')->value;               // string, or NULL
$raw   = $term->get('taxonomy_class')->getValue();          // e.g. [['value' => 'featured']]
```

Because it is a base field, no field-storage/field-config entity needs to be created — it is
available immediately once the module is installed. There is no `hook_install`/`hook_update`;
installing the module makes the field appear on existing terms.
