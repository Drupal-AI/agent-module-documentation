Block Usage Report adds a single read-only admin report at `/admin/reports/block-usage` that lists which blocks are placed in the site's default theme, whether each is enabled or disabled, the region it occupies, and — critically — placements that no core screen summarises, including Layout Builder and block-field embeds.

---

On a mature site, "where is this block actually used?" is a genuinely hard question. Blocks live in the block layout per theme, but they also live inside Layout Builder sections (both bundle-default templates and per-entity overrides), inside `block_field` field instances on content and paragraphs, and behind `fixed_block_content` indirection — configuration that no single core screen gathers into one view. When you are about to delete a custom block, or auditing what a theme still depends on, that missing overview is a real gap.

This module fills it with one report built by `BlockUsageReportController::build()`. It walks the `block` config entities placed in the default theme and splits them into enabled and disabled tables; it queries `block_field` field tables to find blocks embedded in content (climbing the paragraph ownership chain to the owning entity); and it uses the `LayoutBlockFinder` service to surface blocks in Layout Builder — separating bundle-default-layout blocks from true per-entity overrides. It also lists every custom block that it never found placed anywhere ("unplaced custom blocks"), which is exactly the set that is safe to consider for deletion. Each row links to the relevant operations (edit/delete). The `block_field`, `layout_builder` and `fixed_block_content` integrations are auto-detected — the corresponding sections simply do not appear if those modules are absent.

It is a reporting tool: no writes, no configuration form, no schema. It reads the current default theme's placements only, so blocks placed in a non-default theme are intentionally out of scope. Reach for it during a cleanup, an audit, or a theme migration rather than day to day.

---

- See which region a block is placed in on the default theme.
- Audit which blocks are enabled versus merely placed but disabled.
- Find blocks placed via Layout Builder that the core block layout page misses.
- Distinguish Layout Builder bundle-default placements from per-entity overrides.
- Find blocks embedded in content through the `block_field` module.
- Trace a block-field embed on a paragraph up to its owning content entity.
- Identify custom blocks that are unplaced anywhere ("safe to delete" candidates).
- Check block usage before deleting a custom block.
- Inventory blocks during a site cleanup.
- Support a theme migration by seeing what the current theme depends on.
- Get a single block-placement overview across region, field and layout placements.
- Resolve custom blocks referenced indirectly through `fixed_block_content`.
- Review structural dependencies on a particular block.
- Jump from a report row straight to the block's edit/delete operations.
- Confirm a custom block is genuinely orphaned before removing it.
- Read block usage without touching any configuration.
- Plan a block library refactor with a full placement inventory.
- Document a site's block usage for handover or onboarding.
- Answer "where is this block used?" in one place.
- Prepare for a block-content migration by enumerating placements.
- Audit block layout before a redesign.
- Spot broken or missing custom-block references shown as "[broken/missing]".
- Give site auditors a reports-permission-gated placement view.
