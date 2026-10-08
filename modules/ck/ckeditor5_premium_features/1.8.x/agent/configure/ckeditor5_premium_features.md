# Configure — license, Cloud Services auth, and enabling a feature

## Where

- Menu landing: `ckeditor5_premium_features.form.settings` → `/admin/config/ckeditor5-premium-features` (the info.yml `configure` route; a system admin-block page).
- Actual settings form: `ckeditor5_premium_features.form.settings_general` → `/admin/config/ckeditor5-premium-features/settings` (form `Drupal\ckeditor5_premium_features\Form\SettingsForm`, requires `administer site configuration`).

Config object: **`ckeditor5_premium_features.settings`** (schema `config/schema/ckeditor5_premium_features.schema.yml`). Edit via the form or `drush cset ckeditor5_premium_features.settings <key> <value>`.

## Settings keys (`ckeditor5_premium_features.settings`)

| Key | Meaning |
|---|---|
| `license_key` | CKEditor commercial license key. Required for Revision History, Track changes, Comments (without RTC), and Productivity Pack. Min length 48. |
| `auth_type` | Authorization type for Cloud Services: `none`, `key` (Access key), or `dev_token` (Development token). |
| `env` | Environment ID (from the CKEditor dashboard) — used when `auth_type = key`. |
| `access_key` | Access key (from the CKEditor dashboard) — required when `auth_type = key`. |
| `web_socket_url` | Web Socket URL for real-time collaboration. |
| `dev_token_url` | Development token URL — testing only, used when `auth_type = dev_token`. |
| `dev_token_accept` | Acknowledge the consequences of using a development token URL. |
| `dll_location` | DLL packages (CKEditor JS bundles) location. |
| `organization_id` | Organization ID (from the CKEditor dashboard). |
| `alter_node_form_css` | Allow the module to alter the default Drupal theme CSS on the node form. |

Notes:
- **Access key** (`auth_type = key`, needs `env` + `access_key`) is recommended for production. **Development token** (`auth_type = dev_token`) is for testing only.
- **Real-time collaboration** and **Import from Word** require the authorization credentials; Export to Word/PDF only needs them to drop the watermark.
- The `TokenGenerator` service mints a JWT served at `/ckeditor5-premium-features/token` (route `ckeditor5_premium_features.endpoint.jwt_token`, gated by `use ckeditor5 access token`).

## Enabling a premium feature (two steps)

1. **Enable the feature's submodule** — e.g. `drush en ckeditor5_premium_features_export_pdf -y` (or track changes/comments via `ckeditor5_premium_features_collaboration`, RTC via `ckeditor5_premium_features_realtime_collaboration`, etc.). Each of the ~20 submodules is a separate toggle; enabling the parent alone provides no editing feature.
2. **Add its button/plugin to a text format's CKEditor 5 toolbar** at **Admin → Config → Content authoring → Text formats and editors** (`/admin/config/content/formats`). Edit the format that uses CKEditor 5, drag the feature's toolbar button into the active toolbar, and configure any per-format plugin settings.

The module also registers base CKEditor 5 plugins in `ckeditor5_premium_features.ckeditor5.yml`: `CloudServices` (`ckeditor5_premium_features__cloud_services`), `CollaborationBase`, and an export adapter — these are wired automatically when the relevant feature/toolbar item is active.
