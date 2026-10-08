Typed Link adds a `typed_link` field type that stores a normal Drupal link (URI + optional link text) plus a single "link type" chosen from an admin-defined allowed-values list, so links can be categorised (e.g. PDF, external, video) for theming.

---

The module extends core Link: `TypedLinkItem` subclasses `LinkItem` and adds a required `link_type` varchar(255) column (indexed, and the field's main property), pulling its option handling from core Options by delegating storage-settings, possible/settable values to an internal `ListStringItem`. Allowed values are configured exactly like a core "List (text)" field (key|label pairs, or an `allowed_values_function`). The `typed_link` widget (`TypedLinkWidget extends LinkWidget`) renders the standard URI/title inputs plus a `link_type` select whose options come from the field's option provider (filtered per-user and passed through `hook_options_list_alter`), made `#required` client-side whenever the URI is filled. The `typed_link` formatter (`TypedLinkFormatter extends LinkFormatter`) renders the link normally and appends a `type` element containing the option label (or the raw stored value if it is no longer in the allowed list), restricted to `FieldFilteredMarkup::allowedTags()`. A second `typed_link_separate` formatter setting group reuses core link formatter settings. There is no global config, no permissions, and no Drush; everything is configured on the field, its **Manage form display**, and **Manage display**.

---

- Add a link field where each link is tagged with a category (PDF, video, external, download, etc.).
- Store links to files on an external CDN (the original use case) and tag each with an asset type.
- Drive theming/icons from a link's type (e.g. show a PDF icon for `link_type = pdf`).
- Define the set of allowed link types as key|label pairs on the field storage settings.
- Populate allowed link types dynamically from a callback via `allowed_values_function`.
- Require editors to pick a link type whenever they enter a URL.
- Present the link type as a single-select dropdown in the node/entity edit form.
- Display the human-readable type label next to the rendered link on the front end.
- Fall back to showing the raw stored type value if an option was later removed from the allowed list.
- Reuse core Link field settings (allow/require link text, internal/external URL validation) since it extends LinkItem.
- Trim displayed link text length or show the URL as plain text using inherited link formatter settings.
- Add `rel="nofollow"` or `target="_blank"` to typed links via the formatter settings.
- Alter the available link-type options at runtime with `hook_options_list_alter`.
- Restrict which link types a given user may set (settable options are computed per account).
- Categorise navigation or "related resources" link lists for differentiated styling.
- Build a downloads field where each item is a labelled link (spec sheet, brochure, manual).
- Use the indexed `link_type` column to filter or group entities by link category in Views.
- Provide a "call to action" link field whose type controls button styling.
- Migrate an existing link field to typed_link to add categorisation without losing URLs.
- Generate sample content: `generateSampleValue()` yields a random URL plus a random allowed type.
- Keep link-type vocabulary in config (no taxonomy needed) for simple, code-defined categories.
