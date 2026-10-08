# Configure the synonyms select widget

## Enable on a field

*Manage form display* → for an **entity-reference** field pick **"Synonyms-friendly select"**
(`synonyms_select`). Enable the **select** behavior for the target entity type/bundle on
*Structure → Synonyms configuration → Manage behaviors* so synonyms populate the options.

## Settings (`synonyms_select.settings` / per-widget)

| Key | Type | Default | Meaning |
|---|---|---|---|
| `default_wording` | string | `@synonym is the @field_label of @entity_label` | Label wording for each synonym option. |
| `sort_select` | boolean | FALSE | Sort the dropdown options. |

Global form: route `synonyms_select.settings` → `/admin/structure/synonyms_select/settings`
(perm `administer site configuration`).

## Option encoding (behavior)

The `synonyms_entity_select` element lists each referenceable entity **once per synonym** (plus its
label). Option keys are `"<entity_id>:<synonym>"` (delimiter `:`); the value callback/validation strip the
synonym part so every choice resolves back to the entity's `target_id`. This means the same entity can
appear multiple times in the dropdown yet always stores the same reference.

## Reuse the element in custom code

```php
$form['ref'] = [
  '#type' => 'synonyms_entity_select',
  '#options' => [/* built from SelectService::selectGetSynonymsMultiple() */],
  '#default_value' => (string) $entity_id,   // cast to string (see valueCallback note)
];
```

Note: default values are cast to strings internally to avoid PHP loose-comparison marking every
`id:synonym` option as selected.
