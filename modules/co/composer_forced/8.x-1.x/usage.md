<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Composer Forced disables core Update Manager's install-and-update forms, so nobody can add or upgrade a module through the browser on a site whose dependencies are managed by Composer.

---

On a Composer-managed site, installing a module through the UI is a quiet disaster: the file lands on disk, `composer.json` and `composer.lock` never learn about it, and the next `composer install` — a deployment, a rebuild, a colleague's fresh clone — silently deletes it. The damage usually surfaces days later as an unexplained missing feature. This module removes the temptation by taking the forms away. The whole implementation is `src/ComposerForced.php` plus `composer_forced.module`; there are no routes, permissions, configuration or entities, and core `update` is the only dependency, with a very wide `^8 || ^9 || ^10 || ^11` core range. What it does *not* do is equally worth stating: update *availability* reporting still works, so the security update notices at `/admin/reports/updates` continue to appear — only the "Install new module" and "Update" actions are blocked. It is a guardrail against accidents rather than a security control; anyone with file access or `administer modules` can still change the codebase by other means.

---

- Stop modules being installed through the browser.
- Prevent a UI update wiping out composer.lock.
- Protect a Composer-managed site from dependency drift.
- Enforce a deploy-through-git policy.
- Avoid files appearing on disk that composer does not know about.
- Keep a production site's codebase immutable.
- Remove a tempting button from the admin UI.
- Support a team where only CI deploys code.
- Preserve reproducible builds.
- Keep security update notices while blocking UI updates.
- Reduce accidental changes by site administrators.
- Match Drupal's own recommended workflow.
- Prevent an emergency UI update during an incident.
- Standardise deployment across an estate.
- Explain the policy in the admin interface.
- Keep staging and production codebases identical.
- Stop a contractor installing modules ad hoc.
- Avoid post-deploy surprises about missing modules.
