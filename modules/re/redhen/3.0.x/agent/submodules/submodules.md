<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# RedHen submodules (3.0.x)

The core `redhen` module ships shared plumbing only (dashboard/admin menu routes, settings form,
toolbar item, `redhen.active`/`redhen.inactive` events, `redhen_get_entity_from_route()` helper).
Everything else is a submodule. This release contains exactly four.

## redhen_contact
- Deps: `redhen`, `user`, `entity`, `field`, `views`. Configure:
  `entity.redhen_contact_type.collection`.
- Provides the **Contact** content entity + `redhen_contact_type` bundle, the
  `ContactAccessControlHandler`, `ContactForm`/`ContactDeleteForm`/`ContactSettingsForm`,
  the `ContactEmailUnique` validation constraint + validator, a `CurrentContact` Views argument
  default, a `RedhenContactFormBlock` block, a contact-autocomplete widget + controller, and a route
  context provider for the current contact.
- Ships a **legacy Drush 8 `.drush.inc`** (`redhen-contact-link-users`, links users to contacts by
  email). It is Drush-8-style (`hook_drush_command`) and is not wired for modern Drush command
  discovery — treat it as effectively non-functional on Drupal 10/11's Drush; the same logic is
  reachable programmatically via `Contact::loadByMail()`.
- Config: `redhen_contact.settings` (unique_email, required_properties, connect_users,
  connect_contacts, valid_email, embed_on_user_form, alter_username, registration*).

## redhen_org
- Deps: `redhen`, `entity`, `field`, `views`. Configure: `entity.redhen_org_type.collection`.
- Provides the **Organization** entity + `redhen_org_type` bundle, `OrgAccessControlHandler`, org
  forms, an `OrgIdFromUrl` Views argument default, and a route context provider.
- Has **no `.routing.yml`** — all routes come from the entity's HtmlRouteProvider.

## redhen_connection
- Deps: `redhen`, `entity`, `field`, `views`, `redhen_contact`, `redhen_org`. Configure:
  `entity.redhen_connection_type.collection`.
- Provides the **Connection** content entity, **Connection Type** and **Connection Role** config
  entities, and their access handlers.
- Services: `redhen_connection.connections` (`ConnectionService`, the query/permission API),
  `redhen_connection.views_data`, a RouteSubscriber, the `_redhen_connection_access` access check,
  and `plugin.manager.connection_permission`.
- **Plugin type provided: `ConnectionPermission`** (`@ConnectionPermission` annotation,
  `ConnectionPermissionManager`, base `ConnectionPermissionBase`). Shipped plugins:
  `ConnectionConnectionPermission`, `OrgConnectionPermission`,
  `SecondaryContactConnectionPermission` — these drive the connection-role access delegation in
  `hook_entity_access`/`hook_entity_create_access`.
- VBO/Actions: `ActivateConnection`, `DeactivateConnection`, `ChangeConnectionRole` (executed via
  action/bulk-op forms, i.e. POST).
- Adds a `redhen_connection` link template + "/connections" listing tab to every linkable entity
  type (`hook_entity_type_alter` + RouteSubscriber). Ships a Views view
  `redhen_connection_list` and a `ConnectionRelationship` Views relationship.
- Config: `redhen_connection.settings` (includes `auto_disable_connections`).

## redhen_dedupe
- Deps: `redhen_contact` only.
- Two routes under `/admin/config/redhen/dedupe` (list + `merge/{entity_ids}`), both requiring the
  permission string `administer redhen contacts` — which **no module defines** (the real one is
  `administer contact entities`), so in practice only the superuser can reach dedupe.
- The merge form loads the candidate contacts, lets an admin pick a master and per-field values,
  optionally re-points related entities, and deletes the losers inside a DB transaction. The merge
  code still references `redhen_note`/`redhen_engagement`/`redhen_membership` conditionally, but
  those submodules do not exist in this release, so only the `redhen_connection` re-point branch is
  live here.

## Not in this release
Older RedHen documentation (and the bundled `README.txt`) describe **membership, notes, engagement
scoring, and groups** submodules. **None of those are present in 3.0.x** — the shipped set is
contact, org, connection, dedupe. Do not tell users they can enable `redhen_membership`,
`redhen_note`, `redhen_engagement` or `redhen_group` from this package.
