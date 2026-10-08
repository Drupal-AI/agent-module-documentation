<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Type Style adds a "Style settings" fieldset (a colour picker and an icon-name text field) to every entity-bundle edit form — content type, custom block type, media type, taxonomy vocabulary, file type, or any type opted in via hook. The chosen colour and icon are stored as third-party settings on the bundle config entity and read back through a Twig function, Views field plugins and entity tokens; the module renders no markup or CSS of its own.

---

The module is a metadata store, not a renderer. When you edit a bundle you set two values — a hex `color` and a free-text `icon` name — and Type Style persists them as third-party settings on the bundle's config entity (`node.type.*.third_party.type_style`, and likewise for block_content, media, taxonomy and file types). Everything downstream is consumption: the `type_style(entity_or_type, id, style, default)` Twig function returns a value for a rendered entity or a loaded bundle; Views gains `type_style`, `type_style_color` and `type_style_icon` fields on every bundle base table, where the colour field uses a `postRender` trick that swaps `data-type-style-color` / `data-type-style-background-color` placeholder attributes for real `style="color: …"` strings (the workaround for Views not letting rewritten text carry inline styles); and tokens `[node:type-style-color]`, `[node:type-style-icon]` and `[node:type-style-*]` expose the same values to any token-aware feature. How a value becomes visible design is left entirely to the site — an icon name typically feeds an icon font, and the global settings form at `/admin/structure/type-style/settings` (permission `administer type style`) only chooses which icon font library — Material, Font Awesome or Ionicons — is attached to pages from a CDN, a convenience you can switch off. All values are sanitised on read to `[a-zA-Z0-9\-_#]` and the colour is validated to a six-digit hex on save, so the stored strings are safe to emit. The `type_style_moderation` submodule applies the same colour/icon idea to Content Moderation / Workbench Moderation workflow states and transitions, and `type_style_example` seeds every content type with a random colour and icon plus a demo view for a quick look.

---

- Associate a brand colour with each content type and read it in Views.
- Give each content type an icon name that drives an icon font.
- Colour-code rows in the admin content listing by bundle.
- Add a coloured swatch to a reference-autocomplete or teaser via Twig.
- Distinguish media types with per-type icons in a media library view.
- Mark taxonomy vocabularies with distinct colours.
- Style custom block types by bundle.
- Style file (media) types by bundle.
- Colour draft-versus-published in a moderation queue (moderation submodule).
- Give workflow states and transitions their own colour/icon (moderation submodule).
- Emit a per-type colour into a Views field using the `data-type-style-color` attribute trick.
- Pull a bundle colour into an email or message via the `[node:type-style-color]` token.
- Render an entity's type icon in a custom template with `type_style(node, 'icon')`.
- Look up a style from a bundle machine name: `type_style('node_type', 'article', 'color')`.
- Add extra style keys (e.g. secondary_color) via `hook_type_style_form_alter()`.
- Extend styling to entity types that lack bundle third-party settings via `hook_type_style_entity_support()`.
- Seed demo colours/icons on all content types with the `type_style_example` submodule.
- Choose Material, Font Awesome or Ionicons as the auto-attached icon font.
- Turn off the CDN icon font when the theme already ships one.
- Build a colour-and-icon legend for a large content model.
- Feed per-type icons to a component/SDC library through Twig.
- Drive conditional SVG rendering off a per-type icon name.
