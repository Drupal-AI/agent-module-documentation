<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Config Guardian adds config snapshots, rollback, impact analysis, and import/export on top of core config.

---

Config Guardian extends Drupal configuration management with snapshots (point-in-time captures), rollback to a previous snapshot, and impact analysis so operators can see what a config change would affect before applying it. It aims to make config changes safer and reversible.

It exposes a broad permission set — administration, create/restore/view/delete/export/import snapshots, impact analysis, and synchronize/import/export configuration. Restoring or importing config can overwrite the site's configuration, so restrict `restore`/`import`/`synchronize`/`administer` to trusted operators. Depends on core `config` and `file`; supports Drupal 10.5+, 11, and 12.

---

- Snapshot configuration point-in-time.
- Roll back to a snapshot.
- Analyze config-change impact.
- Make config changes reversible.
- Export/import snapshots.
- Gate admin with `administer config guardian`.
- Separate create/restore/view/delete snapshot permissions.
- Gate impact analysis and sync/import/export.
- Restrict restore/import/synchronize to trusted operators.
- Depend on core `config` and `file`.
- Support Drupal 10.5+, 11, and 12.
- Preview change effects.
- Capture config history.
- Recover from bad changes.
- Compare snapshots.
- Improve config safety.
- Manage configuration lifecycle.
- Avoid risky overwrites without review.
