<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Contacts is a CRM toolkit for Drupal that manages people and organisations as decoupled users plus profiles, presenting them through a configurable, tabbed *Contacts dashboard* backed by Search API.

---

Contacts belong to CRM roles (`crm_indiv`, `crm_org`, `crm_manager`) and are described by profile bundles (individual, organisation, notes). The dashboard at `/admin/contacts` (and `/admin/contacts/{user}/{subpage}`) is assembled from `contact_tab` config entities and layout blocks; tabs and blocks can be rearranged in a manage mode via a set of AJAX routes. A Search API DB index (`contacts_index`) with facets powers listing, filtering and duplicate detection. Submodules extend it: `crm_tools` (advanced roles + unified login/register), `contacts_user_dashboard` (a front-end `/user/{user}/summary` account dashboard), `contacts_log` (activity logging via Message), `contacts_group` (Group integration), `contacts_dbs` (DBS status workflow) and `contacts_mapping` (geolocation maps).

Access is permission-gated throughout: `view contacts`, `add contacts`, `manage contacts dashboard`, plus core `administer blocks` / `administer account settings` on the config routes; `administer contacts` is marked `restrict access: TRUE`. Every dashboard, AJAX and add-contact route in `contacts.routing.yml` carries one of these permissions — there are no `_access: 'TRUE'` routes and no anonymous contact-data endpoints. Note the `view contacts` permission is CRM-wide (a holder can view any contact, by design for a CRM), not per-record; the front-end `contacts_user_dashboard.summary` route instead uses `_user_is_logged_in` + `_entity_access: user.dashboard`. A few internal admin/index queries use `accessCheck(FALSE)` (e.g. `contacts_dbs`), which is appropriate for back-office aggregation but should not be exposed on public routes.

---
- Install the CRM stack (decoupled_auth, profile, search_api, facets, address…) and enable Contacts.
- Grant `view contacts` / `add contacts` / `manage contacts dashboard` to CRM roles.
- Browse the contacts dashboard at `/admin/contacts`.
- View the individuals-only or organisations-only dashboards.
- Open a single contact at `/admin/contacts/{user}/{subpage}`.
- Add a new individual contact (`/admin/contacts/add/indiv`).
- Add a new organisation contact (`/admin/contacts/add/org`).
- Rearrange dashboard tabs and blocks in manage mode.
- Add or configure a `contact_tab` config entity.
- Add dashboard blocks to a tab via the off-canvas chooser.
- Configure basic contacts settings at `/admin/config/contacts`.
- Search and facet contacts through the Search API index.
- Detect and merge duplicate contacts from the duplicates block.
- Convert a plain user into an individual or organisation.
- Enable `contacts_user_dashboard` for a front-end `/user/{user}/summary`.
- Enable `crm_tools` for advanced roles and a unified login/register page.
- Enable `contacts_log` to record profile/user changes as Messages.
- Enable `contacts_group` to relate contacts to Groups.
- Enable `contacts_dbs` for DBS status tracking workflow.
- Enable `contacts_mapping` to show contacts on a geolocation map.
- Re-index contacts with `drush search-api:index`.
