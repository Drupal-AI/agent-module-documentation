<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
JSON:API Node Preview Tab adds a "JSON:API" local task tab to node pages that embeds the node's canonical JSON:API individual endpoint in an iframe for quick inspection.

---

The module solves a small developer/editor need: while building a decoupled or JSON:API-consuming front end you frequently want to see the exact JSON:API document a given node produces, without hand-building the `/jsonapi/node/{bundle}/{uuid}` URL. It registers a `json-preview` link template on the node entity type (`jsonapi_node_preview_tab_entity_type_build`), a route `entity.node.json_preview` at `/node/{node}/json-preview`, and a tab plus an entity-operation link. The controller simply resolves `jsonapi.node--{bundle}.individual` from the node's UUID and renders an `<iframe>` pointing at it.

Access to the tab is gated by the single permission `access jsonapi preview tab`; the tab and the entity operation are both hidden from users lacking it. Importantly the iframe target is the standard JSON:API endpoint, so JSON:API's own entity-access enforcement still applies inside the frame — granting the preview-tab permission does not bypass node access or expose unpublished content that JSON:API would otherwise withhold. Setup is just enabling the module and granting the permission to the relevant roles; the note in the README about Firefox trying to download JSON is a browser display quirk, not a module setting.

---

- Enable the module to add a JSON:API preview tab to nodes
- Grant `access jsonapi preview tab` to editor/developer roles
- Open `/node/{nid}/json-preview` to view a node's JSON:API document
- Inspect the exact JSON:API field structure a node produces
- Copy the JSON:API individual URL for a node during front-end development
- Verify which fields are exposed for a given content type via JSON:API
- Debug a decoupled front end by comparing rendered output to source JSON
- Check relationship references (author, media, taxonomy) in JSON:API output
- Confirm a field's JSON:API attribute name and value shape
- Show content editors the API representation of the node they edit
- Validate that a newly added field appears in the JSON:API response
- Use the entity-operation "JSON" link from admin content listings
- Restrict preview access by only granting the permission to trusted roles
- Confirm unpublished nodes still respect JSON:API access inside the iframe
- Teach new developers what JSON:API returns for real content
- Spot-check UUID-based JSON:API routing for a bundle
- Diagnose missing/extra attributes reported by a consumer app
- Review included relationship data without writing a client
- Keep a quick per-node link to JSON:API for QA workflows
- Install a browser JSON viewer add-on to pretty-print the framed output
