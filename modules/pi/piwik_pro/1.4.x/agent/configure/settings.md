# Configure Piwik PRO

Form `/admin/config/services/piwik-pro` (route `piwik_pro.admin_settings_form`,
`Form\PiwikProAdminSettingsForm`, permission `administer piwik pro`). Config object
**`piwik_pro.settings`**.

## Core identifiers

| Key | Meaning |
|---|---|
| `site_id` | Piwik PRO **Account ID** for the container (public, embedded in the snippet) |
| `piwik_domain` | Piwik PRO **tracking domain** the container `.js` loads from (public) |
| `data_layer` | data-layer variable name (default `dataLayer`) |

The snippet is only emitted when `site_id`, `piwik_domain`, and `data_layer` are all non-empty
**and** the visibility checks pass. `site_id`/`piwik_domain` are client-side identifiers, not
secrets — do not treat them like API keys. (API credentials belong to the *dashboard* submodule.)

## Snippet / privacy toggles

| Key | Default | Effect |
|---|---|---|
| `disable_tracking` | false | master off switch (suppresses the snippet) |
| `use_secure_cookies` | false | adds `;secure` to tracker cookies and pushes `use_secure_cookies` |
| `same_site_strict` | false | adds `;SameSite=Strict` to tracker cookies |
| `piwik_pro_load_from_library` | false | load the snippet from a library variant |
| `csp_nonce_enabled` | false | emit a CSP nonce on the snippet (needs the CSP module) |

## Visibility (`visibility.*`)

Three independent, invertible checks — the snippet shows only if **all three** pass
(`PiwikProSnippet::isVisible()`):

| Group | Mode key | List key | Mode 0 | Mode 1 |
|---|---|---|---|---|
| Pages | `request_path_mode` | `request_path_pages` | every page **except** listed | **only** listed |
| Roles | `user_role_mode` | `user_roles[]` | every role except listed | only listed |
| Content types | `content_type_mode` | `content_types[]` | every type except listed | only listed |

Default `request_path_pages` excludes: `/admin`, `/admin/*`, `/batch`, `/node/add*`,
`/node/*/*`, `/user/*/*`. Path matching runs against the path alias (lowercased).

## CSP nonce

With `csp_nonce_enabled` true and the **CSP** module installed, `getSnippet()` pulls a nonce
placeholder from `csp.nonce_builder` and adds `nonce="…"` to the `<script>` (and to the
dynamically created tag). The `piwik_pro.csp_alter_subscriber` event subscriber adjusts the
policy via the optional `csp.policy_helper`. Both CSP services are optional (`@?...`), so the
module works without CSP.

## Drush

No custom Drush; use config commands, e.g.
`drush cset piwik_pro.settings site_id '1234abcd-...' -y`.
