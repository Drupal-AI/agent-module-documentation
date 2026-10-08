<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Media Power BI — agent index

Adds a media source `media_power_bi` for embedding Microsoft Power BI reports as Media
entities, plus a matching field formatter and a URL validation constraint. No configure route,
no settings form, no permissions of its own. Depends on core `media` + `media_library`.
Persistent state is a **media type** whose `source` is `media_power_bi` (and its `string_long`
source field).

- **Create a Power BI media type / source field, the display formatter (`width`/`height`),
  the Media Library add form, and where it's stored** →
  [configure/media-type-and-display.md](configure/media-type-and-display.md)
- **The iframe render template and `media_power_bi` theme hook** →
  [theming/iframe-template.md](theming/iframe-template.md)

Key fact: source plugin id `media_power_bi`, source field type `string_long`. Valid embed URLs
must have host `app.powerbi.com`, `app.powerbigov.us`, `app.high.powerbigov.us`, or
`app.mil.powerbigov.us` (enforced by the `media_power_bi` constraint). Display formatter id is
also `media_power_bi` (settings `width` default `100%`, `height` default `900px`).
