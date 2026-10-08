<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# acquia_cms_support — agent index

Submodule of **acquia_cms_common**. A read-only "Configuration Inspector": it compares the config that
ships with the Acquia CMS modules (their `config/install` + `config/optional`) against the site's active
config, and reports which config objects are overridden vs unchanged, with a per-object parity percentage
and a YAML diff view. Purely diagnostic — it changes nothing.

Resolved release: **3.3.13** (packaged inside the acquia_cms_common tarball). Core `^10.2.2 || ^11`.
Depends on: `acquia_cms_common`.

No permissions of its own, no drush, no config schema. All routes require the core `administer site
configuration` permission.

- **Inspect overridden / unchanged config and view diffs (routes + service)** → [api/config-inspector.md](api/config-inspector.md)

## Key facts
- Admin section route `acquia_cms_support.config_sync` → `/admin/config/development/acquia-cms-support` (perm `administer site configuration`).
- Sub-routes: `acquia_cms_support.config_overridden`, `acquia_cms_support.config_unchanged`, `acquia_cms_support.config_diff`.
- Service `acquia_cms_support.config_service` (`Service\AcquiaCmsConfigSyncService`, `@internal`).
- Menu links + local tasks under System → Development; library `acquia_cms_support/diff-modal`.
