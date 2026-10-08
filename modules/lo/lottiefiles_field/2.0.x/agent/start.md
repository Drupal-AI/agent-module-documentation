<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Lottiefiles Field — agent index

Adds a `lottiefiles_field` field type (subclass of core Link), a widget, a formatter, and a
ready-made `lottiefiles` Media type/`lottiefile` Media source for embedding Lottie JSON
animations rendered by a bundled `<lottie-player>`. No global config page (`configure` null),
no permissions, no Drush, no config schema. Depends on `link`, `media`, `media_library`.

- **Field type, widget settings keys, formatter, the `lottiefiles` media type, upload handling** →
  [configure/field.md](configure/field.md)
- **The `lottiefiles_player_formatter` theme hook, its Twig, and the bundled JS player library** →
  [theming/player.md](theming/player.md)

Key facts:
- Field type `lottiefiles_field` extends `LinkItem`; stores a URI plus player option columns
  (`autoplay`, `background`, `controls`, `hover`, `loop`, `mode`, `speed`, `selector`, `width`).
- Widget `lottiefiles_field` (extends `LinkWidget`): URL field + `managed_file` upload limited to
  `json`, saved to `public://lottiefile_field/`, made permanent on submit; hex/`transparent`
  colour validated by `colorValidate`.
- Formatter `lottiefiles_field` renders `#theme => 'lottiefiles_player_formatter'`; background is
  `Xss::filter`ed. Media source id `lottiefile`, media type `lottiefiles`, source field
  `field_media_lottiefile` (all in `config/install/`).
- `hook_install()` copies `images/icons/lottie.png` into the media icon directory.
