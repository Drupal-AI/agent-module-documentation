<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Curated Colors example (curated_colors_example) — agent index

Example/demo submodule of **Curated Colors**. Depends on `curated_colors`. Package
`Curated Colors`. Core `^10.3 || ^11 || ^12`. GPL-2.0-or-later. Version 1.1.0. No routes,
permissions, services, hooks or config schema — it is example content plus one SDC.

Parent module: [../../../../1.1.x/agent/start.md](../../../../1.1.x/agent/start.md)

## What it ships (from source)

- **Palette config** `config/install/curated_colors.curated_color_palette.drupal_brand.yml`
  (id `drupal_brand`, label *Drupal Brand*). ~10 solid Drupal brand colors + 6 gradient entries;
  groups `Primary`, `Secondary`, `Tertiary`, `Gradient`. Gradients use the color entry's custom
  CSS `style` (e.g. `background: linear-gradient(...)`) since a hex can't express them. The config
  enforces a dependency on `curated_colors_example`.
- **SDC** `components/colored_card/`:
  - `colored_card.component.yml` — props `title` (required), `body`, and `color`. The `color` prop
    is `type: string` annotated **`x-curated-color-palette: drupal_brand`**, so Curated Colors'
    Canvas shape-matcher renders the swatch picker for it (both field-bound and static). Status
    `experimental`.
  - `colored_card.twig` — applies the color key as a CSS modifier class:
    `colored-card--{{ color|replace({'_': '-'}) }}`. It does **not** emit hex/CSS into markup.
  - `colored_card.css` — one `.colored-card--<key> .colored-card__accent { background: … }` rule
    per palette key; the hex/gradient values live only here (the data model stays the key).

## The pattern it demonstrates

Store the **key** in content → apply it as a **CSS class** → keep real color values in the
**stylesheet**. Re-branding is then a CSS edit, not a content migration. This is the same pattern
described in the parent module's field-type and Canvas docs.

## Enable

```bash
drush en curated_colors_example -y   # pulls in curated_colors
drush cr
```

After enabling, the `drupal_brand` palette appears at `/admin/config/content/curated-colors` and
the `colored_card` component is available to SDC/Canvas.
