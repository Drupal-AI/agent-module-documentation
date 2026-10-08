<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configuration

There is **no** settings form or admin menu. The module has exactly one config value.

Config object `tracker.settings` (schema `config/schema/tracker.schema.yml`,
default `config/install/tracker.settings.yml`):

| Key | Type | Default | Meaning |
|---|---|---|---|
| `cron_index_limit` | integer | `1000` | Number of existing nodes back-indexed per `hook_cron` run when first populating the index (see [../api/pages.md](../api/pages.md)). |

Set it via Drush:

```bash
ddev drush cset tracker.settings cron_index_limit 500 -y
```

Notes:
- After install, `tracker.index_nid` **state** is seeded to the max node id and cron walks downward in
  `cron_index_limit` batches until it reaches 0 (fully indexed); it then stops doing back-fill work.
- New/updated nodes and comments are indexed immediately by entity hooks regardless of this setting —
  `cron_index_limit` only governs the one-time back-fill of pre-existing content.
