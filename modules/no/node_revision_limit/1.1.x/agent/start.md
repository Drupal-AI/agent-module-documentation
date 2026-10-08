<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Node Revision Limit (node_revision_limit) — agent index

**Deletes the oldest node revisions on update, keeping at most a configured number (global and/or per content type).**

- **Version:** 1.1.x
- **Core:** ^8 || ^9 || ^10
- **Depends:** none
- **Configure:** `/admin/config/content/node_revision_limit` (route `node_revision_limit.settings`, `administer site configuration`).

**Surface:** settings form (`NodeRevisionLimitForm`) + service `NodeRevisionLimitManager` invoked on node update; config `node_revision_limit.settings` (+ schema). No custom permissions or content routes.

**Security:** automatic maintenance only; deletes surplus historical revisions (keeps current). Configuration behind `administer site configuration`. No web-facing input beyond the admin form.
