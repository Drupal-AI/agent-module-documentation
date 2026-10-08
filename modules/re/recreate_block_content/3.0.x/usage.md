Recreate Block Content recreates placeholder `block_content` entities on a target site for custom blocks that are referenced by exported configuration but whose content was never exported. It does not export or move any block content — it just creates empty, correctly-typed blocks (matching bundle and UUID) so the imported config no longer points at missing content.

---

Drupal's configuration system exports block *placements* and layouts (e.g. `block.block.*`, Panels/Page Manager variants) but never the custom `block_content` entities themselves, because those are content, not config. Importing that config on a fresh site leaves a "missing content dependency" — the block placement references a UUID that has no matching `block_content` entity. This module hooks into `hook_rebuild()` (fired on every cache rebuild) and, on install, scans `config.manager` for missing `block_content` dependencies via `findMissingContentDependencies()`. For each one whose block type (bundle) exists, it creates an empty `BlockContent` entity with the exact `type`, `uuid`, and a best-effort `info` title, then saves it so editors can fill in the real content later. Titles are resolved by preference: the `settings.label` of a `block` config that uses the block, then a Page Manager variant block label, otherwise the config dependency name. Since 8.x-2.0 it works with any module that declares a config dependency on a block (including Panels; not Panelizer, which declares no such dependency). It has no UI, no settings, and no permissions — you trigger it simply by clearing caches (`drush cr` or Admin → Configuration → Development → Performance → Clear all caches). Messages report each block created (or each failure when the bundle is missing) both on-screen and to the logger. For actually exporting block *content*, the README points to Fixed block content, Simple block, or Deploy instead.

---

- Recreate missing custom blocks after importing configuration onto a fresh or rebuilt Drupal site.
- Fix "missing content dependency" errors that appear when `drush config:import` references a custom block that was never exported.
- Restore placeholder blocks in a CI/CD pipeline that deploys config but not content, keeping block placements valid.
- Provision the correct `block_content` UUIDs on a staging or production site so an editor only has to fill in the body text.
- Support Panels / Page Manager layouts that place custom blocks, recreating those blocks after a config deploy.
- Recreate blocks referenced by core Block layout placements (`block.block.*`) with the label pulled from the placement.
- Keep a content-free version-controlled config workflow (blocks in config, content entered per-environment) working without manual block creation.
- Bulk-create every missing block in one pass by simply running a cache rebuild after install.
- Automatically trigger block recreation at install time via `hook_install()` when the module is enabled during deployment.
- Re-trigger recreation any time later just by clearing caches — no dedicated command needed.
- Get an on-screen and logged report listing exactly which blocks were recreated during a deploy.
- Detect and log deployment mistakes where a referenced block type (bundle) does not exist on the target site.
- Preserve block UUIDs across environments so config references resolve identically everywhere.
- Give content editors ready-made empty blocks to populate instead of asking them to create blocks by hand with matching UUIDs.
- Recover blocks after a database rebuild where config survived (in code) but content did not.
- Seed a brand-new environment with the placeholder blocks required by an exported theme/layout.
- Avoid broken layouts in Layout Builder / Panels where a component references a nonexistent block entity.
- Serve as a lightweight alternative to full content-deployment tools when only empty placeholders are needed.
- Integrate into a `drush deploy` hook chain, where the post-import cache rebuild recreates any newly-referenced blocks.
- Diagnose which config objects depend on a given block via the same dependency lookup the module uses for titling.
- Migrate a site to config-based block management incrementally without losing block placements.
- Ensure automated tests that import config do not fail on missing block content dependencies.
- Recreate blocks for multiple block types (bundles) in a single rebuild, skipping any whose bundle is absent.
- Provide meaningful placeholder titles (from the block placement label) so editors can identify which block to fill in.
