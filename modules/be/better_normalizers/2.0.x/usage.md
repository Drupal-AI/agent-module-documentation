Better Normalizers replaces three of core's HAL normalizers so that File entities serialize their actual (base64-encoded) contents, File field items keep their description/display metadata, and menu link content items embed their linked (and parent) entities — making HAL serialization round-trippable.

---

The module ships no config, routes, permissions, or UI: it is purely a set of higher-priority normalizers registered on the container through `BetterNormalizersServiceProvider::alter()`. It depends on the `hal` module and only affects the **`hal_json`** serialization format. `FileEntityNormalizer` (priority 30, service `serializer.normalizer.entity.file_entity`) extends core's HAL `ContentEntityNormalizer` and adds a `data` property containing the base64-encoded file contents on normalize, and writes those bytes back to disk on denormalize — so a file can be exported and re-imported intact. `FileItemNormalizer` (priority 20, service `serializer.normalizer.entity_reference_item.file_entity`) supersedes the entity-reference item normalizer for `FileItem` fields so per-item properties like `description` and `display` survive the round trip instead of being reduced to a bare reference. When `menu_link_content` is installed, `MenuLinkContentNormalizer` (priority 30) embeds the entity a menu link points at (and its parent menu link) using pseudo-fields, and resolves those embeds back to real ids/UUIDs on denormalize. All three raise their priority above the equivalent `hal.services.yml` normalizers so they win. There is nothing to configure — enabling the module (with `hal`) is the whole setup; you interact with it through the standard `serializer`/REST stack.

---

- Export a File entity to HAL JSON with its binary contents embedded as base64 `data`.
- Re-import that HAL JSON on another site and have the file written back to disk intact.
- Migrate files between Drupal sites over REST without a separate binary transfer step.
- Preserve a file field's `description` when serializing content to `hal_json`.
- Preserve a file field's `display` flag through a serialize/deserialize round trip.
- Serialize a menu link and include the full referenced node/entity it points to.
- Include a menu link's parent menu link entity in the serialized output.
- Round-trip menu links between environments, resolving entity references by UUID.
- Back up content (including attached files) as self-contained HAL JSON documents.
- Feed complete file data to a decoupled/headless consumer in one HAL response.
- Build a content-staging workflow that carries files inside the serialized payload.
- Avoid lossy file-field serialization where only the target id survives.
- Provide a REST export where images/documents travel with the entity, not as URLs.
- Reconstruct files on a destination site during a REST-based content sync.
- Keep menu structures intact (targets + parents) when deploying via serialized config/content.
- Extend or subclass the provided normalizers to add further custom file metadata.
- Guarantee lossless HAL round-tripping for File, file-field, and menu-link content.
- Support content-migration tooling that relies on HAL normalization of files and menus.
- Serve as the serialization backbone for a custom import/export of files over web services.
- Debug HAL output differences by comparing core vs Better Normalizers file serialization.
