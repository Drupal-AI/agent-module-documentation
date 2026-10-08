<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
JSON:API Preview Tab adds a "JSON:API Preview" local-task tab to the canonical pages of nodes, media, taxonomy terms and menu-link-content entities, rendering that entity's serialized JSON:API document inline with syntax highlighting.

---

It is a developer convenience for decoupled/JSON:API sites: rather than hand-constructing `/jsonapi/node/article/{uuid}` URLs, an editor or developer opens the tab on the entity page and sees the pretty-printed, highlighted JSON plus a link to the live JSON:API URL. Implementation is a route subscriber that adds an `entity.<type>.jsonapi_preview` route for each of the four supported entity types (using a link template set in `hook_entity_type_build`), a derivative that adds the matching local task, and a controller that calls `jsonapi_extras`' `EntityToJsonApi::serialize()` on the route entity. It depends on both `jsonapi` and `jsonapi_extras`.

---

- Add a JSON:API Preview tab to node admin pages
- Preview the JSON:API document for a media entity
- Preview the JSON:API output for a taxonomy term
- Preview the JSON:API output for a menu link content item
- See the pretty-printed, syntax-highlighted JSON inline
- Open the live JSON:API URL for the entity in a new tab
- Debug decoupled/front-end integrations without hand-building JSON:API URLs
- Confirm which fields a given entity exposes over JSON:API
- Verify field-level access filtering as reflected by the JSON:API normalizer
- Grant the `access jsonapi preview tab` permission only to trusted developers
- Inspect how jsonapi_extras field overrides change the output
- Check the serialized shape of a content model during development
- Use it as a quick reference while writing front-end queries
