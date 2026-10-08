<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Paragraphs Type Help — agent index

A fieldable `paragraphs_type_help` content entity whose text/image is rendered as an extra
field on a Paragraph type's form and view displays, matched by bundle + form/view mode.
Requires `paragraphs`. Managed at `/admin/content/paragraphs-type-help`
(`configure` = `entity.paragraphs_type_help.collection`). No Drush, no plugin types, no config schema.

- **Create/manage help, entity fields, targeting a bundle + form/view mode, enabling the extra field on displays, permissions** →
  [configure/help.md](configure/help.md)
- **Template `paragraphs-type-help.html.twig`, theme suggestions, preprocess variables, CSS library** →
  [theming/templates.md](theming/templates.md)

Key facts:
- Entity fields: `host_bundle` (ref to `paragraphs_type`, required), `label` (auto-generated if empty),
  `host_form_mode` (default `default`), `host_view_mode`, `weight`, `status`, plus Field-UI fields
  `help_text` (formatted text) and `help_image` (image).
- Extra field id per help view mode: `paragraphs_type_help__<view_mode>`, added to every Paragraph
  bundle's form + view display. The `default` form extra field is visible by default; view extra
  fields are opt-in on the Paragraph's *Manage display*.
- Rendering: `hook_paragraph_view` + paragraphs widget alters call
  `ParagraphsTypeHelp::loadPublishedByHostDisplay()`; only published helps for the bundle/mode show,
  with fallback to the `default` mode, ordered by `weight`.
- Permissions (both `restrict access: true`): `administer paragraphs_type_help entity`,
  `manage paragraphs_type_help entity`.
