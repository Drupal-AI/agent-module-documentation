<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Paragraphs Collection adds reusable behavior plugins, styles and grid layouts to the Paragraphs module — and describes itself, in its own module info, as a collection of **EXPERIMENTS**.

---

Install it with Composer (`composer require drupal/paragraphs_collection`) and enable it with `drush en paragraphs_collection`; it requires **Paragraphs** plus core **Image** and **Link**, and targets Drupal `^10.2 || ^11`. It does not add its own settings page — instead each behavior is switched on per paragraph type at `/admin/structure/paragraphs_type/<type>` under "Behavior plugins". The module ships four behaviors: **Style** (apply a pre-defined visual style — CSS classes, attributes, libraries and optional Twig template — to a paragraph), **Grid layout** (arrange a paragraph's referenced children into columns), **Lock editing** (prevent editing of a paragraph unless the user has the `administer lockable paragraph` permission), and **Visibility per language** (show or hide a paragraph based on the interface language). Styles, style groups and grid layouts are discovered from YAML files (`*.paragraphs.style.yml`, `*.paragraphs.style_group.yml`, `*.paragraphs.grid_layouts.yml`) that **any module or theme** can provide, so you extend the palette without code. Two read-only reports at `/admin/reports/paragraphs_collection/styles` and `/admin/reports/paragraphs_collection/layouts` (behind `administer paragraphs types`) list what is available; the styles report doubles as a form to globally enable/disable styles. Enabling the bundled **Demo** submodule (`paragraphs_collection_demo`) is the quickest way to see it working — it installs example paragraph types and content and adds Accordion, Anchor, Background-image and Slider (Slick) behaviors, pulling in `slick`, `block_field` and `jquery_ui_accordion`. Heed the README: this is an alpha with no guaranteed upgrade path before a beta, and behavior settings are stored on the paragraph entities, so treat it as experimental.

---

- Apply a pre-defined visual style (CSS classes/libraries) to a paragraph.
- Restrict which style groups a paragraph type may use.
- Gate "advanced" styles behind a per-style permission.
- Arrange a paragraph's child items into a grid layout.
- Offer editors a chosen subset of grid layouts per paragraph type.
- Lock a paragraph so only privileged users can edit it.
- Show or hide a paragraph depending on the interface language.
- Add an accordion effect to a paragraph's field (demo submodule).
- Add a jump-to anchor id to a paragraph (demo submodule).
- Use an image field as a paragraph background (demo submodule).
- Turn a multi-value field into a Slick slider (demo submodule).
- Define custom styles in a module or theme via YAML.
- Add reusable grid layouts via YAML discovery.
- Review every available style and where it is used.
- Review every available grid layout and where it is used.
- Globally enable or disable discovered styles from one form.
- Install example paragraph types and demo content quickly.
- Attach a style's Twig template suggestion to a paragraph.
- Study Thunder-style page-building patterns for Paragraphs.
- Prototype paragraph behaviour plugins against a real example.
- Extend paragraph presentation without touching field storage.
