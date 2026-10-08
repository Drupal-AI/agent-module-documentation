<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# recreate_block_content (Recreate Block Content) — agent start

Recreates empty `block_content` entities on a target site for custom blocks that exported
config references but whose content was never exported (Drupal exports block *placements*,
not block *content*). It hooks `hook_rebuild()` and `hook_install()`, scans
`config.manager->findMissingContentDependencies()` for `block_content`, and creates a
placeholder block with the matching `type` (bundle), `uuid`, and a best-effort `info` title.

Key facts: depends on core `block_content`. **No UI, no routes, no settings, no permissions,
no Drush commands, no config schema, no plugins.** You trigger it by **clearing caches**
(`drush cr` or Admin → Configuration → Development → Performance). Works with Panels /
Page Manager and core Block layout; not Panelizer (no block config dependency). Reports each
recreated block (or missing-bundle failure) to the messenger and the `recreate_block_content`
logger.

- How the rebuild works, how to trigger it, the two functions, title resolution, and the messages/logs → [api/recreate_block_content.md](api/recreate_block_content.md)
