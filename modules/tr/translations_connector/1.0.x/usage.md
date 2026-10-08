<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Translations Connector adds a per-node form that turns a separate standalone node (in another language) into a translation of the current node.

---

Translations Connector exposes a local-task form at `/node/{node}/translations-connector` (permission `use translations_connector`, marked `restrict access`). You choose a target language and enter the node id of an existing standalone node in that language; on submit it copies the source node's translatable field values into a new translation on the current node, copies Layout Builder layout if present, re-points the source node's path alias and any redirect entities to the current node, and then **deletes the source node**. Validation checks the source exists, is the same bundle, isn't already multi-translation, and actually has the chosen language. It is intended for consolidating content that editors created as separate per-language nodes into a single translated node.

---

- Turn a standalone node into a translation of another.
- Pick the target translation language from a select list.
- Reference the source node by its node id.
- Copy translatable field values into the new translation.
- Copy Layout Builder layout from the source node.
- Re-point the source node's path alias to the target.
- Move redirect entities from source to target.
- Delete the now-merged source node.
- Enforce same-bundle for source and target.
- Reject sources already connected to other content.
- Reject languages the source doesn't provide.
- Consolidate per-language nodes into one entity.
- Access via the node's Translations Connector tab.
- Gate behind the restricted 'use translations_connector' permission.
- Fix content built without content_translation initially.
