<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Context Active Inspector adds an admin toolbar tray that lists the Context-module contexts active on the current page.

---

Context Active Inspector is a small developer/debugging aid for the [Context](https://www.drupal.org/project/context) module. It hooks into the core Toolbar (`hook_toolbar`) to add an "Active context" item whose tray lists every context returned by `context.manager`'s `getActiveContexts()` for the request being viewed — i.e. the contexts whose conditions currently match. Each listed context links to its edit form when the `context_ui` module is enabled, so you can jump straight from "what is firing here" to "where it is configured". The whole toolbar item is rendered only for users holding the `access context active inspector` permission and is cached per `user.permissions`; the module has no routes, no configuration form, and no config objects. It ships CSS for the toolbar icon (including Gin/Gin Toolbar theme fixes) and declares a `context_active_inspector_commands` hook group via `hook_hook_info`.

---

- See at a glance which Context contexts are active on the page you are viewing.
- Debug why a context does or does not fire on a given route.
- Jump from an active context in the toolbar to its Context UI edit form.
- Confirm that a newly added context's conditions match where you expect.
- Diagnose overlapping or conflicting contexts affecting the same page.
- Verify a context's reactions are being applied by confirming it is active.
- Inspect active contexts on the front end while logged in as an admin.
- Give developers a fast feedback loop while authoring context conditions.
- Restrict inspector visibility to trusted roles via the module permission.
- Show an explicit "No contexts" entry when nothing is active on the page.
- Confirm anonymous-vs-authenticated context differences by switching users.
- Check contexts across different content types and paths during QA.
- Support Drupal 9, 10, and 11 sites that use the Context module.
- Work with the Gin admin theme and Gin Toolbar via bundled CSS fixes.
- Avoid enabling verbose logging just to trace context evaluation.
- Complement Context UI by surfacing runtime state, not just configuration.
- Let site builders self-serve context troubleshooting without a debugger.
- Keep the inspector out of anonymous users' view via permission gating.
- Provide an extension point (`context_active_inspector_commands` hook group).
- Audit which contexts run on admin pages versus public pages.
