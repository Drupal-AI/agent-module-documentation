<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Ignition Error Handler swaps Drupal's error page for spatie/ignition — the error screen with a readable stack trace, source excerpts, request context and, distinctively, suggested solutions for the error in front of you.

---

Install with Composer (`composer require drupal/ignition`, which also pulls `spatie/ignition` and `openai-php/client`), enable the module, and clear cache. Because this is a **development tool** — its whole job is to display source code, stack traces and request context — the module's README says not to enable it on a production site. It renders **only** when four conditions all hold: the module setting **Enabled** is on (form at `/admin/config/development/ignition`), Drupal's error display is set to **All messages, with backtrace information** at `/admin/config/development/logging`, the current user holds the **`view ignition error page`** permission, and the error is displayable; otherwise Drupal's normal error handling runs. The distinctive feature is **solution providers**: the module ships Drupal-aware ones — `EntityQueryAccessCheckSolutionProvider` (an entity query missing `accessCheck()`), `PermissionsMustExistSolutionProvider` (a role referencing a non-existent permission), `MysqlReadCommittedSolutionProvider` (a MySQL isolation-level deadlock) — that recognise common mistakes and tell you what to do, plus an optional `OpenAISolutionProvider` that asks a model when you supply an API key. You can add your own by implementing `HasSolutionsForThrowable` and tagging the service `ignition_solution_provider`. Display preferences (colour theme, code editor) are set from the cog icon on the error page and remembered per user, per session, or in a shared `~/.ignition.json` file depending on the **Store settings in ~/.ignition.json** option. On production, keep the error display set to **None** (a `settings.php` guard such as `if (SITE_IS_PROD) { $config['system.logging']['error_level'] = 'hide'; }` enforces it).

---

- Read a stack trace that is actually readable.
- See the failing line with the surrounding source.
- Inspect request context and environment while debugging.
- Get a suggested fix for a common Drupal error.
- Recognise an entity query missing an access check.
- Recognise a role permission that does not exist.
- Diagnose a MySQL isolation-level deadlock.
- Ask a model (OpenAI) to explain an unfamiliar error.
- Write a custom solution provider for your own exceptions.
- Register that provider with the `ignition_solution_provider` tag.
- Turn Ignition on or off from the settings form.
- Enable dark mode for the error page.
- Set the required verbose error/log level for a dev site.
- Fall back to Drupal's handler outside verbose mode.
- Restrict error pages to developers via the permission.
- Keep the module and verbose errors out of production.
- Force production error display to None in settings.php.
- Configure Ignition display preferences from the cog menu.
- Store preferences per user rather than in a shared file.
- Share the same Ignition look across projects via ~/.ignition.json.
- Speed up debugging on a local site.
- Cache OpenAI solutions in a dedicated cache bin.
