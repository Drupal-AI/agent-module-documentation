<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
SULA Eligibility Calculator creates a configurable block that displays a simple AJAX-based calculator for estimating SULA (Subsidized Usage Limit Applies) student-loan eligibility.

---

The module ships two block plugins (a credit-based and a clock/time-based calculator) each backed by an embedded form (`SulaCalculatorBlockFormCredit`, `SulaCalculatorBlockFormClock`) that computes results via AJAX without a page reload. A settings form at `/admin/config/system/sula_calculator` (permission `administer sula calculator`) lets administrators tune the calculator. Styling is Bootstrap-5 friendly for responsiveness.

Operationally it is a front-end display block; the only privileged surface is the admin settings route, gated by a dedicated permission. There are no external API calls or mutating public endpoints.
---
- Place the SULA credit calculator block in a region
- Place the SULA clock/time calculator block
- Configure calculator parameters at /admin/config/system/sula_calculator
- Let visitors estimate SULA eligibility interactively (AJAX)
- Grant editors the "administer sula calculator" permission
- Embed the calculator on a landing page via block layout
- Use with a Bootstrap 5 theme for responsive layout
- Restrict block visibility per path/role via block config
- Provide a self-service eligibility tool for students
- Recompute results without reloading the page
- Show credit-usage based results
- Show clock/time based results
- Customize labels/values through the settings form
- Add the calculator to multiple pages via block placement
- Offer an informational tool alongside enrollment content
