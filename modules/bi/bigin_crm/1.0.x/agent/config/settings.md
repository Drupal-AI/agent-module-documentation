<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configuration, routes & the user-insert sync

## Install / enable

`drush en bigin_crm`. `hook_schema()` (`bigin_crm.install`) creates the `bigin_crm_token` table
(serial `id`, varchar(100) `access_token`, varchar(100) `refresh_token`, int `created`). Config
defaults are installed from `config/install/bigin_crm.settings.yml`. **No config/schema is
shipped**, so the config object is schema-less (no strict typing / no config-inspector coverage).

## Permission & routes

One permission `administer crm integration` (`restrict access: true`). All four routes require it:

- `bigin_crm.admin_settings_form` — `/admin/config/bigin/settings` (menu link *Bigin* under
  Configuration → Services; local task *Authorization*) → `BiginController::initialize()` renders
  the `form_settings` theme with the `GetTokenForm`, the Zoho authorize link, and a revoke link.
- `bigin_crm.pipelines_settings` — `/admin/config/bigin/settings/pipelines` (local task *Bigin
  Settings*) → `SettingsPipelinesForm`.
- `bigin_crm.callback` — `/auth/bigin/callback` — OAuth redirect target (see api/oauth.md).
- `bigin_crm.revoke` — `/auth/bigin/revoke_token` — deletes the stored token.

## Config object `bigin_crm.settings`

Written by two `ConfigFormBase` forms (both edit `bigin_crm.settings`):

`GetTokenForm` (`bigin_admin_settings`):
- `client_id`, `client_secret` — Zoho API-console credentials (textfields).
- `domain` — select `com|eu|cn|in` (default `com`), selects the Zoho data center.
- `authorized_redirect_url` — disabled/read-only display of the callback URL to paste into Zoho.
- `roles` — checkboxes of all `user_role` entities; only these roles trigger a sync
  (`array_filter`ed on save).

`SettingsPipelinesForm` (`bigin_settings`) — populated from live Bigin API lookups
(`get_layouts()`, `get_users()`):
- `layout` (select of Bigin deal layouts) + `layout_name` (label stored on save), `sub_pipeline`,
  `stage`, `closing_date` (relative string e.g. `+5 days`), `deal_owner` (select of Bigin users),
  `deal_name`, `deal_description` (optional).

Install defaults: `domain: com`, `closing_date: '+5 days'`, everything else empty.

## The sync (`hook_user_insert`)

`bigin_crm_user_insert(UserInterface $user)` (`bigin_crm.module`):
1. Reads configured `roles`; builds `['name' => displayName, 'email' => email, 'roles' => csv]`.
2. `array_intersect($roles_config, $user->getRoles())` — if the new user has at least one selected
   role, calls `bigin_crm.contacts_service->create($data)`.

`BiginContactsService::create()`:
- POSTs to `{url_api}/bigin/v1/Contacts` a data record `Last_Name = name`, `First_Name = ''`,
  `Email = email`, `Owner.id = deal_owner`.
- On `data[0].code == 'SUCCESS'`, calls `BiginPipelinesService::create_deal(contactId, name, roles)`.

`BiginPipelinesService::create_deal()`:
- POSTs to `{url_api}/bigin/v1/Deals` a record from config: `Deal_Name`, `Stage`, `Layout`
  (name+id), `Contact_Name` (name+id), `Closing_Date` (`date('Y-m-d', strtotime(closing_date))`),
  `Pipeline = sub_pipeline`, `Owner.id = deal_owner`, `Description = deal_description`.

## Operate it

1. Register a client at `https://api-console.zoho.com/`, set the Authorized Redirect URI to the
   value shown in `authorized_redirect_url`.
2. On the settings page enter Client ID/Secret + domain + roles, save.
3. Click the authorize button, consent at Zoho → tokens stored (see api/oauth.md).
4. On the *Bigin Settings* tab pick the pipeline/layout/stage/owner/deal fields (the selects only
   populate once a valid token exists, since they call the Bigin API).
5. New users matching the selected roles are now pushed as contact+deal. Use the revoke link to
   disconnect.
