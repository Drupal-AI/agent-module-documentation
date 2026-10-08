<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Config Role Split is a Config Filter plugin that keeps chosen role permissions out of (or merged into) exported configuration, so specific permissions can be managed per-environment instead of being overwritten on every config import/export.

---

The module provides a single `role_split` Config Filter (via the `drupal/config_filter` API) and a `role_split` config entity to configure it; it has **no effect on a running site** and only acts during `drush config:export` / `drush config:import` (or any config sync). Each Role Split entity lists a set of roles, and for each role a set of permission strings the filter should manage, plus a `mode` (`split`, `fork`, or `exclude`), a `weight`, and an active `status`. In **split** mode the managed permissions are stripped from the exported role config and stored only in the split entity, and merged back onto the role when importing — so those permissions live in the split, not in the shared sync directory. **Fork** mode also merges on import, but on export it will not remove permissions that are already present in the sync directory (a gentler, additive split). **Exclude** mode is the inverse: managed permissions attached to a role in the sync directory are removed on import (so they never reach active config) and added back to the exported file if the site already has them. The filter automatically recalculates each role's config `dependencies` to match the permissions that remain. Because the filter is derived from the `role_split` entities, saving one clears the Config Filter plugin cache. This is a deployment/config-management tool for teams that want, say, `administrator` extra permissions on staging that must never appear in production config.

---

- Keep a permission granted on production out of the exported role config so it is not lost on the next config import.
- Manage environment-specific role permissions (e.g. `access devel information` only on dev) without config drift.
- Prevent an editor role's elevated permission from being overwritten every time config is deployed.
- Split the `administrator` role's site-specific permissions off into per-environment configuration.
- Let a client-managed permission stay on the live site while the rest of the role stays under config control.
- Use **split** mode to fully remove a permission from exported config and re-merge it on import.
- Use **fork** mode to additively keep a permission without stripping ones already in the sync directory.
- Use **exclude** mode to guarantee a permission in the sync directory is never imported into active config.
- Maintain a matrix of role → permissions that differ between staging and production.
- Store sensitive/administrative permissions outside the shared config repository.
- Coordinate multiple splits with different `weight`s so filters apply in a defined order.
- Toggle a split on/off per environment by overriding its `status` in `settings.php`.
- Override a split's `weight`/`status` per environment via config overrides (with a cache clear).
- Ensure exported role config `dependencies` stay correct after permissions are added/removed by the filter.
- Avoid hand-editing exported `user.role.*.yml` files after every export.
- Keep a "superuser"-style permission on one environment only, managed as configuration.
- Roll out a new permission to production without it being reverted by a later config import.
- Document, in config, exactly which role permissions are intentionally environment-specific.
- Combine with Config Split (the sibling module) to fully control what ships between environments.
- Programmatically create Role Split entities as part of a deployment recipe.
- Audit which role permissions are being filtered out of exports across a project.
- Prevent accidental permission escalation on import by excluding risky permissions.
- Manage `authenticated`/`anonymous` role permissions differently per environment.
- Give ops a UI (`/admin/config/development/configuration/config-role-split`) to declare per-role permission overrides.
