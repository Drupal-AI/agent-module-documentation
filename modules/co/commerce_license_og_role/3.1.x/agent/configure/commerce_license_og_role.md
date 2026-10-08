<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configuring Commerce License OG Role

## Requirements
Enable `og`, `commerce_license`, `dynamic_entity_reference`, and this module. Have at least one OG group entity and OG roles defined.

## Create the licensed product
1. Create/choose a product variation type that uses **Commerce License** (a license field on the variation).
2. On the variation, set the license type to **OG Role** (`commerce_license_og_role`).
3. Configure the license:
   - **Target group** — referenced via dynamic entity reference (can point at different group entity types).
   - **OG role** — the role granted to the buyer within that group.
   - **Membership type** — the group type's default membership type is used unless configured otherwise.
   - **License duration** — how long the grant lasts (integrate `commerce_license`/recurring for renewals).

## Lifecycle
- On license **activation** the plugin creates/updates the buyer's OG membership and assigns the configured role.
- On **expiration/revocation** the membership/role grant is removed.
- The granted group/role entity is **locked** while a license is active (GrantedEntityLockingInterface), and **existing-rights checking** stops selling access the user already has.

## Permissions
- `grant group roles with licenses in any group` (permissions.yml, restrict access) — lets a license grant membership of *any* group; assign only to trusted store admins.
- Per-group OG permission `grant group roles with licenses` (via `OGPermissionsEventSubscriber`, default OG administrator) — lets group admins allow this within their own group only.
