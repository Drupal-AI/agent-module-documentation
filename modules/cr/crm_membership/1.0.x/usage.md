<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
CRM Membership adds a membership-management framework to the CRM project, linking Contact entities to membership types, periods, and pluggable term rules that drive activation, renewal and expiration.

---

The module defines three entities: a **Membership** content entity (`crm_membership`, revisionable, published/unpublished), a **Membership type** config bundle (`crm_membership_type`) that selects a term plugin and its settings, and a **Membership period** entity (`crm_membership_period`) recording concrete start/end date ranges and the contacts a period applies to. A membership links one or more member contacts (`contacts`) to a `target_contact` (the organization/household they are a member of). Term behaviour is supplied by `MembershipTerm` plugins — three ship in-box: **Fixed Duration** (fixed calendar term), **Rolling Duration** (renews from the last period end), and **Lifetime** (never expires). The `crm_membership.service` (`MembershipService`) answers membership questions for other modules — `isMember()`, `getMemberships()`, `getMembershipsForTarget()` — and dispatches a `MembershipEvents::IS_MEMBER` event so custom logic (e.g. household relationships) can extend the answer.

Lifecycle is automated by cron: `CronHooks::cron()` scans active memberships whose periods have all expired (or which have no current period) and queues them into the `crm_membership_expiration` queue worker, which marks them expired via the term plugin. Renewal is a manual `renew-form` at `/crm/membership/{id}/renew` gated by the `renew memberships` permission. Access is enforced by a dedicated `MembershipAccessControlHandler` mapping view/update/renew/delete operations to granular permissions, with `administer crm_membership` as the admin override; unpublished memberships are only visible to admins. Note the service-layer entity queries run with `accessCheck(FALSE)` by design (internal membership computation) — results are not rendered directly to unprivileged users. Typical setup: enable the module (requires the CRM and Duration Field projects plus core Datetime Range), create membership types under Structure → CRM → Membership Types choosing a term plugin, then add memberships from the CRM portal at `/crm/membership`.

---
- Enable membership management on a CRM/Contact-based site
- Create a Fixed Duration membership type (e.g. annual membership)
- Create a Rolling Duration type that renews from the previous period's end
- Create a Lifetime membership type that never expires
- Link one or more contacts to an organization as members
- Set a default target contact on a membership type
- Record membership periods with explicit start and end dates
- Renew a membership manually via the renew form
- Add a grace period so lapsed members stay active for N days
- Let cron automatically expire memberships whose periods have ended
- Query whether a contact is a member of a target organization in code
- List all active memberships for a given contact
- Retrieve all memberships whose target is a given contact
- Extend membership logic via the MembershipEvents::IS_MEMBER event
- Support household/indirect memberships through the is-member event
- Write a custom MembershipTerm plugin for bespoke term rules
- Grant staff the 'view memberships' or 'edit memberships' permission
- Restrict renewal to a role via the 'renew memberships' permission
- Browse memberships and periods from the CRM portal menu
- View all periods for a membership via the Views-provided listing
- Unpublish a membership to hide it from non-admin users
- Track membership status (active / future / expired) per record
- Report on memberships and periods using the provided Views data
- Override start/end dates on term plugins that allow it
