<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# ElevateZoom Plus — agent index

Image zoom (window/lens/inner) for Blazy galleries and Slick/Splide/GridStack carousels, driven by
`elevatezoomplus` optionset config entities and wired entirely through Blazy hooks. Requires Blazy 3.x
and the `elevatezoom-plus` JS library in `/libraries`. Settings UI is in the `elevatezoomplus_ui`
submodule (`configure` on the parent is null).

- **Optionsets (config entity), settings keys, library, how zoom is attached via Blazy hooks, JS
  options / `data-elevatezoomplus`** → [configure/optionsets.md](configure/optionsets.md)
- **Blazy integration hooks it implements and the `elevatezoomplus.manager` service** →
  [api/integration.md](api/integration.md)

Submodule (own docs):
- `elevatezoomplus_ui` (optionset admin UI) → [../../modules/elevatezoomplus_ui/2.0.x/agent/start.md](../../modules/elevatezoomplus_ui/2.0.x/agent/start.md)

Key facts:
- Config entity `elevatezoomplus` → config prefix `elevatezoomplus.optionset.<id>`; ships `default`,
  `inner`, `responsive` (all `status: false`).
- No formatters of its own; appears as a Blazy **lightbox / media switcher** option once a lightbox +
  optionset are picked on a Blazy/Slick/Splide formatter.
- Service `elevatezoomplus.manager` (`ElevateZoomPlusManager`) wraps `blazy.manager`.
