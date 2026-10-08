<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Block Classes — agent index

Adds three CSS-class textfields (**Block / Title / Content**) to the core block placement form.
No settings form, **`configure: null`**, no plugins, no Drush, no services. All state is
third-party settings on the `block` config entity.

- **Set / read the classes (config keys, drush, PHP)** → [configure/block-classes.md](configure/block-classes.md)
- **The one permission that gates the fields** → [permissions/permissions.md](permissions/permissions.md)
- **Where the classes land in markup (`attributes`, `title_attributes`, `content_attributes`)** →
  [theming/rendering.md](theming/rendering.md)

Key fact: `block.block.<block_id>` → `third_party_settings.block_classes.{block_class,title_class,content_class}`
(three space-separated strings, max 255 chars each). Empty values are removed on presave.
