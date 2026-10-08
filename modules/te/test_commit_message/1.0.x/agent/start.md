<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Test Commit Message (test_commit_message) — agent index
**Testing fixture: intentionally calls deprecated Drupal 10/11 APIs so drupal-rector can generate patches against it.**

- **Version:** 1.0.x (1.0.0-alpha1)
- **Core:** ^10 || ^11
- **Depends on:** filter, system
- **Purpose:** rector `project_analysis` + project-update bot testing; no site functionality.
- **Deprecated APIs used:** `REQUEST_TIME`, `watchdog_exception()`, `check_markup()`, `filter_formats()`/`filter_fallback_format()`, `system_region_list()`/`system_default_region()`.

**Security:** testing/CI fixture only — no routes, permissions, or user-facing features. Do not enable on production (contains deliberately deprecated code).
