<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# canvas_api — install, configuration & routes

## Install / enable
`drush en canvas_api -y`. Hard dependencies (`canvas_api.info.yml`): `canvas_lms:canvas_lms` and
`key:key` — both must be present/enabled. No composer library requirements.

`hook_requirements()` (`canvas_api.install`, runtime phase) reports a REQUIREMENT_ERROR on the status
report until BOTH are set:
- `canvas_lms.settings` has `institution` and `environment`;
- `canvas_api.settings` has `key`.

## Configuration objects
- **`canvas_lms.settings`** (owned by the `canvas_lms` module): `institution` (the Canvas subdomain,
  e.g. `myschool`) and `environment` (`production` | `test` | `beta`). These drive `getUrlString()`.
  Set at `/admin/config/canvas_lms/canvas_lms` (`canvas_lms.settings` route).
- **`canvas_api.settings`** (this module): single key `key` = the machine id of a **Key** entity that
  holds the Canvas access token. No config schema ships with the module.

### Set the token as a Key entity (recommended)
Create a Key (env/file/config provider) holding the Canvas personal access token, then select it on
the settings form. Storing the raw token as an env-provider Key keeps it out of exported config.

## Routes / screens (both require `administer site configuration`)
| Route | Path | Form |
|-------|------|------|
| `canvas_api.settings` | `/admin/config/canvas_api` | `Form\CanvasApiSettingsForm` |
| `canvas_api.tester` | `/admin/reports/canvas_api` | `Form\CanvasApiTesterForm` |

Menu links (`canvas_api.links.menu.yml`): settings under `canvas_lms.admin_config`; tester under
`system.admin_reports`.

### `CanvasApiSettingsForm`
`ConfigFormBase`; a single `key_select` element writes `key` into `canvas_api.settings`. (Note: its
`getEditableConfigNames()` returns `canvas_api_settings` — underscored — while `submitForm()` writes
to `canvas_api.settings`; the submit handler is what persists the value.)

### `CanvasApiTesterForm`
`FormBase` injecting the `canvas_api` service. Fields: `method` (select over `GET/POST/PUT/DELETE`),
`path` (required, path without `/api/v1/`), `parameters` (textarea of JSON). `validateForm()` rejects
invalid JSON. An AJAX submit (`fetchResultsCallback`) runs
`setMethod()->setPath()->setParams()->request()` and renders the result with `print_r(...)` inside a
`<pre>` block. Purely a developer/diagnostic tool — it performs live Canvas calls against the
configured environment, so it is gated to site administrators.

## Operating notes
- Confirm `institution` + `environment` + `key` before first use, or the service logs
  “No Canvas API key found”/“No Canvas environment set” and requests will fail.
- Switch environments (production/test/beta) purely via the `canvas_lms` `environment` setting.
- The module exposes no permissions of its own; access is entirely `administer site configuration`
  for the admin screens, and code-level for the service.
