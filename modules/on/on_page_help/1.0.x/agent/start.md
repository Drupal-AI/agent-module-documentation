<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# On-page Help (on_page_help) — agent index

**Route/role/node-type-aware help content entity, displayed in a block on matching pages.**

- **Version:** 1.0.x (1.0.1)
- **Core:** ^9 || ^10 | ^11
- **Depends on:** link, node, options, prepopulate
- **Entities:** `on_page_help` (content, revisionable, translatable, publishable) + `on_page_help_type` (config bundle). Default type `route_on_page_help` shipped in config.
- **Block:** `on_page_help_block` (matches current route; filters by node type + required roles + view access; offers prepopulated add link).
- **Permissions:** `add / edit / delete / view published / view unpublished / view all revisions / revert / delete all revisions on-page help`, `administer on-page help` (restricted), plus per-type + "own" permissions via `OnPageHelpEntityPermissions::generatePermissions`. Enforced by `OnPageHelpEntityAccessControlHandler`.

**Security:** all operations permission-gated through a dedicated access handler (published vs unpublished vs own); the block re-checks `access('view')` and current-path access before display. No security findings.

See [configure/help-items.md](configure/help-items.md).