<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# FixedBlockContentInterface API

Interface: `Drupal\fixed_block_content\FixedBlockContentInterface`
(entity `Drupal\fixed_block_content\Entity\FixedBlockContent`). Load with
`\Drupal::entityTypeManager()->getStorage('fixed_block_content')->load($id)`.

## Methods

| Method | Behavior |
|---|---|
| `getBlockContent($create = TRUE)` | Returns the linked `block_content` entity. If none is linked and `$create` is TRUE, **creates an empty custom block** of `block_content_bundle` on demand and links it (this is why placements never break). |
| `getBlockContentBundle()` | The target `block_content_type` id (`block_content_bundle`). |
| `exportDefaultContent($update_existing = FALSE)` | Snapshots the current linked block into the entity's `default_content` (HAL). With `$update_existing` also refreshes an existing snapshot. |
| `importDefaultContent()` | Recreates/overwrites the live custom block from the stored `default_content` snapshot. |
| `setProtected($value = TRUE)` / `isProtected()` | Get/set the `protected` flag — a protected fixed block's custom block is made non-reusable so it can't be independently edited/deleted. |
| `setAutoExportState($state = FixedBlockContentInterface::AUTO_EXPORT_ON_EMPTY)` / `getAutoExportState()` | Get/set the `auto_export` mode controlling automatic default-content export on config update (e.g. only when the snapshot is empty). |

## Lifecycle wiring (module file)

`fixed_block_content.module` keeps the wrapper and the custom block in sync:

- `hook_block_content_delete()` — when a custom block is deleted, the fixed block re-creates an
  empty replacement so its placement keeps rendering.
- `hook_block_content_update()` + `hook_form_alter()` (`_fixed_block_content_update_on_save`) —
  hook custom-block edit forms to trigger auto-export of default content when configured.

## Events / services

- `conflict`-style event subscribers: `SetFixedBlockDependency` (adds the block_content as a
  config dependency of the fixed block) and `ConfigEventSubscriber` (handles config import/lock).
- `BlockContentNormalizer` (tagged `normalizer`, priority 15) customizes HAL normalization of
  the default block content.

There is no public procedural service beyond the entity API above; operate through the
`fixed_block_content` entity storage and these interface methods.
