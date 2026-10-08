# Configure the synonyms autocomplete widget

## Enable on a field

*Manage form display* → for an **entity-reference** field pick **"Synonyms-friendly autocomplete"**
(`synonyms_autocomplete`). Also enable the **autocomplete** behavior for the *target* entity type/bundle
on *Structure → Synonyms configuration → Manage behaviors* so synonym suggestions are contributed.

## Widget settings (`field.widget.settings.synonyms_autocomplete`)

| Key | Type | Default | Meaning |
|---|---|---|---|
| `suggestion_size` | integer | 10 | Max suggestions returned. |
| `suggest_only_unique` | boolean | FALSE | At most one suggestion per entity when several synonyms match. |
| `match` | string | `CONTAINS` | Match operator: `CONTAINS` or `STARTS_WITH`. |

Global config `synonyms_autocomplete.settings` (form route `synonyms_autocomplete.settings`, perm
`administer site configuration`) holds `default_wording` (default
`@synonym is the @field_label of @entity_label`).

## Route & permission

| Route | Path | Permission |
|---|---|---|
| `synonyms.entity_autocomplete` | `/synonyms_autocomplete/entity/autocomplete/{target_type}/{token}` | `access synonyms entity autocomplete` |
| `synonyms_autocomplete.settings` | `/admin/structure/synonyms_autocomplete/settings` | `administer site configuration` |

The controller reads the `q` query param, runs `AutocompleteService::autocompleteLookup($input, $token)`,
and returns JSON `[{value, label}]`. `{token}` is an HMAC of the pinned lookup settings
(`target_type`, `target_bundles`, `suggestion_size`, `suggest_only_unique`, `match`) stored in key-value
`synonyms_entity_autocomplete` — a client cannot forge different lookup parameters. Grant the permission
to any role that edits fields using this widget.

## Reuse the form element in custom code

```php
$form['ref'] = [
  '#type' => 'synonyms_entity_autocomplete',
  '#target_type' => 'taxonomy_term',
  '#target_bundles' => ['tags'],   // optional; omit for all bundles
  '#suggestion_size' => 10,
  '#suggest_only_unique' => FALSE,
  '#match' => 'CONTAINS',          // or STARTS_WITH
  '#default_value' => [$term],     // array of entities
];
```

The element's process callback registers the HMAC token + key-value entry and wires
`#autocomplete_route_name`; its validate callback resolves each typed token to `['target_id' => id]`
(exact `label (id)` match first, else a synonym lookup) and errors if any item can't be resolved.
