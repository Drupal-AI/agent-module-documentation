<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Accessibility Statement (accessibility_statement) — agent index

**Generates a config-driven, legally structured accessibility statement page** per EU Directive 2016/2102 (public sector) and the European Accessibility Act 2019/882 / BFSG (products & services).

- **Version:** 1.0.x
- **Core:** `^10.3 || ^11`  · package Accessibility · no external dependencies
- **Routes:** `accessibility_statement.page` (`/accessibility-statement`, `_access: 'TRUE'`, read-only public page); `accessibility_statement.settings` (`/admin/config/system/accessibility-statement`, `_form`).
- **Permission:** `administer accessibility statement` (restricted).
- **Services:** `RouteSubscriber` (rewrites the public path from config); `AccessibilityStatementHooks`.
- **Config:** `accessibility_statement.settings`. Footer menu link added on install.

**Security:** admin config route is permission-gated (`administer accessibility statement`, restricted); the public page is intentionally `_access: 'TRUE'` but renders config-only semantic HTML with no stored/reflected request input and no mutating endpoints. No security findings.

See [configure/statement.md](configure/statement.md)
