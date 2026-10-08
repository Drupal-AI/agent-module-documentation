<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Acquia CMS Support is a submodule of acquia_cms_common that provides a read-only Configuration Inspector: it compares the config shipped by the Acquia CMS modules against the site's active config and shows which objects have been overridden, which are unchanged, and the exact YAML differences.

---

The inspector lives under Configuration → Development at /admin/config/development/acquia-cms-support and is gated by the administer site configuration permission. It walks each Acquia CMS module's shipped config/install and config/optional storage, diffs it against active config with core's StorageComparer, and computes a parity percentage per object after stripping volatile keys like uuid and _core. Two listing pages separate overridden config from unchanged config, and a diff route renders a two-way Staged-vs-Active YAML diff for any single object in a modal. It writes nothing and provides no drush of its own; to actually revert config to shipped defaults you use acquia_cms_common's acms:config-reset command. It is useful when auditing configuration drift on an Acquia CMS site before an upgrade or config export.

---
- Audit configuration drift on an Acquia CMS site.
- List config objects overridden away from shipped defaults.
- List config objects still matching shipped defaults.
- See a per-object parity percentage for shipped vs active config.
- View a Staged-vs-Active YAML diff for a single config object.
- Decide what to reset before running acms:config-reset.
- Review config changes prior to a distribution upgrade.
- Confirm whether an install applied its optional config.
- Inspect module-shipped versus profile-shipped config.
- Support debugging of unexpected configuration on ACMS sites.
- Give site builders a config-comparison tool without CLI access.
