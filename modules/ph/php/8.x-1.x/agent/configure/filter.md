<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# php — enabling and locking down the PHP filter

**This feature executes arbitrary PHP.** Enable it only if you fully understand the risk.

Setup:
1. `drush en php`.
2. Go to `/admin/config/content/formats` (`filter.admin_overview`). Create a **new, dedicated** text format (do NOT add PHP to Basic/Full HTML) — e.g. "PHP code".
3. In that format, enable the **PHP evaluator** filter and set it to run **last** in the filter order.
4. On the format's *Roles* section, restrict it to trusted roles only (ideally just administrator).
5. Grant the `use PHP for settings` permission (`restrict access: true`) to the same small, trusted set.

Authoring: wrap code in `<?php ... ?>`. `php_eval()` output-buffers printed + returned output. Variables inside the snippet do not leak into the caller scope.

Hardening / removal:
- Never expose a PHP-enabled format to anonymous or general authenticated users — that is remote code execution.
- Audit every snippet before publishing; snippets are stored in content and re-run on every render.
- Prefer moving logic into a custom module (`hook_*`, a controller, a Twig extension) and then **uninstall** this module to remove the code-execution surface entirely.
