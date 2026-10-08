<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Custom Status Report lets administrators choose which cards show in the General System Information section of Drupal's core Status Report page (/admin/reports/status), reorder them, and surface status cards contributed by other modules.

---

Custom Status Report alters the core Status Report page's "General System Information" section. Through a settings form at /admin/config/system/custom-status-report (permission `administer site configuration`) an admin toggles the visibility of each default card (Drupal version, web server, last cron run, PHP, database) and drags to set its weight/order. Any module that implements `hook_requirements_alter()` and marks a requirement with `add_to_general_info => TRUE` (optionally with a `module_icon`) appears as an additional card that can also be shown, hidden, and ordered. The module works by overriding core's `status_report_page` render element pre-render callback and swapping the `status_report_general_info` theme template so the section renders the configured, weighted set of cards. It requires no modules outside core and works with Claro, Seven, and Gin admin themes.

---

- Hide the Drupal version card from the General System Information section.
- Hide the web server card from the status report.
- Hide the last-cron-run card from the status report.
- Hide the PHP information card (version and memory limit).
- Hide the database information card (system and version).
- Show only the cards a given team actually cares about.
- Reduce noise on the status report for operators.
- Reorder the default cards by dragging their weight handles.
- Put the most important card first in the General System Information grid.
- Surface a custom status card contributed by your own module.
- Aggregate statuses from several modules into one General System Information view.
- Give a custom card its own icon via the `module_icon` requirement key.
- Fall back to the Drupal logo icon when a custom card omits `module_icon`.
- Curate which module-provided cards appear alongside the core cards.
- Tailor the status report per environment (dev, staging, production).
- Keep a compact status overview for a client-facing admin.
- Save card visibility and weight as exportable configuration.
- Restore defaults by re-toggling cards and saving the form.
- Cancel pending changes on the settings form without saving.
- Confirm the module is installed via its own OK requirement entry.
- Jump from the settings form to the live Status Report page.
- Style the customized cards through the module's CSS grid overrides.
- Support Drupal 9, 10, and 11 sites.
- Operate entirely within the admin area with no front-end footprint.
