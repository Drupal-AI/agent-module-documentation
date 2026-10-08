<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# `usercentrics_app` — Data Processing Service (DPS) config entity

Config entity type declared in `src/Entity/UsercentricsApp.php`
(`@ConfigEntityType(id = "usercentrics_app")`), interface `src/UsercentricsAppInterface.php`.
Label: *"Usercentrics Data Processing Service (DPS)"*. `admin_permission = "administer usercentrics"`.
Each enabled app tells the gating hooks which scripts belong to one consent service.

## Stored / exported fields (`config_export`)

| Field | Type | Purpose |
|-------|------|---------|
| `id` | string | Machine name (≤32). |
| `uc_id` | string | Usercentrics Template ID — **documentation only**, not used by any gating logic. |
| `label` | string | Must equal the Usercentrics DPS name; used as the `data-usercentrics` marker value. |
| `status` | bool | Enabled. Only enabled apps are loaded by `UsercentricsHelper::getApps()`. |
| `javascripts` | string[] | Substrings matched against a script/iframe/img/audio/video `src` (partial match, `mb_strpos`). |
| `attachments` | string[] | Exact `hook_page_attachments` identifiers (the 2nd element of an `html_head` entry) to gate. |
| `libraries` | string[] | Asset-library names (e.g. `google_tag/gtag`) whose JS to gate. |
| `weight` | int | Sort order. |

Schema: `config/schema/usercentrics.schema.yml` (`usercentrics.usercentrics_app.*`). Getters/setters
mirror the fields (`ucId()`, `javascripts()`, `attachments()`, `libraries()`, `weight()`, …).
`save()` and `delete()` both `Cache::invalidateTags(['config:usercentrics.settings', 'library_info'])`
so gating and library metadata are recomputed.

## Forms, routes, list builder

- Add/edit: `Form/UsercentricsAppForm.php` (`EntityForm`, `@internal`). Fields: Label, machine `id`,
  `uc_id`, Enabled, and three textareas — **Sources** (`js`), **Attachments** (`att`), **Libraries**
  (`libraries`) — each split on newlines, trimmed, `array_filter`ed on save. Redirects to
  `usercentrics.admin.order_form`.
- Delete: `Form/UsercentricsAppDeleteForm.php`.
- Ordering table: `Form/UsercentricsAppOrderForm.php` (route `usercentrics.admin.order_form`,
  path `/admin/config/user-interface/usercentrics`) — a `tabledrag` weight table that also toggles
  each app's `status`; saves each entity.
- List builder: `src/UsercentricsAppListBuilder.php` (Label / Usercentrics ID / Status columns).
- Entity links (from the annotation): collection/add/edit/delete under
  `/admin/config/user-interface/usercentrics/apps` via core `AdminHtmlRouteProvider`.

All of the above are gated by `administer usercentrics` (entity `admin_permission` + the order
form's route permission); entity/form submissions carry Drupal's standard CSRF protection.

## Shipped default apps (`config/install/`, all `status: false`)

| id | label | matches via |
|----|-------|-------------|
| `google_analytics` | Google Analytics | (see config) |
| `google_analytics_4` | Google Analytics 4 | `libraries: google_tag/gtag, google_tag/gtag.ajax, google_tag/gtm` |
| `google_tag_manager` | Google Tag Manager | same three `google_tag/*` libraries |
| `matomo` | Matomo | `javascripts: matomo.js` + `attachments: matomo_tracking_script` |
| `matomo_self_hosted` | Matomo (self hosted) | (see config) |

Note the shipped configs match the corresponding Drupal contrib modules' assets. Site builders add
their own DPS for any other script; the README warns configs come without guarantee and to verify
the result (inspector / Lighthouse / debug mode).
