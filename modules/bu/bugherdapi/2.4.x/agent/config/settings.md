<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# BugHerd settings, sidebar injection, routes & permissions

## Install / enable

`drush en bugherdapi`. No dependencies beyond Drupal core (`^11 || ^12`). After enabling, go to
`/admin/config/system/bugherd` and enter your BugHerd **project key**; the sidebar does nothing until
a project key is set.

## Config object & schema

Config object **`bugherdapi.settings`** (`config/schema/bugherdapi.schema.yml`, type
`config_object`):

| Key | Type | Meaning |
| --- | --- | --- |
| `project_key` | string | BugHerd **project** key — public per-project embed key, sent to the browser to load the sidebar. Required for the sidebar. |
| `api_key` | string | BugHerd **personal API key** — secret, full-organization REST credential. Only used server-side by `bugherdapi.client`. Optional. |
| `disable_on_admin` | boolean | When TRUE, the sidebar is not loaded on admin routes. |

No `config/install/` ships, so the object starts empty.

## Settings form — `Form\BugherdConfigurationForm`

`ConfigFormBase`, form id `bugherdapi_configuration_form`, edits `bugherdapi.settings`. Injected
with `config.factory` and `bugherdapi.client`. Fields:

- `project_key` — textfield, **required**.
- `disable_on_admin` — checkbox.
- `api` details group (open when an `api_key` is already stored) → `api_key` textfield (the secret
  REST key) plus a help item showing the `settings.php` snippet.

**API-key override awareness.** `isApiKeyOverridden()` compares the stored value to the effective
`config.factory` value; when they differ (a `settings.php` `$config['bugherdapi.settings']['api_key']`
override is in force) the field is disabled and labelled as overridden, and `submitForm()` leaves the
stored key untouched so removing the override later does not resurrect a stale key.

**Validation** (`validateForm()`): if a non-empty `api_key` changed and is not overridden, it calls
`$this->client->verifyApiKey($api_key)`. Success → status message with the BugHerd organization name.
`BugherdApiException` with `isAuthenticationError()` (401/403) → form error; any other error → a
warning only (the save still proceeds, so a BugHerd outage doesn't block configuration).

## Routes, menu & permissions

- Route **`bugherdapi.bugherd_configuration_form`** — path `/admin/config/system/bugherd`,
  `_form: \Drupal\bugherdapi\Form\BugherdConfigurationForm`, requirement
  **`_permission: 'administer bugherd'`**, `options._admin_route: TRUE`. Also the module's
  `configure` link.
- Menu link `bugherdapi.bugherd_configuration_form` (`bugherdapi.links.menu.yml`) under
  `system.admin_config_system`, weight 99.
- Permissions (`bugherdapi.permissions.yml`):
  - **`administer bugherd`** — `restrict access: TRUE`; gates the settings form.
  - **`access bugherd`** — controls who gets the on-page reporting sidebar (see below).

## Sidebar injection path

`Hook\BugherdApiHooks::pageAttachments()` (attribute `#[Hook('page_attachments')]`) calls
`BugherdApiManager::pageApplies()`; when TRUE it attaches:

```
$attachments['#attached']['drupalSettings']['bugherdapi'] = ['api_key' => <project_key>];
$attachments['#attached']['library'][] = 'bugherdapi/bugherdapi';
```

Note the `drupalSettings` key is literally named `api_key` but is populated from
`config->get('project_key')` (see `BugherdApiManager::getJsSettings()`) — i.e. the **public project
key**, never the secret personal API key.

`BugherdApiManager::pageApplies()` returns TRUE only when **all** hold:

1. `project_key` is non-empty. (If empty and the user has `administer bugherd`, a warning message
   links to the settings form.)
2. The current user has the **`access bugherd`** permission.
3. Not `(disable_on_admin && current route is an admin route)` — uses `AdminContext::isAdminRoute()`
   on the current route object.

Library `bugherdapi/bugherdapi` (`bugherdapi.libraries.yml`) loads `js/bugherdapi.js` with deps
`core/jquery`, `core/drupal`, `core/drupalSettings`. On DOM-ready the script reads
`drupalSettings.bugherdapi.api_key` and injects a `<script src="//www.bugherd.com/sidebarv2.js?apikey=<key>">`
element — this is BugHerd's own hosted sidebar loader.
