<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Bootstrap Site Alert (bootstrap_site_alert) — agent index

Renders one or more dismissible, site-wide alert banners in Bootstrap `alert` styling on top of
every page. Alerts are NOT content, entities, blocks, or views — they are stored in the **State API**
(the `key_value` table) and edited on a single admin form. Depends on `js_cookie` (for the dismiss
cookie). Core `^10 || ^11`.

Configure route: `bootstrap_site_alert.admin` → `/admin/config/system/bootstrap-site-alert`
(permission `administer bootstrap site alerts`). Defines 2 permissions; no Drush commands, no plugins.

- **Create/edit alerts, the per-alert options, State keys, set via PHP/Drush** → [configure/alerts.md](configure/alerts.md)
- **The two permissions and their install-time defaults** → [permissions/permissions.md](permissions/permissions.md)
- **How and where alerts render (hook_page_top), path/admin filtering, the dismiss JS + cookie** → [hooks/page_top.md](hooks/page_top.md)

Key facts:
- Storage is `\Drupal::state()`, not config. Per-alert keys are `bootstrap_site_alert_<field><i>`
  with a 0-based `<i>`: `bootstrap_site_alert_active0`, `..._severity0`, `..._dismiss0`,
  `..._no_admin0`, `..._exclude0`, `..._only_paths0`, `..._negate0`, `..._message0`
  (a `{value, format}` text_format array). Non-indexed keys: `bootstrap_site_alert_version`
  (`3` or `4`), `bootstrap_site_alert_count` (number of alerts), `bootstrap_site_alert_key`
  (random 16-char dismiss token, regenerated on every save).
- Form: `\Drupal\bootstrap_site_alert\Form\BootstrapSiteAlertAdmin` (form id `bootstrap_site_alert_admin`);
  AJAX "Add Another Alert" / "Remove Last Alert" buttons build a variable number of fieldsets.
- Render: `bootstrap_site_alert_page_top()` (hook_page_top, weight 1000) emits
  `<div class="alert bs-site-alert <severity>" role="alert">` via an `inline_template`; the body is a
  `#type => processed_text` element rendered through its stored text format.
- Libraries: `bootstrap_site_alert/dismissed-cookie` (js/dismissed-cookie.js, needs `js_cookie`) and
  `bootstrap_site_alert/bs-site-alert-form` (admin form CSS). Dismiss cookie name:
  `Drupal.visitor.bootstrap_site_alert_dismissed`.
- Legacy config object `bootstrap_site_alert.settings` (+ its schema) still ships but is unused at
  runtime — the module moved to the State API in 8.x-1.3, and uninstall deletes that config.
