<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Acquia DAM - Enhanced integration links — agent index

Submodule of **acquia_dam**. Deep-discovers DAM asset usage across all content entities
(entity references, paragraphs, WYSIWYG embeds) and registers accurate integration links back
to the DAM. **No UI, no config, no permissions** — automatic once enabled. Depends on
`acquia_dam`.

- **Hooks, the `asset_detector` service tag & the three detectors, the queue, how to extend** →
  [api/detection.md](api/detection.md)

Key facts:
- Entity hooks: `hook_entity_insert/update` → `trackAssetUsage()`, `hook_entity_delete` →
  `removeAssetUsage()` on service `acquia_dam_integration_links.enhanced_register`.
- Detectors are collected via the `asset_detector` tag by
  `acquia_dam_integration_links.tracker` (`AssetTracker`): `MediaReferenceAssetDetector`,
  `EntityEmbedTextDetector`, `ParagraphsAssetDetector`.
- Discovered links are queued in the **`acquia_dam_integration_links`** queue and processed by
  the **parent** module's queue worker/cron and Drush commands (`ad:qil`, `ad:pilq`, `ad:ril`).
- Media & paragraph entities are excluded as top-level subjects (handled via their host).
- Actual link registration talks to the DAM API — needs a live connection.
