<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Field Group Link adds a **"Link"** format to the Field Group module, wrapping every field inside a group in a single `<a>` tag so a whole block of rendered output — a teaser, a card, an image plus caption — becomes one clickable link.

---

The module is a single `@FieldGroupFormatter` plugin with id `link` plus a `field_group_link` render element; it has no settings form, no configure route, no permissions, no Drush commands and no services. It is only available in the **view** context (`supported_contexts = {"view"}`), so the format appears on *Manage display* pages, never on *Manage form display*. On top of Field Group's base settings (`label`, `classes`, `id`, `show_empty_fields`, `label_as_html`) it adds three of its own: `target` (where the link goes), `custom_uri` (used when `target` is `custom_uri`, with full Token replacement) and `target_attribute` (`default` or `_blank`). The `target` select is populated with the literal options `entity` (the canonical URL of the entity being rendered — the usual pick for teasers) and `custom_uri`, plus every **non-base** field on the bundle whose type is one of `link`, `entity_reference`, `file` or `image`. At render time `preRender()` resolves that setting to a `Url`: a link field yields `Url::fromUri()` of its `uri`, a file/image field yields the file's URL, an entity reference field yields the referenced entity's canonical URL, and `custom_uri` is token-replaced then parsed (an invalid URI simply produces no link). The group's children are then moved into the anchor's `#title` and the whole thing is rendered as `#type: field_group_link`, which always carries the CSS class `field-group-link` and adds `target="_blank"` when configured. Everything is stored in the entity's view-display config under `third_party_settings.field_group.<group_name>`, so it is fully exportable. Because the output is a real anchor you must keep the group's contents anchor-safe — nesting a link field or a rich-text field inside produces invalid HTML.

---

- Make an entire node teaser (image + title + summary) one big clickable card linking to the node.
- Turn a media thumbnail plus caption into a single link to the full file.
- Link a "Download" group of fields straight at the uploaded file via a `file` field target.
- Point a card at an arbitrary external URL held in a `link` field on the entity.
- Build a "related product" card that links to the referenced product entity via an `entity_reference` field.
- Link a taxonomy term teaser group to the term page using the `entity` target.
- Link a user-profile summary group to the user's canonical page.
- Send a promotional card to a token-built URL such as `https://shop.example.com/p/[node:field_sku]`.
- Open outbound links from a group in a new tab by setting `target_attribute: _blank`.
- Add a design-system class (e.g. `card-link stretched-link`) to the generated anchor through the group's `classes` setting.
- Give the anchor a stable HTML `id` for anchor-scroll or analytics targeting.
- Wrap a paragraph's fields in a link inside a Layout Builder or paragraph view display.
- Make image-only "hero" groups clickable without writing a custom Twig template.
- Replace hand-written `<a>` wrappers in a custom node template with exportable display configuration.
- Nest a link group inside a Field Group `html_element` group to control both wrapper markup and destination.
- Configure different destinations per view mode — teaser links to the node, full view links to an external source.
- Link a group of media metadata fields to the media entity's own page.
- Migrate legacy "clickable teaser" theme hacks into config that can be deployed with `drush cim`.
- Give editors control of a card's destination by exposing a `link` field they fill in per node.
- Keep the link out of the markup entirely for unpublished/new entities (no URL is produced for an unsaved entity).
- Apply a single link wrapper across many bundles by copying the group's `format_settings` between view displays.
- Wrap a "Read more" group in an anchor without duplicating the node title link.
- Point a card at a file's direct download URL rather than the entity page for document libraries.
- Build clickable grid tiles in a view that renders entities in a view mode carrying the link group.
- Add per-environment destinations by overriding `custom_uri` in a config split.
