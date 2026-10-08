<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Symfony Debug replaces Drupal's default error handler with the Symfony debug error handler, giving richer error pages and diagnostics during development.

---

Debugging errors is easier with Symfony's detailed error pages (full stack traces, context) than Drupal's default. Symfony Debug swaps in the Symfony debug handler. This is a DEVELOPMENT tool, and the security consideration is significant: the Symfony debug error page displays detailed diagnostics — full stack traces, file paths, code excerpts, and request/environment context — which is exactly the information disclosure a production site must NOT expose to users. Detailed error pages on production hand an attacker a map of the code, file layout, and sometimes configuration or data in the trace. So this belongs strictly in development/staging environments and must never be enabled in production. Confirm it is not enabled in production, and pair it with Drupal's production error-display setting (errors hidden from users) as a defence in depth. It is a developer convenience; on production it is an information-disclosure hole.

---

- Get detailed error pages.
- Use the Symfony debug handler.
- Debug errors in development.
- See full stack traces.
- Diagnose errors richly.
- Keep it out of production.
- Never expose debug pages to users.
- Avoid production info disclosure.
- Use in development/staging only.
- Pair with hidden production errors.
- Confirm it's disabled in production.
- Improve dev diagnostics.
- Enable when needed.
- Keep disabled otherwise.
- Restrict administration.
- Confirm on your site.
- Test before production.
- Review configuration.
- Pair with related modules.
- Verify theme fit.
- Match your use case.
- Confirm compatibility.