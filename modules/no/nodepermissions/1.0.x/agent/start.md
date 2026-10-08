<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Granular Node Permissions — agent index

Separate **per-field permissions for node administrative fields** (`uid`/`status`/`created`/`promote`/
`sticky`) — delegate specific capabilities without full `administer nodes` (grants via
`hook_entity_field_access` `allowedIfHasPermission`). Depends on core `node`. Version **1.0.2**. Core
`^10.1||^11||^12`.

**Assign to match trust:** each delegates a sensitive capability — `administer node uid` = change authorship
(spoofing), `status` = publish/unpublish, `promote`/`sticky` = front-page/ordering. Additive grant (opens
fields to permission-holders). Grant deliberately.
