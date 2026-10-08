<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Layout builder default content (layout_builder_default_content) — agent index

**Makes Layout Builder inline blocks survive Default Content export/import by referencing the block by UUID instead of a local id/revision.**

- **Version:** 1.0.x — core `^10 || ^11 || ^12`; depends on `layout_builder` (and, in practice, the Default Content module for the export/import commands)
- **Mechanism:** autowired `DefaultContentSubscriber` event subscriber rewrites the component's inline-block reference (records `block_uuid` on export, resolves it on import). Works around core issue #3553119.
- **Config:** none — no routes, permissions or settings; enabling is the whole setup.
- **Security:** no routes, no permissions, no external calls, no user-facing endpoints. No security findings.
