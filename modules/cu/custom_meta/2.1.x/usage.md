Custom Meta extends the [Metatag](https://www.drupal.org/project/metatag) module by letting site builders define their own meta tags through the admin UI, without writing a plugin for each one.

---

Custom Meta adds an admin overview at *Configuration → Search and Metadata → Metatag → Custom Meta Tags* (`custom_meta.admin_overview`) where you create tag definitions, each with a **meta attribute** (`name`, `property`, or `http-equiv`), a machine **name**, a **label**, and a **description**. Definitions are stored as a keyed array in the `custom_meta.settings` config object (key `tag`), plus an optional global `prefix`. For each of the three attribute types the module ships one base Metatag tag plugin (`custom_meta_tag_name`, `custom_meta_tag_property`, `custom_meta_tag_http_equiv`) and a matching plugin **deriver** (`CustomMetaDeriver{Name,Property,HttpEquiv}`) that reads the config and clones the base plugin into one derivative per defined tag, all grouped under a Metatag group plugin (`custom_meta`, label "Custom Metatags"). Once defined, the tags appear like any other Metatag field on the Metatag settings/defaults forms and on entity Metatag fields, and render via Metatag's normal output pipeline (empty values are stripped). Changing a definition requires a cache flush before the derivative rebuilds. One permission, `administer custom meta tags`, gates the whole UI.

---

- Add a custom `<meta name="...">` tag (e.g. a verification token) without writing code.
- Add a custom `<meta property="...">` tag for an Open Graph / Facebook property not covered by core Metatag.
- Add a custom `<meta http-equiv="...">` tag (e.g. `refresh`, a custom CSP-style header hint).
- Define a site-wide "sitename" meta tag (shipped as the default example definition).
- Give editors a friendly label and help description for each custom tag on the Metatag form.
- Apply a shared prefix to every custom tag's rendered name via the global settings form.
- Manage all custom tag definitions from one overview table with edit/delete operations.
- Expose custom tags as tokens/fields inside Metatag defaults for a content type.
- Add per-entity custom metadata by placing the Metatag field on a bundle and filling the custom tags.
- Create a `theme-color` meta tag for mobile browsers.
- Add a `referrer` policy meta tag.
- Add a custom social-network property tag (e.g. `pinterest`, `twitter:*` variants) not in core Metatag.
- Define a `rating` or content-classification meta tag.
- Add a custom `revisit-after` or crawler-hint tag.
- Provide an editorial-only descriptive meta tag for internal tooling.
- Standardize a set of organization-specific meta tags across an entire multisite via exported config.
- Bulk-manage custom tags through `custom_meta.settings` config import/export.
- Rename or relabel an existing custom tag definition through the edit form.
- Remove an obsolete custom tag definition through the delete confirmation form.
- Group all bespoke tags under a single "Custom Metatags" section in the Metatag UI.
- Keep custom tags out of the render output automatically when their value is empty.
