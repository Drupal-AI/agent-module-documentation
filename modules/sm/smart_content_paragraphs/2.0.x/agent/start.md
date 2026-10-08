<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Smart Content Paragraphs - agent index

Paragraph-level personalization for Smart Content. Version **2.0.0** (2.0.x), core `^9.4 || ^10`. Depends on `smart_content`, `paragraphs`, `paragraphs_library`, `geocoder`.

- Reaction endpoint: **`POST /personalised_content/reactions/{nid}`** -> `ReactionsController::reaction`, perm **`access content`** (anonymous). Reads JSON request body, loads the node, evaluates each `smart_content_paragraph` variation's conditions, returns matching variation `target_id`s as JSON.
- `getSmartComponents($nid)` does `$this->nodeStorage->load($nid)` then `$node->getType()` - **no access/published check**.
- Region conditions geocoded server-side via Google Maps (`_store_region_details`) into `smart_content_paragraphs_regions`; queried with parameterized `db->select()->condition()` (no SQLi). Sub-submodules pce_device / pce_geolocation / pce_geobrowser / pce_node / pce_cookie add condition derivatives. Geo settings form perm `administer site configuration`.

Security finding (D2): `ReactionsController` at `smart_content_paragraphs/src/Controller/ReactionsController.php` (reaction / getSmartComponents) is gated only by `access content` and loads an arbitrary `{nid}` with no `$node->access('view')` or published check. An anonymous user can probe any node id (including unpublished) and receive the paragraph variation entity IDs of matching smart variations. Disclosure is limited to integer paragraph IDs (content is not rendered here) and non-existent ids cause a fatal error, so impact is low, but the missing access check is real. Fix: verify `$node = load(); if (!$node || !$node->access('view')) throw NotFound/AccessDenied;`.
