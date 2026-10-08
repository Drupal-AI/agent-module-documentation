<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Fediverse platform plugins

This module contributes four `SocialLinkFieldPlatform` plugins to the parent **Social Link Field**
(`social_link_field`) module. It defines no plugin *type* of its own — it reuses the parent's type,
manager, annotation and base class. There is nothing to configure.

## Install / enable

- Requires `social_link_field` (declared in `fediverse_social_link_field.info.yml` as
  `social_link_field:social_link_field`). Enable the parent first (or together).
- `drush en fediverse_social_link_field -y` — enabling it makes the four platforms available; no
  further setup. README: "No configuration is needed."

## The four plugins

All live in `src/Plugin/SocialLinkField/Platform/` and are declared in the **parent's** namespace
`Drupal\social_link_field\Plugin\SocialLinkField\Platform`, extending
`Drupal\social_link_field\PlatformBase`. Each class body is empty; the plugin is defined entirely by
its `@SocialLinkFieldPlatform` annotation.

| File | id | name | icon | iconSquare | urlPrefix |
|------|----|------|------|-----------|-----------|
| `Fediverse.php` | `fediverse` | Fediverse | `fa-usb` | `fa-usb` | `https://` |
| `Mastodon.php` | `mastodon` | Mastodon | `fa-mastodon` | `fa-mastodon-square` | `https://` |
| `Lemmy.php` | `lemmy` | Lemmy | `fa-reddit` | `fa-square-reddit` | `https://` |
| `Hubzilla.php` | `hubzilla` | Hubzilla | `fa-connectdevelop` | `fa-connectdevelop` | `https://` |

The annotation fields are defined by the parent's
`src/Annotation/SocialLinkFieldPlatform.php`: `id`, `name` (Translation), `icon`, `iconSquare`,
`urlPrefix`, `urlSuffix`. This module sets only the first five; none set `urlSuffix`.

## How the parent consumes them (parent source)

- **Discovery:** `SocialLinkFieldPlatformManager` (a `DefaultPluginManager` for
  `Plugin/SocialLinkField/Platform`) auto-discovers these classes because they sit in that
  namespace directory. `getPlatforms()` returns all definitions keyed by id.
- **Data entry:** the parent's field type is `social_links` (`SocialLinkItem`) storing `social`
  (platform id) + `link` (the handle/path). The widget `SocialLinkWidget` builds a select of every
  platform (`$platform['name']->getUntranslatedString()`) and prefixes the link textfield with the
  chosen platform's `urlPrefix` (`https://`).
- **Display:** `SocialLinkFontAwesomeFormatter` renders each item as an `<i>` tag with classes
  `[iconSet ?? 'fa-brands', icon|iconSquare]` and a link `url = urlPrefix . link`, title = platform
  `name`; `SocialLinkNetworkNameFormatter` renders the network name. Output goes through the
  parent's `social-link-field-formatter.html.twig`.

## Operating notes

- To restrict a field to only these networks, use the parent field's per-field **platforms**
  setting (the widget intersects available platforms with that setting).
- Icons rely on Font Awesome being present (the parent can attach it via its
  `social_link_field.settings` `attached_fa` option). The `lemmy` icons reuse Reddit glyphs and the
  `fediverse` icon reuses `fa-usb` — purely cosmetic annotation choices.
- This module adds no `config/schema`, so it contributes no schema keys; the platform definitions
  are code, not config.
