<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Search API Tracking (search_api_tracking) — agent index

Records **Search API queries to the database** for search analytics. Version **dev**.
Core `^9 || ^10 || ^11`. Depends on Search API.

**Privacy:** search queries can be sensitive (health, names, private topics). Restrict who reads the
log, set a **retention limit**, consider whether queries are stored against identifiable users, and
keep the table out of casual DB sharing.