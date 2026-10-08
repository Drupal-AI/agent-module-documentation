# Configuration

Commerce License OG Role has no standalone settings page. Configuration happens in
two places: on the **license product variation** (what a license grants), and on
**permissions** (who is allowed to set up such grants).

## Before you start

Make sure you have:

- OG, Commerce License, and Dynamic Entity Reference enabled (see
  [Installation](../installation/index.md)).
- At least one **OG group** entity created.
- The **OG roles** you want to grant already defined.

## Create the licensed product

1. Log in as a user allowed to create license products (see permissions below).
2. Create or choose a **product variation type** that uses **Commerce License**
   (that is, it has a license field on the variation).
3. On the variation, set the **license type** to **OG Role**
   (`commerce_license_og_role`).
4. Configure the license:
   - **Target group** — the OG group the license grants access to (referenced via
     dynamic entity reference, so it can point at different group entity types).
   - **OG role** — the role the buyer receives within that group.
   - **Membership type** — the group type's default membership type is used unless
     you configure otherwise.
   - **License duration** — how long the grant lasts. Combine with Commerce
     License / recurring billing for renewals.

## How the lifecycle behaves

- On license **activation**, the module creates or updates the buyer's OG
  membership and assigns the configured role.
- On **expiration or revocation**, the membership/role grant is removed
  automatically.
- While a license is active, the granted group/role is **locked** so it can't be
  changed out from under the subscription, and **existing‑rights checking** stops
  the store from selling access the buyer already holds.

## Assign the permissions carefully

Two restricted permissions control who may configure license‑driven role grants —
treat both as sensitive:

- **`grant group roles with licenses in any group`** (under **People →
  Permissions**) — lets a license grant membership of **any** group, bypassing
  per‑group control. Grant this **only** to trusted store administrators, and
  sparingly.
- **`grant group roles with licenses`** (a **per‑group OG permission**, registered
  by the module's OG permissions event subscriber, defaulting to group
  administrators) — lets a group's own admins allow license‑granted roles **within
  their own group only**. This is the safer, scoped option for delegating setup to
  group owners.

## Test both directions

Buy the licensed product and confirm the buyer gains the configured OG role in the
target group; then let the license expire (or revoke it) and confirm the membership
and role are removed. Verify that users without the appropriate permission cannot
configure a license to grant group roles.
