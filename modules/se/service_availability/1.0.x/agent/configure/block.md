<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Setting up Service Availability

1. Enable the module — it installs the **Service** and **Service Message** content types and their fields.
2. Create a **Service** node for each thing you monitor; set its current status and (optionally) an unplanned-outage message.
3. Create a **Service Message** node per scheduled disruption: pick the referenced service, a date/time range, description and impact. The title is set automatically to `Outage on <date>`.
4. Place the **Service Availability** block (plugin `service_availability_services`) on the pages where the status should appear.

Runtime behaviour (`ServiceAvailabilityBlock::build`):
- Lists published services (all, or scoped to the current node's Group if the `group` module context applies).
- For each service, loads published `service_message` nodes whose end time is >= now.
- Promotes a message to "current status" while now is within its range and removes it from "upcoming"; unplanned status on the service overrides with its outage message.
- Block cache max-age is 0 (always fresh).

Security note: queries filter `status = 1` and use `accessCheck(TRUE)`, so unpublished or access-restricted messages are not shown; the block itself is allowed wherever placed, so treat placement as the visibility control.
