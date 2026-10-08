<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# dbc — per-domain CSS settings & injection

Everything Domain Base Css does: an admin form that stores one uploaded CSS file id
per domain, and a page-attachment hook that injects the active domain's stylesheet.

## Install / enable

- Requires the Domain module (`dependencies: [domain:domain]` in `dbc.info.yml`). Enable both: `drush en dbc -y`.
- No config schema, no `config/install/*`, no `composer.json`. Nothing to import; config is created lazily when the form is saved.
- Grant access to the settings route: it requires the permission string `administer domain css switcher setting`. Note this permission is **referenced only** in `dbc.routing.yml` — the module ships **no `dbc.permissions.yml` declaring it**, so it exists only if another module defines it; otherwise the route is reachable only by user 1. This is restrictive, not permissive.

## Route & task

`dbc.routing.yml`:

```
dbc.settings:
  path: '/admin/config/domain/domain_css_switcher'
  defaults:
    _title: 'Domain Css settings'
    _form: '\Drupal\dbc\Form\CssSwitcherSettingForm'
  requirements:
    _permission: 'administer domain css switcher setting'
```

`dbc.links.task.yml` adds a local task titled "Domain Css Settings" under `base_route: domain.admin`.

## Settings form — `CssSwitcherSettingForm`

`src/Form/CssSwitcherSettingForm.php`, extends `ConfigFormBase`.

- `getFormId()` → `dbc_admin_settings`; `getEditableConfigNames()` / `SETTINGS` const → config object **`dbc.settings`**.
- `buildForm()` loads all Domain entities via the `domain` entity storage and, for each, adds a `managed_file` field:
  - key: `uploaded_css_uploader_<domain_id>`
  - `#title`: "Css for domain \<domain name\>"
  - `#upload_location`: `public://dbc/`
  - `#upload_validators`: `file_validate_extensions => ['css']` (only `.css` accepted)
  - `#default_value`: the id array currently stored in config for that domain.
- `submitForm()` iterates the domains again and writes each field's value back to `dbc.settings` under the same `uploaded_css_uploader_<domain_id>` key, then calls the parent (which shows the "configuration has been saved" message).

Config shape (no schema ships, so these are untyped): each key `uploaded_css_uploader_<domain_id>` holds the managed-file value, an array whose first element (`[0]`) is the `File` entity id.

## Injection mechanism — `dbc_page_attachments_alter()`

`dbc.module`, `hook_page_attachments_alter()`:

1. If the `domain` module is not enabled → log a `dbc` notice, attach nothing.
2. `Domain::loadMultiple()`. If empty → log "No active domains found." and attach nothing.
3. Get the active domain id: `\Drupal::service('domain.negotiator')->getActiveId()`.
4. Read `dbc.settings:uploaded_css_uploader_<active_domain_id>`; take element `[0]` as the file id.
5. `File::load($fid)`; if it loads, generate its absolute URL with the `file_url_generator` service and append to `$attachments['#attached']['html_head']` a `link` tag (`rel=stylesheet`, `href=<url>`) keyed `dbc_costom_css`.

Notes for operators:
- The stylesheet is added on **every** page for the active domain, layered on top of the active theme (it does not replace theme CSS).
- If no file is configured for the active domain, `$dbc_confogs[0]` / `File::load()` yields nothing and no link is attached (a missing config key can emit a PHP notice on that lookup, harmless to output).
- The file is served from `public://dbc/` as a normal public file URL.
- Clear caches after uploading if the `<link>` does not appear; verify the `domain.negotiator` selects the expected active domain for the request host.
