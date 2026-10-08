<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Adds selective config patching to Configuration Split when 'Do not patch dependents' is enabled.

---

Config Split Selective Patch adds selective config patching to Configuration Split when the "Do not patch dependents" option is enabled. Config Split 2.x normally exports a config's active↔sync diff as a compact `config_split.patch.*` file, but with "Do not patch dependents" on, partial-split items are instead stored as full config copies when they differ. This module adds a per-split **Partial Split (Patch)** list: the config you name there is still exported as patch files even under that mode, letting a team adopt patch-based splitting on a chosen subset only. Import behaviour is unchanged. It extends Config Split. Depends on `config_split`; supports Drupal 10.3+ and 11.

---

- Add selective config patching.
- Extend Configuration Split.
- Honour 'Do not patch dependents'.
- Patch only the intended config.
- Leave dependent config alone.
- Avoid unintended config changes.
- Refine split import/export.
- Depend on `config_split`.
- Support Drupal 10.3+ and 11.
- Control split patching.
- Aid config workflows.
- Handle selective patches.
- Patch config
- Refine Config Split
- Support Drupal.
