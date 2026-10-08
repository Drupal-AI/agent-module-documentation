<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Contacts (contacts) — agent index

**CRM dashboard over decoupled users + profiles: tabbed individual/organisation management backed by Search API.**

- **Version:** 3.4.x  **Core:** ^10.2 || ^11  (package: Contacts)
- **Key deps:** crm_tools, decoupled_auth(+_crm), profile, name, ctools(+_views), search_api_db, facets, address, layout_discovery, toolbar
- **Submodules:** crm_tools, contacts_user_dashboard, contacts_log, contacts_group, contacts_dbs, contacts_mapping
- **Dashboard routes:** `contacts.collection` `/admin/contacts`; `contacts.contact` `/admin/contacts/{user}/{subpage}`; add forms `/admin/contacts/add/{indiv,org}`; many `contacts.ajax.*` manage-mode routes; config `contacts.basic_config` `/admin/config/contacts`.
- **Permissions:** `view contacts`, `add contacts`, `manage contacts dashboard`, `administer contacts` (restrict access); config routes use core `administer blocks` / `administer account settings`.
- **Core services:** `contacts.dashboard`, `contacts.tab_manager`, `contacts.indexer`, theme negotiator, access-denied subscriber, `contacts` stream wrapper.
- **Security:** every route in `contacts.routing.yml` is permission-gated — no `_access: 'TRUE'`, no anonymous contact-data endpoints. `view contacts` is CRM-wide (any contact), by design, not per-record; front-end user dashboard uses `_entity_access: user.dashboard` + login required. Some back-office queries use `accessCheck(FALSE)` for aggregation (fine server-side, not exposed anonymously).

See [configure/dashboard.md](configure/dashboard.md).
