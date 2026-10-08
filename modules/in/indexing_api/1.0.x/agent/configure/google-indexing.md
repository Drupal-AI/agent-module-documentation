<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configure Google Indexing API

Route `indexing_api.index_settings_form` → `/admin/config/services/indexing-api` (route requires permission **`administer google index api`**; note the module only *declares* `configure indexing api`, so until a role is granted the `administer google index api` machine name, only user 1 can open the form).

**Prerequisites (Google side):** a Google Cloud project with the Indexing API enabled, a service account added as an owner of the property in Search Console, and its JSON key file.

**Settings (stored in State):**
- `i_hostname` — site host used to build notified URLs (defaults to the current scheme+host).
- `i_end_point` — default `https://indexing.googleapis.com/v3/urlNotifications:publish`.
- `i_scope` — default `https://www.googleapis.com/auth/indexing`.
- `i_json` — managed_file upload (extension `json`) saved to `private://indexing-api/`; made permanent with a file-usage record on submit. Requires the private file system to be configured.

**Assign entities:** in the "Indexing options" table, click **Select** on a supported entity type to open the modal (`indexing_api.assign_form`) and tick the bundles to index. Selections are stored in State key `i_entities` as `[entity_type_id => [bundle, …]]`. Supported = content entity type, not internal, has a canonical URL, and not in the unsupported list (`block_content`, `comment`, `shortcut`, `token_custom`).

**Runtime:** on insert/update/delete of an indexable entity, `IndexService::performRequest()` loads the key file, builds a `Google\Client`, authorizes, and POSTs `{type, url: hostname+alias}` to the endpoint; non-200 responses are logged to the `indexing_api` channel.
