# Enable the Select-All helper for a field

## Where the setting is stored

Config object: **`multiple_select.settings`**, single key **`table`**.
Its value is a **JSON string** (not a nested config array) mapping an entity/bundle key to a
list of field machine names:

```
table: '{"node-article":["field_tags","field_categories"],"media-image":["field_topics"]}'
```

The bundle key is `"<entity_type>-<bundle_id>"` (dash-separated), e.g. `node-article`,
`media-image`, `taxonomy_term-<vocabulary_id>`, `site_setting_entity-<type>`.

## Via the UI

1. Go to **Configuration → Content authoring → Multiple Select Helper**
   (`/admin/config/content/multiple-config`). Requires the
   `access multiple select config page` permission.
2. Under each entity group (Node / Media / Site Settings / Taxonomy) tick the bundle you want.
   A bundle whose fields include no `list_string`/`entity_reference` field is disabled.
3. In the multi-select that appears, choose one or more fields (only "Check boxes"-widget
   fields will actually be affected — the note on the form says so).
4. **Save configuration.** The form rewrites the whole `table` key from your selections.

## Via drush (scriptable)

The value must be JSON-encoded. Read it back and write it with the config factory:

```bash
# read
drush cget multiple_select.settings table

# set node.article field_tags to have the helper
drush php:eval '\Drupal::configFactory()->getEditable("multiple_select.settings")
  ->set("table", json_encode(["node-article" => ["field_tags"]]))->save();'
```

To **disable** the helper for a field, remove it from the array (or clear the whole map with
`->set("table", NULL)`), then save.

## Requirements for the helper to appear

- The field must be **multi-value** (cardinality > 1 or unlimited).
- Its **form-display widget** must be "Check boxes" (core `options_buttons`), so it renders as
  `#type => checkboxes`. A field listed in `table` but shown with another widget gets nothing.
- The edit form must be one of: node, media, taxonomy term, or site_setting_entity
  (those are the `hook_form_alter` targets).

## Config schema

`multiple_select.settings` is declared with one string mapping `table` (label "Json encoded
settings"), so the JSON string is stored/validated as a single scalar.
