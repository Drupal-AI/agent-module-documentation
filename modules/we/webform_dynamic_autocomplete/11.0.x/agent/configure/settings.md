<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configure: endpoint URL and query parameter

One settings form defines the single, site-wide external source used by every "Dynamic
Autocomplete" field.

## Route and access

| Route | Path | Access | Form |
|---|---|---|---|
| `webform_dynamic_autocomplete.settings` | `/admin/config/webform_dynamic_autocomplete/settings` | `administer site configuration` | `Form\WebformDynamicSettingsForm` |

Form id `webform_dynamic_admin_settings`. Extends `ConfigFormBase`.

## Config object

Single config object **`webform_dynamic_autocomplete.settings`**. There is **no `config/schema`**
and **no `config/install`** default for it, so the object does not exist until the form is saved.
Both fields are `#type => textfield` and `#required`.

| Key | Meaning | Example |
|---|---|---|
| `webform_dynamic_endpoint_url` | Base API endpoint that returns options as JSON key/value pairs (GET). | `https://www.example.com/api/data` |
| `webform_dynamic_query_parameter` | Name of the query parameter that carries the search term. | `q` |

At runtime the module builds the request URL as
`{webform_dynamic_endpoint_url}?{webform_dynamic_query_parameter}={search-term}`, e.g.
`https://www.example.com/api/data?q=searched-value`. If either key is empty the option list
resolves to empty (no request is made).

## Set it via Drush

```bash
ddev drush config:set webform_dynamic_autocomplete.settings webform_dynamic_endpoint_url 'https://www.example.com/api/data' -y
ddev drush config:set webform_dynamic_autocomplete.settings webform_dynamic_query_parameter 'q' -y
ddev drush config:get webform_dynamic_autocomplete.settings
```

The API response must be a JSON object/array (value → label). Non-array JSON or an unreachable
endpoint both yield an empty option list.

## After configuring

Add or edit a Webform **autocomplete** element and, under its Custom / "Select options" setting,
choose **"Dynamic Autocomplete options"** (the `autocomplete_dynamic` options entity). See
[../plugins/element.md](../plugins/element.md) for how that wiring produces live options.
