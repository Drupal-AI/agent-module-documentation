<!--
SPDX-FileCopyrightText: © 2025 Agent Module Documentation contributors
SPDX-License-Identifier: GPL-2.0-or-later
-->
# migrate_file — agent index

Migrate Files (extended) provides **four migrate process plugins** for creating managed
`file`/image entities inline during a migration — from a local path or a remote URL —
instead of running a separate files migration first. It has **no UI, no config schema, no
permissions, no services and no Drush commands**: you consume the plugins from migration
YAML or a `migrate_plus.migration` config entity. Depends on core `migrate`. Installed
release here is **3.0.0-alpha1** (alpha).

- The four plugin ids, every config key, and how they differ from core `file_copy` →
  [plugins/process-plugins.md](plugins/process-plugins.md)
- Patterns: dynamic destinations, `@destination` refs, `id_only`, building/running a
  migration config entity, the Remote Stream Wrapper requirement, and a known runtime
  caveat on this site → [api/patterns.md](api/patterns.md)

Quick facts:
- Plugins: `file_import`, `image_import` (extends file_import), `file_remote_url`,
  `file_remote_image` (extends file_remote_url).
- `file_import` returns `['target_id' => N]` (or `N` with `id_only: true`); core `file_copy`
  returns only a destination URI and creates no entity.
- `file_remote_url` / `file_remote_image` store the remote URL as the file URI **without
  downloading** — they need `drupal/remote_stream_wrapper` to serve it.
- Migration config entities live under the config prefix `migrate_plus.migration.<id>`.
