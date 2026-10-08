# Entity Limit — manual setup guide

**Entity Limit** (`entity_limit`) lets administrators cap how many entities a user
is allowed to create. You can limit any content entity type (nodes, media, custom
blocks, comments, taxonomy terms — anything with an owner) and target the cap either
**per role** or **per individual user**. Once someone reaches their limit, Drupal
stops them from opening the "add" form for that content.

Each limit is a small configuration item that records: which entity type and which
bundles it applies to, which limiting rule to use (per role or per user), and a
table of "who → how many" rows. A value of `-1` means unlimited, and administrators
are always exempt. When several limits could apply to the same content, the module
resolves the conflict using a configurable weight and the rule's built‑in priority,
so you can, for example, give a whole role a small quota while granting one trusted
user a larger (or unlimited) allowance.

Enforcement hooks into Drupal's normal entity‑create access system, so hitting a cap
simply disables the add form/route for that user — there is no custom checkout or
warning page to build. The two shipped rules (Role Limit and User Limit) cover most
needs, and because limits are a plugin type, a developer can add new conditions
(for example, per group or per time window) without changing the module.

This guide is written for a **human** setting the module up through the admin UI.
If you want terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.
2. [Configuration](configuration/index.md) — create and manage limits, the Role vs
   User rules, and how overlapping limits are resolved.

## Where it lives in the admin menu

Limits are managed at **Structure → Entity Limit**
(`/admin/structure/entity_limit`). Everything there is gated by the **Administer
entity limit** permission.

## How to use it

1. Go to **Structure → Entity Limit** and click **Add** to create a limit.
2. Give it a label, choose the **entity type** and one or more **bundles** it
   applies to, and pick a **limit rule** (Role Limit or User Limit).
3. Save, then use **Manage Limits** to fill in the "who → how many" rows — a number
   per role, or per user. Enter `-1` for unlimited.
4. That's it. The next time a matching user tries to create that kind of content and
   is already at their cap, the add form is blocked automatically.

See [Configuration](configuration/index.md) for the details of each rule and how the
module chooses which limit wins when more than one applies.
