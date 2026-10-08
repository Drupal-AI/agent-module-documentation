<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Social Media Platforms (social_media_platforms) — agent index

Displays a configurable, drag-orderable row of links to **the site owner's own social-media
profiles** through a single block. The network list, labels, URLs and display options live in one
**standalone settings form** (`social_media_platforms.settings`), not in the block instance — so
one placed block renders whatever the form holds. Version **1.1.0**, core `^10.2 || ^11`, depends
only on core `block`.

**Not share buttons.** These are outbound anchors to the org's profiles; they load nothing
third-party and carry no consent requirement (unlike share widgets such as `easy_social`).

- Config route: `/admin/config/services/social-media-platforms` (menu under *Configuration ›
  Web services*).
- Permission: `administer social media platforms` — the only permission it defines; **not**
  marked `restrict access`. Gates the settings form only.
- Block: plugin id `social_media_platform_block`, admin_label "Social Media Platform Links",
  plugin category "Social Media Platforms". Placed via the core block UI (`administer blocks`).
- Config object: `social_media_platforms.settings` (schema + `config/install` default provided).
- Drush: none. Plugin *types*: none (implements one core Block plugin).

Solution docs:
- **Place the block / how it renders (theme, template, icons, cache)** → [blocks/social-media-links.md](blocks/social-media-links.md)
- **The settings form, config object, platforms & display options** → [config/settings.md](config/settings.md)

Key facts:
- Block class `Drupal\social_media_platforms\Plugin\Block\SocialMediaBlock` (extends `BlockBase`,
  `ContainerFactoryPluginInterface`); injects `theme.manager`, `extension.path.resolver`,
  `config.factory`.
- Form class `Drupal\social_media_platforms\Form\SettingsForm` (extends `ConfigFormBase`).
- Theme hook `social_media_platforms_links`; template
  `templates/social-media-platforms-links.html.twig`; CSS library
  `social_media_platforms/social_media_platforms.theme` attached via preprocess.
- Seven built-in platforms only: `facebook`, `youtube`, `linkedin`, `x`, `instagram`,
  `pinterest`, `tiktok`. The form edits these rows but **cannot add new networks**; bundled PNG
  icons (`images/<key>.png`) exist only for these seven.
- Icon source is one of `none` / `image` (bundled PNG) / `font` (`<i class="…">` with per-row
  font classes, e.g. FontAwesome). A platform whose URL is empty is skipped at render.
- URLs are entered via a `#type => 'url'` element → validated to `http/https/ftp/feed` schemes
  only (core `UrlHelper::isValid`, absolute); `javascript:`/`data:` are rejected.
- Install hooks: `update_10101` adds the `tiktok` platform; `update_10201` migrates the old
  `show_icon` boolean to `icon_source` and adds the `font_classes` key.
- Pairs with Domain's `domain_config` to override the settings per domain/language behind a single
  block.
