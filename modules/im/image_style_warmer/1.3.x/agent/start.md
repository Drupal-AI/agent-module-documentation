<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Image Style Warmer — agent index

Pre-generates image style derivatives on file save (synchronously) and/or via a cron queue,
so derivatives exist before a visitor requests them. Depends on core **image**. Config UI at
`admin/config/development/performance/image-style-warmer` (route `image_style_warmer.settings`,
permission `administer site configuration`). No permissions of its own; no plugin types defined.

- **Choose which styles warm on upload vs via cron; config keys & storage** →
  [configure/settings.md](configure/settings.md)
- **The `image_style_warmer.warmer` service and its methods (`warmUp`, `doWarmUp`, `addQueue`)** →
  [api/warmer-service.md](api/warmer-service.md)
- **Drush `isw:wu` command and running the `image_style_warmer_pregenerator` queue** →
  [drush/commands.md](drush/commands.md)
- **The VBO/action plugins to warm existing files or media entities** →
  [extend/actions.md](extend/actions.md)

Key facts: two config lists in `image_style_warmer.settings` — `initial_image_styles` (built
in the request via the service's `destruct()`) and `queue_image_styles` (built by the
`image_style_warmer_pregenerator` cron QueueWorker). Generation is idempotent (skips existing
derivatives) and only runs on **permanent** image files. No per-field settings — the lists are
site-wide.
