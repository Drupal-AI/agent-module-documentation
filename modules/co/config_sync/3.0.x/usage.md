<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Configuration Synchronizer imports configuration changes shipped by updated modules, themes and install profiles into a live site, letting you pull in an extension's new/changed config without losing your own customizations.

---

When you update a module or theme, its `config/install` (and optional/provider) config may have changed since you first installed it, but Drupal normally never re-imports that config. config_sync closes that gap: on install it takes a **snapshot** (via the config_snapshot module, snapshot set `config_sync`) of the config each installed extension currently provides, and thereafter compares the snapshot against what the updated extension now provides to build a per-extension **changelist**. Those available updates are shown on the **Distribution Updates** page (`config_distro.import`, its `configure` route) and can be applied in one of three **update modes**: **Merge** (1, default — three-way merge that keeps your local edits, powered by config_merge), **Partial reset** (2 — reset only the items with available updates to the provided version) and **Full reset** (3 — reset all provided config to what the extensions ship). The chosen mode is stored in state under `config_sync.update_mode`. The heavy lifting is a `config_distro` sync filter plugin (`SyncFilter`, id `config_sync`) plus services `config_sync.snapshotter`, `config_sync.lister` and `config_sync.collector`, layered on config_distro/config_filter/config_normalizer/config_update. It adds a Drush command `config-sync-list-updates` (alias `cs-list`) and an `--update-mode` option on `config-distro-update`. It ships no permissions, no config schema and no `configure` form of its own (the UI and route come from config_distro).

---

- Pull in new fields a distribution added to a content type in its latest release.
- Update an install-profile-provided View to the version shipped by the new profile release.
- Re-import a module's changed default config after `composer update` without a manual diff.
- Keep your own label/permission edits while merging an extension's config changes (Merge mode).
- Reset a specific config item to the version the module ships (Partial reset) after local drift.
- Force all extension-provided config back to shipped defaults (Full reset) to recover a baseline.
- Review, per module/theme, exactly which config objects have create/update changes available.
- List available configuration updates from the CLI with `drush config-sync-list-updates`.
- Run a scripted distro update in full-reset mode via `drush config-distro-update --update-mode=3`.
- Maintain a Drupal distribution and ship config improvements to downstream sites.
- Selectively apply updates from some modules while skipping others on the Distribution Updates page.
- Snapshot the current provided config of all extensions at install for later comparison.
- Detect that an updated theme now provides additional block or settings config.
- Adopt upstream config bug-fixes (e.g. a corrected field setting) on an existing site.
- Avoid clobbering editor customizations when accepting an extension's config update.
- Automate config-update adoption in a deployment pipeline using the Drush command + mode flag.
- Compare a module's currently-provided config against the snapshot taken when it was installed.
- Bring a long-running site's config back in line with the modules' current recommendations.
- Choose a conservative merge or an aggressive reset per deployment as policy requires.
- Inspect the `config_sync` snapshot set to see what config each extension provided at install time.
