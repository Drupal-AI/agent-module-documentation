<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Organic Groups (og) — agent index

API module: any bundle can be a **group**, any bundle with an **OG audience field** is
**group content**, and a fieldable **`og_membership`** entity links a user to a group with a
state and OG roles. The admin UI is in the `og_ui` submodule (see
`modules/og/modules/og_ui/2.0.x/`). `configure: null` on `og` itself.

- **Make a bundle a group / add an audience field / `og.settings` keys / membership types** →
  [configure/groups-and-fields.md](configure/groups-and-fields.md)
- **Services & entity API: memberships, group lookups, access checks** →
  [api/membership-and-access.md](api/membership-and-access.md)
- **Group-level & entity-operation permissions, `OgRole`, the global permission** →
  [permissions/og-permissions.md](permissions/og-permissions.md)
- **The three plugin types OG defines (`og_fields`, `og_delete_orphans`, `og_group_resolver`)
  plus its Views/block/action/condition plugins** →
  [plugins/plugin-types.md](plugins/plugin-types.md)
- **Events (`og.permission`, `og.default_role`, access events) and `hook_og_user_access_alter()`** →
  [hooks/events.md](hooks/events.md)

Fast facts:
- Group registry: `og.settings:groups.<entity_type>[] = <bundle>`.
- Default audience field name/plugin: `og_audience` (`OgGroupAudienceHelperInterface::DEFAULT_FIELD`),
  field type `og_standard_reference`, selection handler `og:default`.
- `OgRole` ids: `<entity_type>-<bundle>-<role_name>`, e.g. `node-club-member`.
  Required names: `member`, `non-member`; plus `administrator` (`is_admin: true`) by default.
- Membership states: `active`, `pending`, `blocked` (`OgMembershipInterface::STATE_*`).
- Services: `og.group_type_manager`, `og.membership_manager`, `og.access`, `og.permission_manager`,
  `og.role_manager`, `og.group_audience_helper`, `og.context`.
- Global permission: `administer organic groups` (grants everything in every group).
- Static facade: `Drupal\og\Og` (`addGroup`, `createField`, `createMembership`, `isMember`, …).
