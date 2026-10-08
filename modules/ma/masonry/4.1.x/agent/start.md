<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Masonry API — agent index

A **developer API only**: one service, three alter hooks, three libraries. No settings form, no
configure route (`configure: null`), no permissions, no Drush, no plugin types, no config,
no Views style. Consuming modules (e.g. *Masonry Views*) provide the UI.

- **`masonry.service` — options, `applyMasonryDisplay()`, `buildSettingsForm()`** →
  [api/masonry-service.md](api/masonry-service.md)
- **`hook_masonry_default_options_alter()` / `_options_form_alter()` / `_script_alter()`** →
  [hooks/alters.md](hooks/alters.md)
- **Installing the Masonry + imagesLoaded JS libraries** →
  [configure/libraries.md](configure/libraries.md)

Key facts:
- Service id: **`masonry.service`** → `Drupal\masonry\Services\MasonryService`.
- Entry point: `applyMasonryDisplay(array &$form, string $container, string $item_selector,
  array $options = [], array $masonry_ids = ['masonry_default'])`.
- Attaches library `masonry/masonry.layout` and writes
  `drupalSettings.masonry[<container selector>]`.
- The JS libraries are **not bundled** — they must exist at
  `/libraries/masonry/dist/masonry.pkgd.min.js` and
  `/libraries/imagesloaded/imagesloaded.pkgd.min.js`. `hook_requirements()` reports them.
