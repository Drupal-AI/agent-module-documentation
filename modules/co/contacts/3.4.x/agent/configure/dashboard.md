<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Operate the Contacts CRM

## Enable
Requires the CRM dependency stack (decoupled_auth + decoupled_auth_crm, profile, name, ctools/_views, search_api_db, facets, address, layout_discovery, toolbar) and the bundled `crm_tools`. `drush en contacts -y` pulls them in; the optional config installs CRM roles (`crm_indiv`, `crm_org`, `crm_manager`), profile types and the `contacts_index` Search API index.

## Permissions (contacts.permissions.yml)
- `view contacts` — see the dashboard and any contact (CRM-wide, not per-record).
- `add contacts` — use the add individual/organisation forms.
- `manage contacts dashboard` — enter manage mode; rearrange tabs/blocks.
- `administer contacts` — configure; `restrict access: TRUE`.
Config routes reuse core `administer blocks` and `administer account settings`.

## Key routes
- `/admin/contacts` → dashboard (redirects to configured default: indiv/org/all).
- `/admin/contacts/{user}/{subpage}` → a contact's tabbed detail (perm `view contacts`, `user: \d+`).
- `/admin/contacts/add/indiv` and `/add/org` (perm `add contacts`).
- `contacts.ajax.*` (manage-mode / off-canvas) — perm `manage contacts dashboard` or `administer blocks`.
- `/admin/config/contacts` — basic config form (perm `administer account settings`).

## Tabs & blocks
Dashboard tabs are `contact_tab` config entities (`ContactTabListBuilder`, `ContactsTabManager`). In manage mode, blocks are added/moved via off-canvas AJAX; layout is stored per tab. Summary/duplicates/back-link are dashboard blocks.

## Submodules
- `crm_tools` — advanced role storage + unified login/register (overrides `user.login`/`user.register` controllers when visitor registration is on).
- `contacts_user_dashboard` — front-end `/user/{user}/summary` (`_entity_access: user.dashboard`, login required) + `access user dashboards` perm.
- `contacts_log` — logs profile/user changes as Message entities.
- `contacts_group`, `contacts_dbs`, `contacts_mapping` — Group relations, DBS status workflow, geolocation maps.

## Search index
Listing/facets/duplicates use the `contacts_index` Search API DB index; re-index with `drush search-api:index contacts_index`.
