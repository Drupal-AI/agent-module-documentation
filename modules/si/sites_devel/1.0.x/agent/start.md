<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Sites devel (sites_devel) — agent index
**Development helper for the Sites ecosystem: a debug block dumping site/route/language context and Devel dumper access while development mode is on.**

- **Version:** 1.0.x
- **Core:** ^11 || ^12
- **Depends on:** sites, devel, block_plugin_view_builder
- **Permission:** `use sites_devel` (Use sites development; restrict access) — OR everyone while the `%sites.development%` container parameter is TRUE.
- **Service:** `DevelDumperManagerDecorator` decorates `devel.dumper` (priority 10) to unlock dumper output in dev mode.
- **Block:** "Sites devel debug" (via block_plugin_view_builder), auto-rendered.

**Security:** development-only. No admin/config route and no mutating endpoints; but when `sites.development` is TRUE the debug block and Devel dumper are exposed to ALL users — never enable on production.
