<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
PHP Filter re-adds the "PHP code" text-format filter that Drupal core removed: it lets text using an enabled format have its embedded PHP evaluated when rendered.

---

The module provides a filter plugin whose process callback runs `php_eval()` (`php.module`), a thin wrapper around PHP `eval()` that output-buffers and requires the code be wrapped in `<?php ?>` tags. When a text format has the "PHP evaluator" filter enabled, any content using that format — node bodies, comments, block bodies, etc. — has its PHP executed in the Drupal process on render. This is dangerous **by design**: it grants arbitrary code execution to whoever can author content in a PHP-enabled format, which is exactly why Drupal core dropped PHP Filter. Access is gated by the single, `restrict access` permission `use PHP for settings`; the module also attaches `js/php.admin.js` to the block admin UI via `hook_library_info_alter()`.

Treat this as an administrative/trusted-user power tool only. Grant `use PHP for settings` to no one but fully trusted site builders, never enable the PHP filter on a format available to untrusted roles, and audit every PHP snippet before it goes live. The documented `eval()`/`php_eval()` behaviour is the module's intended purpose, not a bug — but it is the single highest-risk capability you can add to a site, so its use should be minimised or avoided in favour of custom modules/hooks.

---

- Re-enable embedded PHP execution removed from Drupal 8+ core
- Evaluate a PHP snippet inside a node body
- Compute dynamic block content with PHP
- Run PHP in a comment (only for trusted formats)
- Restrict PHP execution to a dedicated, admin-only text format
- Grant `use PHP for settings` to a single trusted site builder
- Migrate legacy Drupal 7 PHP-filter content during an upgrade
- Prototype dynamic markup before moving it into a real module
- Wrap snippets in `<?php ?>` tags for evaluation
- Audit and lock down where the PHP filter is enabled
- Disable/uninstall to eliminate the code-execution surface
- Keep PHP-enabled formats off any public/authenticated-user role
- Order the PHP filter to run last in a text format
- Output-buffer printed and returned PHP output via `php_eval()`
- Build one-off dynamic admin pages during site building
- Reproduce a legacy Drupal 7 PHP snippet after migration
- Gate PHP execution behind the restricted `use PHP for settings` permission
- Review stored snippets before every publish (they re-run on render)
