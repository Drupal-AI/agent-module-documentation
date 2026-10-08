<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Image Link Formatter — agent index

Adds an image field formatter **`image_link_formatter`** ("Image wrapped within link field") that
wraps each rendered image in a link whose URL comes from a **Link field** on the same entity, paired
by delta. Extends core `ImageFormatter`. No admin page (`configure: null`), no permission, no Drush,
no config schema. Configured on the entity's **Manage display**. Requires `image` + `link`.

- **Use the formatter, its settings, delta pairing, integrations, config location** →
  [configure/formatter.md](configure/formatter.md)
- **Extend the plugin class / inject services (create() pattern)** →
  [extend/subclass.md](extend/subclass.md)

Key facts:
- Formatter id `image_link_formatter`, label "Image wrapped within link field", for `image` fields.
- The Link field to wrap with is chosen in the formatter's **"Link image to"** setting
  (`settings.image_link` = the link field's machine name).
- Stored on `core.entity_view_display.<entity>.<bundle>.<mode>` →
  `content.<image_field>.type: image_link_formatter` + `...settings.image_link: <link_field>`.
- Submodule **responsive_image_link_formatter** does the same for the Responsive Image formatter.
