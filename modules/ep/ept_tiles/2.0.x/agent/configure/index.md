<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configuring EPT Tiles

## Enable

```
composer require drupal/ept_tiles
drush en ept_tiles -y
```

Pulls in `ept_core` and `paragraphs`; `ept_core` in turn expects the **Media** module with a
Media type using the **Image** source (create one at Structure » Media types before install if
none exists, or installation errors).

The module has **no settings form of its own** (`configure` is null). Family-wide defaults —
Primary/Secondary colours and Mobile/Tablet/Desktop breakpoints — live on ept_core at
*Administration » Configuration » Content authoring » Extra Paragraph Types (EPT) settings*
(`ept_core.settings`) and apply to every EPT type.

## Where the type appears

After enabling, add an **EPT Tiles** paragraph anywhere a Paragraphs (entity reference
revisions) field accepts it — a content type's paragraph field, or a Layout Builder region if
paragraphs are exposed there. Inside it you add one or more **EPT Tiles Item** children.

## Per-paragraph options (the `ept_settings_tiles` widget)

On the container paragraph's edit form:

- **Styles** — radio: One / Two / Three / Four columns (default Three). Selects which CSS
  library (`ept_tiles/one_column` … `four_columns`) is attached and adds an
  `ept-tiles-<style>` class.
- **Links** (details, open):
  - *Open links in a new tab* — adds `target="_blank"` to clickable tiles.
  - *Add "nofollow"* — adds `rel="nofollow"` to tile links.
- **Design options** (inherited from ept_core) — CSS box margins/padding/borders, border
  colour/style/radius, background colour, background Media image with position/size/overlay/
  parallax, edge-to-edge, container max width.

## Theming

Templates ship in `templates/` and are registered by the module; override
`paragraph--ept-tiles--default.html.twig` and `paragraph--ept-tiles-item--default.html.twig`
in your theme to change markup. Per-column layout is plain CSS in the module's `css/` files.
If the Field Layout module is on, disable its Layout Builder for the paragraph display at
`/admin/structure/paragraphs_type/ept_tiles/display/default`.
