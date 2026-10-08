<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Imagecache External — agent index

Applies Drupal **image styles to remote images** by downloading them into a local cache first.
Depends on `image`. Core entry point is the procedural function
`imagecache_external_generate_path($url)` → local URI. Consumed via two field formatters, two
theme hooks, and a Twig filter. Config object `imagecache_external.settings`.

- **Settings keys, whitelist, management mode, SVG, cron flush, field formatters** →
  [configure/settings.md](configure/settings.md)
- **API functions (`generate_path`, `fetch`, `validate_host`), theme hooks, Twig filter** →
  [api/functions.md](api/functions.md)
- **Drush commands (`generate`, `set-default-image`, `validate-host`)** →
  [drush/commands.md](drush/commands.md)
- **Alter hooks (`needs_refresh`, `destination`, `flush_filepath`)** →
  [hooks/hooks.md](hooks/hooks.md)

Key facts:
- Configure route: `imagecache_external.admin_settings` (`/admin/config/media/imagecache_external`).
  Flush form: `imagecache_external.imagecache_external_flush_form` (`.../flush`).
- Permission: `administer imagecache external` (gates both forms).
- Twig: `{{ 'https://host/img.jpg'|imagecache_external('thumbnail') }}` → styled derivative URL.
- Formatter ids: `imagecache_external_image`, `imagecache_external_responsive_image`
  (for `link`/`string`/`text` fields holding a URL).
- Cache dir default `public://externals` (`imagecache_directory`); files unmanaged by default
  (`imagecache_external_management`). Requires the external `enshrined/svg-sanitize` library.
