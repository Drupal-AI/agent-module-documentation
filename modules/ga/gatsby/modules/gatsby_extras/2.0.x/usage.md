Gatsby JSON:API Extras adds a JSON:API `jsonapi_extras` field enhancer ("Alias link") that rewrites internal link-field values into UUID- and alias-based forms, and ships config to expose Drupal menus (`menu_link_content`) to JSON:API for a Gatsby front end.

---

The submodule provides one `@ResourceFieldEnhancer` plugin, `alias_link` (`AliasLinkEnhancer`), for use on link fields in a JSON:API Extras resource config. On output (`doUndoTransform`) it detects `entity:{type}/{id}` link URIs and adds `uri_uuid` (`entity:{type}/{bundle}/{uuid}`) and `uri_alias` (the resolved path alias) alongside the raw value, so Gatsby can resolve internal links by UUID/alias instead of by internal id; missing targets are blanked. On input (`doTransform`) it reverses the mapping from UUID back to internal id. It ships an optional `jsonapi_extras.jsonapi_resource_config.menu_link_content--menu_link_content` config (in `config/optional`) that applies the enhancer to the menu link `parent`/`link` fields — a workaround for jsonapi_extras issue 2982133 so Gatsby menus work. Exposing the `menu_link_content` endpoint requires the Gatsby account to hold "Administer menus and menu items" (via basic_auth or key_auth). It depends on the main `gatsby` module and core `jsonapi`.

---

- Expose Drupal menus to a Gatsby site over JSON:API via the `menu_link_content` resource.
- Resolve internal link fields to path aliases so Gatsby can render correct front-end URLs.
- Emit UUIDs for internal links so Gatsby links survive id changes between environments.
- Apply the "Alias link" enhancer to a custom link field in a JSON:API Extras resource config.
- Blank out link values whose target entity no longer exists during JSON:API serialization.
- Support decoupled menu rendering that mirrors the Drupal menu hierarchy.
- Work around jsonapi_extras issue 2982133 for menu link parent fields.
- Round-trip link values (UUID <-> internal id) for JSON:API write operations.
- Add `uri_alias` to a link field so the front end can link by human-readable path.
- Add `uri_uuid` to a link field so the front end can link by stable UUID.
- Keep menu parent references resolvable across a Gatsby build.
- Serialize internal `entity:` link URIs into a Gatsby-friendly shape.
- Rebuild a Gatsby navigation component from the Drupal main menu.
- Avoid broken links when a referenced entity hasn't been imported to Gatsby yet.
- Map a link field's target back to an internal id when writing via JSON:API.
- Provide alias-based routing data for a decoupled site's menu links.
- Complement `gatsby-source-drupal` with menu data it does not fetch by default.
