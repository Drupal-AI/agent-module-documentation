Linked Field adds a "Link this field" option to any field formatter, wrapping that field's rendered output in an HTML link to a destination you choose. The destination can be another field's value, a custom URL/path, or tokens — with no theming or code required.

---

Linked Field works entirely through Drupal's **Manage display** screen: for any field (except `link`-type fields), open its formatter settings and a "Link this field" checkbox appears, provided by a `hook_field_formatter_third_party_settings_form()` implementation. When ticked, you pick a **Type** — **Field** (use another field's value on the same entity as the href) or **Custom** (a URL/path string that supports tokens) — plus optional link attributes (title, target, class, rel) under an Advanced section, and an optional token-based **Text** that overrides the field's own output as the link text. These choices are stored as **third-party settings** on the display component, so they travel with the display configuration and export/deploy like any config. At render time `hook_entity_display_build_alter()` fires: the `linked_field.manager` service reads the settings, resolves the destination (reading the referenced field, or replacing tokens for custom URLs), builds an absolute URL (`internal:/…` for internal paths), and rewraps the field's markup in an `<a>` via a recursive DOM walk that links text and image/picture nodes. Internal paths may be entered as `/node/1`, `node/1`, or `internal:/node/1`; tokens like `[node:url]` are supported when the Token module is enabled. The set of available link attributes is itself configurable as a small YAML list at **Admin → Configuration → Content authoring → Linked Field** (`/admin/config/linked_field/config`), gated by the `administer linked_field` permission. It is a lightweight, dependency-light way to make images, text, numbers, and list values click through to related content.

---

- Make a teaser image field link to its parent node (`[node:url]` custom destination).
- Link a "Read more" title field to another URL field on the same entity.
- Turn a phone-number string field into a `tel:` link via a custom destination.
- Turn an email string field into a `mailto:` link.
- Wrap a logo image field in a link to an external website stored in a link field.
- Link a company-name field to a "website" field on the same content type (Field type).
- Point a field at an internal path with `internal:/node/1`, `/node/1`, or `node/1`.
- Add `target="_blank"` to a linked field via the Advanced target attribute.
- Add `rel="nofollow noopener"` to outbound linked fields via the rel attribute.
- Add a CSS class to the generated `<a>` for styling linked fields.
- Set a `title` attribute on the link using a token (e.g. `[node:title]`).
- Override the link text with a token while still linking the field (Advanced → Text).
- Link a list_string or list_float field's value through to a destination.
- Make a date or number field click through to a detail page.
- Link a taxonomy or reference label field to a custom token-built URL.
- Build a per-row destination using entity tokens like `[node:field_slug]`.
- Deploy link behavior between environments as exported display config (third-party settings).
- Apply linking only in specific view modes (teaser vs. full) via that display's settings.
- Define custom link attributes (beyond title/target/class/rel) in the YAML config form.
- Provide human-readable labels/descriptions for link attributes on the config page.
- Link an image field so the whole `<img>`/`<picture>` becomes clickable.
- Link plain text field output so each text node is wrapped in an anchor.
- Restrict who can edit available link attributes via the `administer linked_field` permission.
- Avoid a separate link field/template by linking an existing display component in place.
- Reuse one field's stored URL as the click target for a sibling field's markup.
