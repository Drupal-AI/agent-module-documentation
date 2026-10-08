<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# TOC API — agent index

A **developer framework** that turns an HTML fragment's `h1`–`h6` tags into a hierarchical,
numbered table of contents. It exposes **no content feature by itself** — you call its
services from a custom module (see `toc_api_example`) or install a contrib implementation
(TOC filter, TOC Twig Filter, Footnotes). Presentation is controlled by a `toc_type` config
entity. One permission (`administer table of contents types`); no Drush; no plugin *type*.

- **Call the API programmatically (services + the `Toc` object): parse HTML, render the TOC and rewritten body** →
  [api/services.md](api/services.md)
- **`toc_type` config entity: options, the 5 bundled types, admin UI, drush cget/create** →
  [configure/toc-types.md](configure/toc-types.md)
- **Theme hooks, templates and CSS/JS libraries; the responsive tree+menu; `TocBlockBase`** →
  [theming/templates.md](theming/templates.md)

Key facts:
- Services: `toc_api.manager` (create/cache `Toc` instances), `toc_api.builder` (render nav +
  rewrite body), `toc_api.formatter` (string→id, number→decimal/alpha/roman).
- Config entities live at `toc_api.toc_type.<id>`; UI at `/admin/structure/toc`
  (route `entity.toc_type.collection`). Bundled: `default`, `simple`, `simple_numbered`,
  `full`, `full_numbered`.
- A TOC only renders when the fragment has at least `header_count` (default 2) top-level headers.
