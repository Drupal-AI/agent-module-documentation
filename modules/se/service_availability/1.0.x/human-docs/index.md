# Service Availability — manual setup guide

**Service Availability** (`service_availability`) provides a block that shows the
current status of one or more services, together with any upcoming scheduled
disruptions — the kind of thing you would put on a public status or support page
so visitors can see at a glance whether everything is running normally and what
maintenance is coming up.

It is driven by content rather than a settings screen. Installing the module
automatically creates two content types: a **Service** (one per thing you want to
show the status for, with a current-status field and an unplanned-outage message)
and a **Service Message** (one per scheduled disruption, carrying a date/time
range, a description, an impact level, and a reference to the service it affects).
The block then does the clever part at display time: it renders each published
service as its own tab, lists that service's still-current or future messages,
works out the duration and daily hours of each disruption, automatically promotes
a scheduled message to "current status" the moment its start time arrives, and
drops messages from view once they have passed. You can add multiple services, and
multiple upcoming messages per service. If the block is placed on a node that
belongs to a **Group**, it scopes the services shown to that group; placed
anywhere else, it shows all services.

Setup is minimal and needs no configuration form: you enable the module, create
your Service and Service Message content, and place the block where you want the
status to appear. It depends on core's **Block** module and the **Datetime
Range** module, and runs on Drupal 8.8 through 10.

On visibility and safety: the block only ever queries **published** nodes and
respects node access, so unpublished or access-restricted content is never leaked.
The block itself is allowed wherever you place it — which is exactly what you want
for a public status display — so treat *what you publish* and *where you place the
block* as your visibility controls. There are no custom routes, no anonymous
mutation endpoints, and no external calls.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer,
   enable it, and set up your services, messages, and the block.

## How to use it

1. **Create a Service** node for each thing you monitor, and set its current
   status (and, if needed, an unplanned-outage message).
2. **Create a Service Message** node for each scheduled disruption: pick the
   service it affects, a date/time range, a description, and an impact level. The
   title is filled in for you automatically as "Outage on &lt;date&gt;", and the
   node form is simplified (revision and menu widgets are hidden).
3. **Place the Service Availability block** on the pages where the status should
   appear (Structure → Block layout).

From then on the block keeps itself current: scheduled messages move into "current
status" at their start time and disappear once they have passed, and each
disruption's duration is calculated for you. Because status must always be
accurate, the block is not cached.
