# Configuration

All setup happens on one page: you choose which fields, on which bundles, should get
the **Select All / Uncheck All** master checkbox. The helper only ever appears on
**node, media, taxonomy term, and site settings entity** edit forms.

## Before you start: the field must use the Check boxes widget

The master toggle is only added to a field that is:

- **multi-value** (cardinality greater than 1, or unlimited), and
- displayed with core's **"Check boxes"** widget on *Manage form display*.

If a field you select is shown with a select list, autocomplete, or any other
widget, nothing appears — the module specifically looks for the checkboxes widget.
So first go to the bundle's **Manage form display** and confirm the field's widget
is set to **Check boxes**.

## Choose the fields

1. Log in as a user with the **Access multiple select config page** permission.
2. Go to **Configuration → Content authoring → Multiple Select Helper**
   (`/admin/config/content/multiple-config`).
3. The page groups bundles under **Node**, **Media**, **Site Settings** and
   **Taxonomy**. Tick the bundle you want to configure. (A bundle with no eligible
   `list_string` / `entity_reference` field is greyed out.)
4. In the multi-select that appears for that bundle, choose one or more fields. A
   note on the form reminds you that only "Check boxes"-widget fields are actually
   affected.
5. Click **Save configuration**. The whole selection is rewritten from what you
   ticked.

From then on, whenever an editor opens a matching edit form, the chosen fields show
a **"Select All / Uncheck All *[field label]*"** checkbox just above them. Clicking
it ticks or clears every option; ticking every box individually re-checks the
master automatically. On an existing entity that already has all options selected,
the master starts checked.

## Where the setting is stored

Everything lives in the config object **`multiple_select.settings`**, in a single
key **`table`**. Its value is a JSON-encoded string mapping each
`"<entity_type>-<bundle>"` key to a list of field machine names, for example:

```
table: '{"node-article":["field_tags","field_categories"],"media-image":["field_topics"]}'
```

Because it is one exportable config value, you can move your selections between
environments like any other configuration.

## Scripting it (optional)

The value must be JSON-encoded, so read and write it through the config factory:

```bash
# read the current map
drush cget multiple_select.settings table

# give node.article's field_tags the helper
drush php:eval '\Drupal::configFactory()->getEditable("multiple_select.settings")
  ->set("table", json_encode(["node-article" => ["field_tags"]]))->save();'
```

To remove the helper from a field, drop it from the array (or clear the whole map)
and save.

## Removing the helper

Untick the field on the config page and save, or edit the `table` map as above. To
disable the feature entirely, uninstall the module.
