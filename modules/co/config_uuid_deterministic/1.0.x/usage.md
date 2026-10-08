<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Config UUID Deterministic makes configuration UUIDs deterministic.

---

Config UUID Deterministic **makes Drupal configuration UUIDs deterministic** — generating stable, derived
UUIDs for config entities so the same config has the same UUID across different site builds/environments,
avoiding UUID-mismatch import conflicts. It depends on core System, in the Configuration package.

Use it to keep config UUIDs consistent across environments. It is a developer/devops config tool affecting
config identity; it has no content or access role. Enable it before creating config you want to sync.

---

- Make config UUIDs deterministic.
- Derive stable UUIDs.
- Avoid UUID-mismatch conflicts.
- Depend on core System.
- Serve devops/config.
- Keep UUIDs consistent across environments.
- Affect config identity.
- Have no content/access role.
- Enable before creating syncable config.
- Handle deterministic UUIDs.
- Stabilize UUIDs.
- Configure nothing (behavior).
- Derive UUIDs.
- Handle config.
- Fix UUID mismatches.
- Configure config.
- Handle identity.
- Sync config.
- Enable it early.
- Provide deterministic config UUIDs.
