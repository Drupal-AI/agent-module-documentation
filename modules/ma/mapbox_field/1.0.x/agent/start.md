<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# mapbox_field — agent start

Field type + widget + formatters for placing/rendering a marker on a **Mapbox** map. Builds on the base
`mapbox` module (token/style) and core `field`.

- Field type `MapboxField`; widget `MapboxWidget` (interactive point picker); formatters
  `MapboxFormatter`, `MapboxSingle`, `MapboxRawFormatter`.
- Widget/formatters read the token via the `mapbox` service (`accessToken()`) and push settings to
  `drupalSettings`; JS renders into `.mapbox-map` (twig `mapbox-field*.html.twig`).
- Packaging quirk: `info.yml` sets `configure: mapbox_field.config_form` but there is **no routing.yml**
  for that route — dead "Configure" link; real config is the base module's `/admin/config/services/mapbox`.

Security: uses the **publishable/browser-side** Mapbox token (same as base module); **no server-side
HTTP**; no permissions. Nothing sensitive.
