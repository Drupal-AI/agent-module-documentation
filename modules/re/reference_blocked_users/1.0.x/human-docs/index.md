# Reference Blocked Users — manual setup guide

**Reference Blocked Users** (`reference_blocked_users`) adds a single permission
that lets non‑administrator roles select **blocked** user accounts (as well as
active ones) in any user entity‑reference field — including the core node
"Authored by" field. Out of the box, Drupal only offers *active* accounts in a
user reference autocomplete or select list unless the person editing holds the
powerful `administer users` permission. This module lifts that restriction for a
much narrower, purpose‑built grant.

It works by shipping one entity‑reference selection handler that quietly becomes
the default for *every* user reference field site‑wide — no per‑field
configuration is needed. When the current user lacks `administer users` but holds
the module's `reference blocked users` permission, the handler runs a query that
includes blocked accounts; for everyone else the behavior is exactly as before
(active accounts only). Access checks, role filters, and the anonymous‑user rule
are all still honored — the only thing that changes is that blocked accounts
become selectable.

This solves a real gap: the "Authored by" field has no per‑field settings form,
so there was previously no way to let editors attribute content to a blocked
account short of handing them the full user‑administration permission. Typical
uses are reattributing content to a suspended author, keeping authorship pointing
at a real (now‑blocked) person instead of Anonymous, or assigning a "reviewed by"
/ "assigned to" field to a deactivated account.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

## Where it lives in the admin menu

The module has no settings form of its own. Everything it does is controlled by a
single permission on the standard **People → Permissions** page
(`/admin/people/permissions`).

## How to use it

1. Install and enable the module (see [Installation](installation/index.md)).
2. Go to **People → Permissions** (`/admin/people/permissions`) and find the
   **Reference blocked users** permission (provided by Reference Blocked Users).
3. Tick the box for each role that should be allowed to reference blocked
   accounts — for example an editorial or moderator role — then **Save
   permissions**.

That is the whole setup. From then on, any user reference field (autocomplete or
select, including the node "Authored by" field) will include blocked accounts for
users in those roles. No field‑level changes are required. A user who already has
`administer users` sees all accounts through core, so this extra permission only
matters for non‑admin roles.

If you need a specific field to keep the stock behavior (active users only), set
that field's reference handler explicitly to *Default: User* — an explicitly set
handler is not overridden by this module.
