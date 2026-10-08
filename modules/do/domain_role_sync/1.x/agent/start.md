<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Domain role synchronization (domain_role_sync) — agent index

Grants configured Drupal **roles** to a user, on save, based on the **Domain Access** domains the
user is affiliated with. Package `Domain`. Depends on `domain`. Core `^9 || ^10 || ^11 || ^12`.
License GPL-2.0-or-later. This is the **1.x dev branch** — the `.info.yml` has no `version:` line and
there is no stable release; documented under version dir `1.x`.

- **How mapping is stored, the sync hook, config schema, and how to operate it** →
  [config/sync.md](config/sync.md)

## What it actually is (from source)

- **No** routing, permissions, install, links, JS/CSS, submodules, Drush, plugin types or composer.json.
- Two hook implementations, both wired through one autowired service class
  `Drupal\domain_role_sync\Hook\DomainRoleSyncHooks` (`domain_role_sync.services.yml`, `autowire: true`).
  The procedural `.module` shims (`#[LegacyHook]`) just delegate to that service; the class also
  carries `#[Hook(...)]` attributes for Drupal 11+ OO-hook discovery.
- **`hook_form_domain_edit_form_alter`** (`DomainRoleSyncHooks::formDomainEditFormAlter`): adds a
  *"Domain role synchronization"* details fieldset with a `checkboxes` element listing every user role
  except `authenticated`/`anonymous`. On submit (handler `domain_role_sync_domain_entity_form_submit`
  in `.module`, prepended to the form's `#submit`) the selected roles are written to the Domain config
  entity as third-party settings `domain_role_sync.roles` (unset when empty).
- **`hook_ENTITY_TYPE_presave` for user** (`DomainRoleSyncHooks::userPresave`): iterates the domains
  in the user's `field_domain_access` field; for each domain with a `domain_role_sync.roles`
  third-party setting it calls `$user->addRole($role)` for each mapped role.
- Config schema: `config/schema/domain_role_sync.schema.yml` defines
  `domain.record.*.third_party.domain_role_sync` (a `roles` sequence of role machine-name strings).
  No standalone settings config object, no settings route (`configure: null`).

## Behavior notes

- **One-directional and additive.** Sync runs domain-affiliation → roles, on user presave, using
  `addRole()` only. Roles are **never removed** when an affiliation ends, and the reverse direction
  (assign a domain when a user gains a role) is a README roadmap item, **not implemented** — despite
  the project tagline's "and vice versa".
- Mapping is edited only from the standard Domain edit form; there is no dedicated admin page.
- Not covered by a security advisory policy (dev branch / no stable release).
