<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Media Alias Display — agent index

Serves a media entity's **source file directly** at the media's canonical URL / path alias
(e.g. a PDF opens at `/policies/handbook`) instead of rendering the media view page. It does this
by overriding the controllers on `entity.media.canonical` and `entity.media.revision`. Requires
core Media's **Standalone media URL** setting on; depends on `media_library`. Config UI at
`/admin/config/media/media_alias_display`. No permissions of its own (uses
`administer site configuration`); no Drush.

- **Settings (`kill_switch`, `media_bundles`), the Standalone-URL requirement, `?edit-media` / `?dl` / `?download`** →
  [configure/settings.md](configure/settings.md)
- **How it works: route override, `DisplayController` decision flow, file streaming, cache context** →
  [api/behavior.md](api/behavior.md)

Submodule: **media_alias_display_field_override** — adds a per-media `field_override_mad_module`
boolean so individual media items opt out. Docs nested under
`modules/media_alias_display_field_override/3.0.x/`.

Key facts:
- Config object `media_alias_display.settings`: `kill_switch` (bool), `media_bundles` (sequence
  of allowed media type ids; empty = all).
- Only file-source media (`Drupal\media\Plugin\media\Source\File`) are streamed; others render normally.
- Cache context: `media_alias_display_kill_switch_toggle`.
