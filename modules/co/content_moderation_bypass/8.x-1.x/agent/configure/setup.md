<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Setup & configuration

There is **no settings form and no `configure` route** for this module. "Configuration" is entirely:
(1) enable the module, (2) have at least one Content Moderation workflow, (3) grant the per-workflow
bypass permission to the roles that should have it. Everything else is automatic — the module wires
itself into core content_moderation on install (a container alter re-classes a core service, and a
base-field-info alter attaches a constraint).

## 1. Prerequisites

- Core **Content Moderation** must be enabled (it is this module's only dependency; it in turn
  requires **Workflows**).
- You need at least one workflow **of type `content_moderation`** (create one at
  `/admin/config/workflow/workflows`, e.g. the core "Editorial" workflow), applied to some entity
  bundles. The bypass permission is generated **per such workflow** — no workflow, no permission.

## 2. Enable

```bash
drush en content_moderation_bypass -y
drush cr    # rebuild the container so the service-class swap + constraint take effect
```

The install has no schema/config to import (`provides_config_schema` is false; there is no
`config/install`).

## 3. Grant the bypass permission

For each workflow `X` a permission `bypass X transition restrictions` now exists. Grant it at
**People → Permissions** (`/admin/people/permissions`), or:

```bash
drush role:perm:add editorial_admin 'bypass editorial transition restrictions'
drush cr
```

```php
\Drupal\user\Entity\Role::load('editorial_admin')
  ->grantPermission('bypass editorial transition restrictions')
  ->save();
```

See [../permissions/permissions.md](../permissions/permissions.md) for how the machine name is built
and how the check is performed on save.

## What the permission does / does not do

- **Does:** let the holder move a moderated entity of that workflow to *any* state directly, ignoring
  the workflow's transition graph and the individual `use X transition Y` permissions. This is enforced
  server-side on entity save, not just in the UI.
- **Does not:** grant *edit* access. The user still needs the normal permission to create/edit the
  entity (e.g. `edit any article content`). The bypass only relaxes the moderation-state transition
  rules for a user who can already edit the content.
- **Scope:** per workflow. Holding it for `editorial` does nothing for `dkan_publishing`.

## Uninstall / revert

`drush pmu content_moderation_bypass -y` then `drush cr`. On uninstall the core service reverts to its
original class and the `BypassModerationState` constraint is no longer attached, so full core
transition enforcement returns. The generated permissions disappear from any role automatically (they
are dynamic, not stored per-role beyond the grant).
