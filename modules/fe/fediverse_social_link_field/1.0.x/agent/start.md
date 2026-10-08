<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Fediverse Social Link Field (fediverse_social_link_field) — agent index

Adds **Fediverse** platforms to the contributed **Social Link Field** module. It ships only four
`SocialLinkFieldPlatform` plugin instances (no field type, widget, formatter, form, route,
permission, service, config or Drush of its own). Package `Field types`. Version **1.0.0-alpha2**
(version dir `1.0.x`). Core `^10.3 || ^11`. License GPL-2.0-or-later.

- **The four platform plugins, their annotation metadata, and how the parent consumes them** →
  [plugins/platforms.md](plugins/platforms.md)

## What it actually is

- A hard dependency on **`social_link_field`** (`dependencies: social_link_field:social_link_field`
  in `fediverse_social_link_field.info.yml`). Nothing works without the parent enabled.
- Four classes under `src/Plugin/SocialLinkField/Platform/`, each declared in the **parent's**
  namespace `Drupal\social_link_field\Plugin\SocialLinkField\Platform` and extending the parent's
  `PlatformBase` (itself an empty abstract class):
  - `Fediverse.php` — id `fediverse`, icon `fa-usb` / `fa-usb`
  - `Mastodon.php` — id `mastodon`, icon `fa-mastodon` / `fa-mastodon-square`
  - `Lemmy.php` — id `lemmy`, icon `fa-reddit` / `fa-square-reddit`
  - `Hubzilla.php` — id `hubzilla`, icon `fa-connectdevelop` / `fa-connectdevelop`
- Every class body is **empty** (`class X extends PlatformBase {}`); all behaviour is in the
  `@SocialLinkFieldPlatform` annotation (`id`, `name`, `icon`, `iconSquare`, `urlPrefix = "https://"`).
- No config needed (README: "No configuration is needed"). No `composer.json` ships with the module.

## How it plugs into the parent (from parent source)

- The parent's plugin manager `SocialLinkFieldPlatformManager` discovers plugins in
  `Plugin/SocialLinkField/Platform` across all modules, so these four are picked up automatically.
- The parent's widget `SocialLinkWidget` (field type `social_links`) lists every platform as a
  select option and prepends the platform's `urlPrefix` to the profile-link textfield.
- The parent's formatters (`SocialLinkFontAwesomeFormatter`, `SocialLinkNetworkNameFormatter`)
  render each item as `urlPrefix . link` using the platform's `icon`/`iconSquare` and `name`, via
  the parent's `social-link-field-formatter` Twig template.
