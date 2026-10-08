<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Config Warning displays a configurable warning on admin forms that are likely to change the site's running configuration, reminding editors that their edits may be lost on the next deployment.

---

The module implements `hook_form_alter` (via a `#[Hook]` service, `FormHooks::formAlter`) and, on admin routes only, decides whether the current form alters configuration. A form is treated as config-altering when its form object implements `getEditableConfigNames()`, is an entity form editing an existing config entity, or is core's user-permissions or block-listing form. When it qualifies and the module is enabled, the configured warning text is shown as a Drupal warning message.

Where the warning appears is scoped by a wrapped core `request_path` condition plugin: with **Exclude matching paths** checked (the default) the warning is hidden on the listed paths, and unchecked it shows only on them. The single settings form lives at `/admin/config/development/config-warning` behind `administer site configuration`; there are no other routes, permissions, or endpoints. A common pattern is to keep the warning disabled in development and enable it on production so editors are nudged to make config changes in code instead.

---

- Enable a warning on config-altering admin forms
- Customise the warning text (e.g. link to a deployment policy)
- Translate the warning message per language
- Warn on config entity edit forms (views, blocks, image styles, etc.)
- Warn on the user permissions form
- Warn on the block layout listing form
- Warn on any `ConfigFormBase` settings form
- Restrict the warning to specific admin paths
- Exclude specific admin paths from the warning
- Use wildcard paths like `/admin/structure/block/*`
- Keep the warning off in development, on in production
- Remind editors that UI config changes are lost on deploy
- Disable the warning entirely without uninstalling
- Scope the warning to only the block layout area
- Point staff to a change-management process before editing config
- Review current settings via config export (`config_warning.settings`)
- Re-enable the warning after a config-management rollout
