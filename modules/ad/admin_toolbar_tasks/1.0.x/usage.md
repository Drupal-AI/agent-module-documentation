<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Admin Toolbar Tasks moves administrative local tasks — the View / Edit / Revisions / Translate style tabs — off the content area and into a dropdown on the site toolbar.

---

Local tasks are Drupal's contextual actions (view, edit, revisions, translate, devel) that normally render as tabs near the top of the content area. That works on an admin theme but often badly on a front-end theme, where the tabs collide with the design or get suppressed and become unreachable. This module relocates the tabs that point at admin routes into the toolbar instead, which is already the administrative surface, is consistent across themes, and does not have to be designed around.

It hooks `hook_menu_local_tasks_alter()` to detect admin-route tabs on non-admin pages, hides them from the normal tab block (setting their access to forbidden there) while preserving their original access result, and re-renders the allowed ones through a lazy-built toolbar item (`AdminToolbarTasksBuilder`). The relocation only happens when the user has the core `access toolbar` permission and the current page is not already using the admin theme, so admin pages keep their normal tabs. There is nothing to configure — enable it and it works; it depends only on core Toolbar and pairs naturally with the Admin Toolbar module.

**Two things to check on a real site.** The toolbar is not infinitely wide, and a content type with translation, moderation, revisions, devel and a few contrib tabs produces more local tasks than fit — check what happens at that point rather than on a stock install (the template shows a `⋮` dropdown once there is more than one task). And local tasks stay access-filtered per route, so what appears in the toolbar varies by user; that is correct, and it means testing with an editor account rather than as user 1, which sees everything and therefore tests nothing.

---

- Move a node's Edit and Revisions tabs into the toolbar on a front-end theme.
- Stop local-task tabs colliding with a custom front-end theme's layout.
- Keep local tasks reachable on a theme that suppresses region tabs.
- Give editors one consistent administrative surface across themes.
- Avoid having to style the tabs block in every front-end theme.
- Help editors who work primarily in the front-end theme find edit actions.
- Surface Translate tabs in the toolbar for multilingual editors.
- Combine with the Admin Toolbar module for a fuller admin toolbar.
- Rely on core Toolbar only — no extra configuration to maintain.
- Preserve per-route access filtering so tasks show only to permitted users.
- Gate the whole feature behind the core `access toolbar` permission.
- Leave admin-theme pages untouched so their normal tabs still render.
- Provide a pure-CSS `⋮` dropdown when a page has more than one admin task.
- Audit which local tasks a given content type or entity exposes.
- Test toolbar overflow with translation, moderation, revisions and devel enabled.
- Verify the dropdown behaviour when many contrib modules add tabs.
- Test as an editor account rather than as user 1 to confirm filtering.
- Reduce time editors spend hunting for the Edit tab.
- Override the `links--admin-toolbar-tasks` template to restyle the dropdown.
- Extend or replace the module CSS via your theme's libraries.
- Document the module's relocation behaviour for a site's editorial team.
- Review its behaviour during a front-end editing UX audit.
- Re-verify toolbar behaviour after a Drupal core minor upgrade.
- Confirm nothing appears in the toolbar for anonymous users without toolbar access.
