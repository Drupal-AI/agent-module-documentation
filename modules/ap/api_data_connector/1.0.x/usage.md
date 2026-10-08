API Data Connector provides a Drupal field whose widgets autocomplete and populate their options from an external JSON API, storing the chosen id and name on the entity.

---

API Data Connector ships one field type (`api_data_connector_item`), three widgets, and one formatter. On a field's Storage/Field settings a site builder enters the external API URL, the name of the query parameter to send the typed text as, and the response keys that map to the stored id (`key`) and the displayed label (`value`), plus optional extra mapped values and nested dotted key paths. Editors then interact with either a plain text autocomplete, a comma-separated tags autocomplete, or a Select2 dropdown, all of which pull suggestions/options from the configured API. The picked id and name are saved (the Select2 widget additionally stores the serialized response row in a blob column), and the default formatter prints the stored name. The module depends on the Select2 module and requires Drupal 11. It has no admin settings page and no config schema — everything is configured through the field's own settings.

---

- Add an "API Data Connector Field" to a content type, taxonomy term, user, or any fieldable entity.
- Let editors type into a field and get live autocomplete suggestions sourced from a remote REST/JSON API.
- Populate a Select2 dropdown with options fetched from an external service.
- Offer a tags-style, multi-value autocomplete backed by remote data.
- Store both an id and a human-readable name for each remotely-selected item on the entity.
- Map an API response's `id`/`userid`/`node_id` field to the stored target id.
- Map an API response's `name`/`username`/`title` field to the displayed label.
- Reach into nested API response objects using dotted paths like `user.userid` or `node.name`.
- Capture additional response fields per selection via the "Additional Mapping Values" textarea.
- Send the typed text to the API under a configurable query-parameter name.
- Reference records that live in an external system (CRM, directory, catalog) rather than in Drupal.
- Build a "pick a remote user/customer/product" field without importing that data into Drupal.
- Display the saved remote name on the rendered entity with the bundled formatter.
- Provide a consistent Select2 UI for remote option selection across multiple content types.
- Keep a lightweight local reference (id + name) to an external entity for later lookup.
- Prototype an integration where field options must come from a third-party API endpoint.
- Attach multiple remote selections to a single entity using the multi-value widgets.
- Preserve the full API response row for a Select2 selection (stored serialized in a blob column).
- Replace a hand-built custom autocomplete controller with a configurable, reusable field.
- Let non-developers wire a field to an API endpoint through the field settings UI.
