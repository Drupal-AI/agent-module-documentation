Makes entity base fields (title, uuid, created, changed, author, path alias...) configurable and renderable in the Manage Display UI and view modes.

---

By default Drupal hides most base fields from the "Manage Display" screen, so fields such as `created`, `uid`, `uuid`, or the node `title` cannot be arranged, formatted, or toggled per view mode the way custom (configurable) fields can. BaseField Display flips the `setDisplayConfigurable('view', TRUE)` flag on the specific base fields you select per entity type via a single admin settings form, so they appear as normal draggable rows in each display's "Manage Display" table with their type-appropriate formatters. It also adds a computed `path` base field ("Alias") for every entity type that has a canonical link, plus three tiny helper formatters (Plain text for `uuid`/`password`, String for `path`) so those otherwise formatter-less core field types can be output. Field access and rendering still go through Drupal core's standard entity-display pipeline; the module only makes the fields selectable in the UI.

---

- Show the "Authored on" (`created`) date as a formatted field in a node's teaser view mode.
- Display the author (`uid`) base field with the entity-reference label formatter instead of hand-coding it in a template.
- Render a node's `title` as a real field row so you can reorder or relabel it in Manage Display.
- Expose the `changed` (updated) timestamp on a content type's full view mode.
- Output an entity's `uuid` using the provided "Plain text" formatter for debugging or integrations.
- Show the URL alias of a node or taxonomy term as text using the computed "Alias" field + "String" formatter.
- Turn on the `sticky` or `promote` base fields so editors can see their state on the rendered page.
- Display the `langcode` base field on multilingual content.
- Make the taxonomy term `name` field configurable/renderable in term view modes.
- Expose base fields on Media entities (e.g. `created`, `uid`) in media view modes.
- Expose base fields on Paragraph entities so paragraph view modes can arrange them.
- Configure base-field visibility differently across the Default, Teaser, and custom view modes.
- Hide the double-printed node title in the page `h1` while re-rendering it as a field (handled automatically when `title` is activated).
- Add the "Comment count" or other statistics base fields to a node's display.
- Show File entity base fields such as filename or size in a file view mode.
- Provide a consistent field-formatter workflow for base fields to layout builders and site builders.
- Enable base fields per entity type using a single checkboxes form under Configuration > Content authoring.
- Give custom content entity types the same "arrange base fields in Manage Display" capability core reserves for configurable fields.
- Let themers target activated base fields as normal `content.<field>` render arrays in templates.
- Surface the computed canonical URL/alias of any entity that defines a `canonical` link template.
