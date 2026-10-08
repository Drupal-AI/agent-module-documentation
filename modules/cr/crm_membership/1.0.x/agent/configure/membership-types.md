<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configuring CRM Membership

## Membership types
Create at **Structure → CRM → Membership Types** (`entity.crm_membership_type.collection`).
Each type is a config bundle (`crm_membership_type`) that selects a **MembershipTerm plugin**
and stores its plugin config, plus an optional `default_target_contact` applied to new
memberships that leave `target_contact` empty (`Membership::preSave()`).

### Term plugins (shipped)
- **fixed_duration** — a fixed calendar term (e.g. `P1Y`); may support start/end override and a `time_gap`.
- **rolling_duration** — new periods start from the last active period's end date.
- **lifetime** — never expires (`allowRenewal()`/expiry effectively disabled).

Plugin config keys commonly used: `duration` (ISO-8601, default `P1Y`), `grace_period`
(days added past a period end during which the member still counts as active), and the
plugin's `timeGapKey`. Term plugins are discovered via the `#[MembershipTerm]` attribute
and the `plugin.manager.crm_membership_term` manager; extend `MembershipTermBase` to add one.

## Memberships
Add at the CRM portal **Memberships** (`/crm/membership`, `entity.crm_membership.collection`).
Set the member `contacts` (unlimited) and the `target_contact` (member-of). Status
(`active`/`future`/`expired`) is managed automatically as periods are added/expired.

## Renewal & expiration
- Manual renewal: `/crm/membership/{id}/renew` (permission `renew memberships`), which adds a
  new `crm_membership_period` via the term plugin.
- Automatic expiration: enable cron. `CronHooks::cron()` finds active memberships whose periods
  have all lapsed and enqueues `crm_membership_expiration`; the queue worker calls the term
  plugin's `expire()` to set status `expired` and clear current periods.

## Periods UI
View all periods for a membership at
`/admin/content/crm/membership/{crm_membership}/all-periods` (requires Views and `view memberships`).
