<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Whoops integrates the whoops PHP library to show rich, detailed PHP error pages — a development tool.

---

Whoops integrates the `whoops` PHP library, replacing Drupal's error output with whoops' rich,
detailed error pages — showing the exception, a full stack trace, code snippets and request context in a
developer-friendly format. It is a development aid that makes debugging PHP errors much faster. It is in
the Development package and tagged as a developer tool.

**Security caveat — this is strictly a development tool; never enable it on production.** Whoops' whole
purpose is to display full stack traces, source-code snippets, and request/environment context on error —
exactly the information that must **not** be exposed to visitors on a live site, because it reveals code
paths, file paths, configuration and potentially secrets, greatly aiding an attacker. Use it only on
local/development environments (and ensure Drupal's error display is off on production regardless). Treat
its presence in a production codebase as a misconfiguration to fix.

---

- Show rich PHP error pages.
- Integrate the whoops library.
- See full stack traces on error.
- View code snippets for exceptions.
- Debug PHP errors faster.
- Use on local/development only.
- Never enable on production.
- Know it exposes stack traces/paths.
- Avoid leaking code/config/secrets.
- Keep error display off on production.
- Treat production presence as a misconfiguration.
- Aid local debugging.
- Show request/environment context.
- Replace Drupal error output.
- Use as a developer tool.
- Speed up debugging.
- See exception detail.
- Improve error readability locally.
- Restrict to non-production.
- Remove before deploying.
