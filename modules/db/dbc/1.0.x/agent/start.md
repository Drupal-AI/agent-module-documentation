<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Domain Base Css (dbc) — agent index

Loads a per-domain CSS stylesheet into every page head for Domain-module sites.

- **Version:** 1.0.x · **Core:** `^9 || ^10 || ^11` · **Package:** Domain
- **Depends on:** `domain:domain` (hard dependency). No composer requirements beyond core/domain.
- **Provides:** no plugins, services, entities, config schema, permissions.yml, or Drush commands.

## Structure

- **Route** `dbc.settings` → `/admin/config/domain/domain_css_switcher`, `_form: \Drupal\dbc\Form\CssSwitcherSettingForm`, requirement `_permission: 'administer domain css switcher setting'` (`dbc.routing.yml`). A local task links it under `domain.admin` (`dbc.links.task.yml`).
- **Form** `CssSwitcherSettingForm` (`ConfigFormBase`, `src/Form/CssSwitcherSettingForm.php`): renders one `managed_file` field per Domain entity (`.css` only, `public://dbc/`), saved to config object `dbc.settings` under key `uploaded_css_uploader_<domain_id>`.
- **Mechanism** `dbc_page_attachments_alter()` (`dbc.module`): resolves the active domain via `domain.negotiator`, loads the `File` saved for it, and attaches a `<link rel="stylesheet">` to `html_head`. Falls back to a `dbc` logger notice when Domain is disabled or no domains exist.

## Solution docs

- Configure uploads, the config object, route/permission, and the head-injection mechanism: [`config/settings.md`](config/settings.md)
