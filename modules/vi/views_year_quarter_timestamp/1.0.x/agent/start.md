<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Views Year-Quarter Timestamp (views_year_quarter_timestamp) — agent index

**Views Global field (+ sort) converting year + quarter taxonomy values into a millisecond timestamp.**

- **Version:** 1.0.x (dev checkout, branch `1.0.x`; no version in info.yml)
- **Core:** ^9 || ^10 || ^11  ·  **Depends:** `drupal:views`
- **Views data:** field `field_views_year_quarter_timestamp` (Global), sort `views_year_quarter_timestamp_sort`.
- **Field plugin:** `Plugin\views\field\YearQuarterTimestamp` — options "Year Provider" / "Quarter Provider"; loads taxonomy terms, maps Q1–Q4 → month 01/04/07/10, returns `timestamp * 1000`.
- **Sort plugin:** `Plugin\views\sort\YearQuarterTimestamp` — `SortPluginBase` stub, empty `query()`.
- **No** routes, permissions, or admin UI outside the Views UI.

**Security:** No server endpoints; admin-only Views configuration. Reads taxonomy term names and does date math only — no untrusted sinks.
