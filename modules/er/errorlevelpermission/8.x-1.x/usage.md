<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Error Level Permission decides Drupal's on-screen PHP error-display level per user, from permission instead of one site-wide switch.

---

Core has a single "Error messages to display" setting (`system.logging:error_level`) that applies to everyone. Error Level Permission replaces that single value with a per-user decision: it registers a configuration override that, each time `system.logging` is read, returns an `error_level` chosen from the current user's permissions. Three permissions map to core's three visible levels — errors+warnings, +notices, and +notices with backtrace — and a user with none of them gets errors hidden entirely. Because the override is keyed on `user.permissions`, one page can show a full backtrace to a developer and nothing to an anonymous visitor at the same time. The module ships only this override plus a permissions definition and a small form tweak that points the core logging form at the permissions page; there is no settings form of its own.

Use it so trusted developers, site builders or a dedicated debugger role keep seeing on-screen errors while everyone else does not, independent of the site-wide setting. It is a natural complement to keeping production error display low: even if the core setting is raised, only permitted users see the extra detail. Grant the permissions only to roles you trust with error detail (paths, SQL fragments, stack traces).

---

- Show PHP errors and warnings on screen only to a chosen role.
- Also reveal notices to a role, on top of errors and warnings.
- Reveal full backtrace/verbose error output to a debugger role.
- Hide all on-screen errors from anonymous visitors.
- Hide all on-screen errors from ordinary authenticated users.
- Let a developer see backtraces while other visitors see nothing, on the same page.
- Give a dedicated "debugger" role verbose errors without changing the site-wide setting.
- Keep production error display hidden globally but visible to admins.
- Let site builders debug a live page without exposing errors to end users.
- Override `system.logging:error_level` dynamically per request.
- Base error verbosity on the current user's permissions.
- Assign error visibility through People → Permissions like any other permission.
- Combine with role assignment to scope who can debug.
- Complement a locked-down production logging configuration.
- Reduce accidental disclosure of paths, SQL and stack traces to visitors.
- Debug a staging site where multiple roles need different error visibility.
- Grant a support engineer temporary verbose errors via a role.
- Redirect the core "Error messages to display" form control to the permission page.
- Avoid editing settings.php or the logging form to toggle error display for a person.
- Keep verbose errors off for editors while on for developers.
- Show errors to authenticated developers but hide them from the public.
- Provide three graduated error-visibility levels selectable per role.
- Run the module with no configuration beyond assigning permissions.
- Cache-correctly vary error display by user permissions.
