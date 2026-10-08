<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# RedHen data model (3.0.x)

All three primary entities are `ContentEntityType`s using `EntityChangedTrait`, with revision tables,
bundle config entities, and RedHen `*AccessControlHandler` access handlers.

## Contact — `redhen_contact` (submodule `redhen_contact`)

- Class: `Drupal\redhen_contact\Entity\Contact`. Bundle entity: `redhen_contact_type`.
- Base table `redhen_contact`, revision table `redhen_contact_revision`.
- Base fields: `first_name`, `middle_name`, `last_name` (string, required-ness driven by
  `redhen_contact.settings:required_properties`), `email` (`email` field, unique via the
  `ContactEmailUnique` constraint, required when `valid_email` is TRUE), `uid` (entity_reference to
  `user`, nullable — the "Linked user"), `status` (boolean active flag), `created`, `changed`.
- `label()` = `getFullName()` (first + middle + last), altered via `hook_redhen_contact_name_alter`.
- Owner semantics: `getOwnerId()` / `getOwner()` return the **linked Drupal user** (`uid`), which the
  access handler uses for "own" permissions.
- Routes/links: canonical `/redhen/contact/{redhen_contact}`, add `/redhen/contact/add/{type}`,
  edit `/redhen/contact/{id}/edit`, delete `.../delete`, collection `/redhen/contact`.
- User-linking behavior (config `redhen_contact.settings`):
  - `connect_users`: on save, if no user is linked and the email matches an existing account
    (`user_load_by_mail`), that user is auto-linked (`preSave`). If a user is linked and
    `connect_users` is on, the contact's email is **mirrored onto the Drupal user account**
    (`postSave` calls `$user->setEmail()->save()`).
  - `unique_email`, `valid_email`, `required_properties`, `registration*`, `embed_on_user_form`,
    `alter_username`, `connect_contacts` are the other settings keys.
- Static helpers: `Contact::loadByUser($account, $status = TRUE)`,
  `Contact::loadByMail($email, $status = TRUE)` (both `accessCheck(TRUE)`).
- Autocomplete: `/admin/redhen_contact/autocomplete` (permission `edit contact entities`) returns
  `label (email)` matches over `first_name`/`last_name`/`email` (parameterised query; input
  `Xss::filter`-ed, `%` stripped, limit clamped 1–100).

## Organization — `redhen_org` (submodule `redhen_org`)

- Class: `Drupal\redhen_org\Entity\Org`. Bundle entity: `redhen_org_type`.
- Base table `redhen_org` / `redhen_org_revision`. Entity keys include `uid = user_id` and
  `label = name`.
- Base fields include `name` (label), `status`, `created`, `changed`.
- Routes/links mirror Contact under `/redhen/org/...`.

## Connection — `redhen_connection` (submodule `redhen_connection`)

- Class: `Drupal\redhen_connection\Entity\Connection`. Bundle: `redhen_connection_type` (config).
- Models a relationship between two entities via **endpoint reference fields** (default
  `endpoint_1`, `endpoint_2`; `REDHEN_CONNECTION_ENDPOINTS = 2`) plus a `role` reference.
- **Connection Type** (`ConnectionType`) declares each endpoint's allowed entity type/bundle
  (`endpoints.1.entity_type`, `endpoints.2.entity_type`, …) and exposes helpers
  `getEndpointFields()`, `getEndpointEntityTypeId()`, `getAllEndpointFields()`.
- **Connection Role** (`ConnectionRole`, config entity) carries a `permissions` structure keyed by
  a permission-key (e.g. `connection`, `redhen_contact`, `redhen_org`) whose value lists the
  operations (`view`/`update`/`delete`/`create`) that role grants — consumed by the delegation layer
  (see access-model.md).
- `ConnectionService` (`redhen_connection.connections`) is the query API:
  `getConnections()`, `getConnectionTypes()`, `getConnectedEntities()`, `getConnectionCount()`,
  `checkConnectionPermission()`, `getAllConnectionEntityTypes()`. Its queries run with
  `accessCheck(FALSE)` (it is an internal service, not a user-facing lister).
- Adds a **"Connections" tab** to any linkable entity: `hook_entity_type_alter` sets a
  `redhen_connection` link template (`{canonical}/connections`) on every entity type with a
  canonical link + view builder; a RouteSubscriber builds the listing route, rendered by
  `RedhenConnections::list`.
- Lifecycle hooks: making a contact/org inactive can cascade-deactivate its active connections
  (config `auto_disable_connections`); deleting a contact/org deletes its connections.
- Tokens: `redhen_connection` token type (`id`, `endpoint_1`, `endpoint_2`, `name`, `type`,
  `status`, `created`).

## Dedupe (submodule `redhen_dedupe`)

- `/admin/config/redhen/dedupe` lists contacts sharing selected field values;
  `/admin/config/redhen/dedupe/merge/{entity_ids}` is the merge form (pick a master, choose per-field
  values, re-point related entities, delete the losers in a DB transaction).
- Both routes require the permission `administer redhen contacts` — note this string is **not defined
  anywhere in the module** (the real admin permission is `administer contact entities`), so on a
  normal site these pages are reachable only by the superuser. Treat dedupe as effectively
  superuser-only in this release.
