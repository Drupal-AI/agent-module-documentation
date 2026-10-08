<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Content Moderation Bypass adds a dynamically generated permission, one per Content Moderation workflow, that lets its holder move content to any moderation state regardless of the transitions the workflow defines.

---

Core Content Moderation enforces a state machine: from Draft you may go to Review, from Review to Published, and each move is its own `use <workflow> transition <transition>` permission. That rigidity is the point — it is what makes a moderation workflow mean something — but it gets in the way of exactly the people who should be trusted around it: an administrator fixing a stuck item, a migration that needs to land content directly in Published, a maintenance script correcting a bad state. This module provides the escape hatch as a first-class permission: for each workflow it generates `bypass {workflow} transition restrictions`, and a holder can set content to any state in that workflow directly. There is nothing to configure — no settings page, no routes, no blocks — you simply enable the module (`drush en content_moderation_bypass`), rebuild caches, and grant the permission on **People → Permissions** to the roles that should have it. It is enforced server-side when the entity is saved, not merely hidden in the UI, and it is powerful, so treat it accordingly: it does **not** bypass edit *access* (you still need permission to edit the content) but it does bypass the workflow's integrity, which is usually the whole reason the workflow exists. Grant it to a narrow administrative role, per workflow rather than site-wide where the design allows, never to general editors, and audit who holds it.

---

- Move a moderated entity to any state in its workflow.
- Fix a moderation item stuck in an unreachable state.
- Land migrated content directly in Published.
- Correct a bad or wrong moderation state administratively.
- Override the transition graph for trusted administrators.
- Avoid having to grant every individual transition permission.
- Get a first-class bypass permission generated per workflow.
- Grant the override to a single narrow admin role.
- Keep the bypass off general editors and authenticated users.
- Separate transition-override power from other admin power.
- Set a state without following the workflow's allowed moves.
- Support a maintenance or data-migration script that sets states.
- Handle an exceptional, one-off editorial action.
- Restrict the bypass per workflow (e.g. editorial but not another).
- Audit which roles hold the bypass permission.
- Keep the workflow strict for everyone else on the site.
- Publish content directly when policy allows it.
- Reset published content back to Draft administratively.
- Remember it grants state freedom, not edit access.
- Treat the permission as high-privilege and grant it deliberately.
