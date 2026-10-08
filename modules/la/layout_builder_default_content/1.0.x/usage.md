<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Makes Layout Builder inline blocks survive default-content export/import by referencing the block by UUID instead of a local id/revision.

---

Layout builder default content lets Layout Builder inline blocks be exported and re-imported with the `content:export` (Default Content) command, working around a core limitation where inline block references are stored by local id/revision and break on import.

An event subscriber (`DefaultContentSubscriber`, autowired) rewrites the inline block reference in a component's configuration: on export it records the block's `block_uuid`, and on import it reads that UUID and resolves it back to the correct local id and revision id. There is no configuration, no routes and no permissions — enabling the module is the whole setup. It addresses core issue #3553119 for inline blocks specifically (not other layout content).

Typical use: enable the module on both the source and destination sites, then use the Default Content module's export/import as normal; inline blocks placed in Layout Builder layouts now round-trip correctly.
---
- Export Layout Builder inline blocks with default content.
- Import inline blocks without broken references.
- Round-trip layouts between environments.
- Reference inline blocks by UUID rather than local id.
- Resolve UUIDs to id/revision on import.
- Work around core issue #3553119 for inline blocks.
- Seed a new site's layouts from exported content.
- Keep inline block content in version control via default_content.
- Avoid manual re-creation of inline blocks after a migration.
- Support Drupal 10, 11 and 12.
- Enable with zero configuration.
- Combine with the Default Content module's CLI.
- Deploy layouts with inline blocks as code.
- Rebuild a demo site's layouts from exported content.
- Keep inline block revisions consistent on import.
- Distribute a starter layout in an install profile.
