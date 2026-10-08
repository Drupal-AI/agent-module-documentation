<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Config Warning (config_warning) — agent index

**Adds a configurable warning message to admin forms that would alter the site's running configuration.**

- **Version:** 1.0.x
- **Core:** ^10.1 || ^11
- **Package:** Administration
- **Route:** `config_warning.settings` → `/admin/config/development/config-warning` (permission `administer site configuration`)
- **Config:** `config_warning.settings` (`enabled`, `warning_message`, `conditions.request_path`)
- **Hook:** `FormHooks::formAlter` (`#[Hook('form_alter')]` service) — admin routes only; flags forms via `getEditableConfigNames()`, `EntityForm` on an existing `ConfigEntity`, `UserPermissionsForm`, or `BlockListBuilder`
- **Scoping:** wrapped core `request_path` condition plugin (`negate` include/exclude)

**Security:** single admin settings route gated by `administer site configuration`; no anonymous or mutating endpoints. The message text is admin-authored and rendered through the messenger.

See [configure/settings.md](configure/settings.md)
