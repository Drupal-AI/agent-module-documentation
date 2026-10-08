<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Simple Icons (simple_icons) — agent index

**Provides a `simple_icons_icon` field (type/widget/formatter) and a Twig function to embed Simple Icons brand icons.**

- **Version:** 2.0.x
- **Core:** ^8 || ^9 || ^10 || ^11
- **Depends on:** field
- **Field type:** `simple_icons_icon` (string ≤255) with widget + formatter `SimpleIconsIcon`
- **Services:** `simple_icons.twig.extension` (`SimpleIconsTwigExtension`), `simple_icons.icon_markup` (`IconMarkup`)
- **No routes/permissions of its own**

**Security:** Pure field-types/display module; no HTTP surface, routes, permissions or anonymous endpoints. Icons render as SVG/markup through the formatter and Twig extension.

See [extend/twig.md](extend/twig.md)
