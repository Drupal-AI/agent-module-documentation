<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Donotuse is an empty placeholder module: its name is a literal instruction not to use it.

---

It ships only an `.info.yml` (declaring dependencies on `cohesion` and `cohesion_base_styles`), a composer manifest requiring `acquia/cohesion`, a one-line README, and a licence — there is no PHP, routes, services, hooks, permissions, or config. Enabling it does nothing except pull in the declared Cohesion dependencies. It appears to be a namespace/experimental artifact published to drupal.org rather than a functional module.

Security posture is trivially clean: no code means no endpoints, no data handling, and nothing to attack. There is no meaningful setup task other than to avoid installing it; if encountered on a site, treat it as safe to remove unless something inadvertently depends on it.

---
- Recognise `donotuse` as a non-functional placeholder module.
- Confirm it contains no PHP code or routes.
- Note its only effect is declaring Cohesion dependencies.
- Avoid enabling it on any real site.
- Safely uninstall it if found enabled.
- Check nothing depends on it before removal.
- Understand it requires `acquia/cohesion` via composer.
- Document it as a deprecated/experimental stub.
- Use it as an example of a dependency-only module shell.
- Verify no config or schema is provided.
- Exclude it from production module lists.
- Skip it when auditing functional modules.
- Treat its README ("Do Not Use") as authoritative.
- Note it targets Drupal >=9.3.
- Flag it in a module inventory as inert.
