<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Service Availability shows the current status of one or more services plus their upcoming scheduled disruptions, driven by two content types and a block.
---
Installing the module creates a **Service** content type (with a current-status field and an unplanned-outage message) and a **Service Message** content type (date/time range, description, impact, and a reference to a service). A `hook_form_alter` simplifies both node forms (auto-titles Service Messages as "Outage on <date>", hides revision/menu widgets). The `ServiceAvailabilityBlock` block renders each published service as a tab, lists its published, still-current-or-future messages, calculates each disruption's duration and hours per day, automatically promotes a message to "current status" once its time arrives, and drops messages once they have passed. If placed on a node that belongs to a Group, it scopes services to that group; otherwise it shows all services.

The block only queries published nodes (`status = 1`) and uses `accessCheck(TRUE)` on its entity queries, so node access is respected and unpublished content is not shown. `blockAccess()` returns allowed, meaning the block is visible wherever it is placed — which is intended for a public status display; sensitivity is controlled by what you publish and where you place the block, plus normal node-access. There are no custom routes, no anonymous mutation endpoints, and no external calls. Setup: enable the module, create Service and Service Message nodes, and place the "Service Availability" block.
---
- Show a live status board for multiple services
- Publish upcoming scheduled maintenance windows
- Automatically move a scheduled message to "current" at its start time
- Automatically remove disruptions once they have ended
- Display the duration and daily hours of each disruption
- Render each service as its own tab in the block
- Auto-title outage messages as "Outage on <date>"
- Scope the status display to a Group context
- Show all services when placed outside a Group
- Communicate unplanned outages via a per-service message field
- Place the status block on a landing or support page
- Let editors add a Service node per monitored service
- Let editors add a Service Message per scheduled disruption
- Categorise disruptions by impact level
- Keep the block uncached so status is always current
- Present planned vs current disruptions separately
- Convert stored UTC times to the site timezone for display
- Provide a public uptime/status page from Drupal content
- Hide revision and menu widgets on the simplified node forms
- Sort messages by date within each service
- Track multiple upcoming messages per service
- Surface a service's current status label (normal/impacted)
