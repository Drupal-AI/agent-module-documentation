<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# CRM Core Contact (crm_core_contact) — agent index

Defines the CRM's **contact entities**: `crm_core_individual` and `crm_core_organization`
(content entities) plus their config bundle types `crm_core_individual_type` /
`crm_core_organization_type`. Part of the CRM Core suite. Core `^9 || ^10 || ^11`, GPL-2.0-or-later.

Depends on: `crm_core`, `entity` (contrib — `RevisionableContentEntityBase`), core `options`,
`datetime`, `field_ui`, `text`, `views`, and `name` (contrib — the Name field). `configure` route
is `entity.crm_core_contact_type.collection`.

## Entities

- **`crm_core_individual`** (`src/Entity/Individual.php`) — revisionable, publishable, ownable.
  Base fields: `uid` (owner), `status` (Active), `created`, `changed`, `name` (Name field),
  `label` (derived from formatted name in `saveLabel()`). Access handler
  `IndividualAccessControlHandler`; bundle `crm_core_individual_type`.
- **`crm_core_organization`** (`src/Entity/Organization.php`) — same shape but `name` is a string;
  `label()` falls back to "Nameless #id" and fires `hook_crm_core_organization_label_alter`.
- **`crm_core_individual_type` / `crm_core_organization_type`** — `ConfigEntityBundleBase` config
  entities. Config keys: `name/label`, `type/id`, `description`, `locked`, `primary_fields`
  (map of `address|email|phone` → real field name). New revisions default on.

Both content entities expose `getPrimaryAddress()`, `getPrimaryEmail()`, `getPrimaryPhone()` which
resolve through the bundle's `primary_fields` map.

## Routes (`crm_core_contact.routing.yml`)

- `/crm-core/individual` (perm `administer crm_core_individual entities`),
  `/crm-core/organization` (perm `administer crm_core_organization entities`) — entity lists.
- `/admin/structure/crm-core/individual-types` (perm `administer individual types`),
  `/admin/structure/crm-core/organization-types` (perm `administer organization types`).
- Per-entity add/edit/delete/revision routes come from the entity link templates + core route
  providers, and the `entity` module's `RevisionRouteProvider`.

## Permissions (`crm_core_contact.permissions.yml`)

Static: `administer individual types`, `administer organization types`, revision perms
(`view/revert all crm_core_(individual|organization) revisions`). Dynamic via
`ContactPermissions::permissions()` → CRM Core's builder for both entities (+ per-bundle variants
because `permission_granularity = "bundle"`).

## Plugins / services / hooks

- **Action plugins** (`type = crm_core_contact`): `MergeContactsAction`, `JoinIntoHouseholdAction`,
  `SendEmailAction` → [actions/actions.md](actions/actions.md).
- Service `logger.channel.crm_core_contact`.
- Theme hooks `crm_core_individual` / `crm_core_organization` with template suggestions;
  `hook_mail()` key `send_email`.

## Solution docs

- **Entities, bundle types, primary fields, base fields, revisions** → [entities/contacts.md](entities/contacts.md)
- **The three contact action plugins** → [actions/actions.md](actions/actions.md)
