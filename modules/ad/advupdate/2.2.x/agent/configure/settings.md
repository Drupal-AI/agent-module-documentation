<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configure Update Manager Advanced

The module has no page of its own — `configure` points at **core's Update settings form**
(`update.settings`, `/admin/reports/updates/settings`, perm `administer site configuration`).

## Setting

`hook_form_update_settings_alter()` adds one checkbox, **"Expand the report using 'Update
Manager Advanced' module"**, saved by a submit handler to:

```
advupdate.settings:
  notification:
    extend_email_report: true   # default (config/install/advupdate.settings.yml)
```

Schema: `advupdate.settings` (config_object) → `notification.extend_email_report` (boolean).
Because the default is **true**, the expanded email is active as soon as the module is
enabled; uncheck the box to keep the module installed but silent.

Set it with Drush:

```bash
ddev drush config:set advupdate.settings notification.extend_email_report 0 -y
```

## What the email alteration does

`hook_mail_alter()` fires only for message id `update_status_notify` (core's update
notification, sent on cron per the core "Check for updates" schedule). When
`extend_email_report` is on, it appends:

1. the update detail list from `UpdateDetailsMarkup::createFromProjectData()` — projects that
   are not current, grouped **Enabled / Disabled / Manual updates required (core)**, each with
   installed + recommended version and a release-notes link, tagged `(Security update)` /
   `(Unsupported)` as applicable; and
2. a footer line crediting the module with a link to the project page.

Data comes from core `update_get_available()` + `update_calculate_project_data()`; nothing
user-supplied is rendered (the render class blocks its own `create()` string entry point).

## Security Updates block

Plugin `advupdate_security_updates` ("Security Updates", category *Administration*). Place it
via *Block layout* (`/admin/structure/block`). Behavior:

- Lists only projects with core status `NOT_SECURE` (installed vs recommended version, link
  to each project / the available-updates page).
- `blockAccess()` requires **`administer site configuration`** and returns *forbidden* (with
  cache tag `update`) when there are no pending security updates, so it self-hides.
- Cache: rows cached 1h with cache tag `update`; core project data is read from
  `update.manager` (`projectStorage('update_project_data')`), falling back to a fresh
  `update_get_available()` calculation if the cache is cold.
