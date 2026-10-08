<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Media Link Enhancements — agent index

Rewrites core Media links: direct-to-file linking, type/size appending, `download` attribute,
canonical-route redirect, binary response, and WYSIWYG content parsing. One global settings form
(`configure` = `media_link_enhancements.settings`, permission `administer_media_link_enhancements`),
config object `media_link_enhancements.settings`. Depends on core `media`; requires *Standalone media
URL* enabled. No Drush, no plugin types of its own.

- **All five features, every settings key, defaults, and how each is scoped to bundles/extensions** →
  [configure/settings.md](configure/settings.md)
- **The services and hooks (how links get rewritten at render time / at the canonical route)** →
  [api/services.md](api/services.md)

Key facts:
- Overrides `entity.media.canonical` controller with `MediaLinkEnhancementsController::download`
  (redirect + binary-response logic); implements `hook_entity_display_build_alter()` for link/text fields.
- Only **published** media in an allowed bundle are affected; extension allow-lists further gate each feature.
- Config default: every feature is **off** (`enable_* = 0`) on install.
