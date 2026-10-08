# Favicon & touch-icon tags

Adds a "Favicons" MetatagTag group of `<link rel="…">` tags:

- `icon` — the standard favicon (supports sizes).
- `apple-touch-icon` / `apple-touch-icon-precomposed` — iOS home-screen icons across
  resolutions (57×57 … 180×180, incl. iPad/iPhone variants).
- `mask-icon` — Safari pinned-tab SVG mask (with a color).

Set as global Metatag defaults so every page advertises the icon set; token-enabled so
URLs can point at managed files/theme paths. Schema:
`config/schema/metatag_favicons.metatag_tag.schema.yml`.
