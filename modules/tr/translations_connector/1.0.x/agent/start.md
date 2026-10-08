<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Translations Connector - agent index

Merges a **separate same-bundle node into the current node as a translation**, moves alias/redirects, then **deletes the source node**. Version **1.0.4**, core `^9 || ^10`.

- Form route `translations_connector.translations_connector_local_task` at `/node/{node}/translations-connector`, permission `use translations_connector` (restrict access).
- Deps: `content_translation`, `language`.
- SECURITY: source node is loaded and deleted by nid with no entity-access check - a holder of the permission can delete any node. See findings.