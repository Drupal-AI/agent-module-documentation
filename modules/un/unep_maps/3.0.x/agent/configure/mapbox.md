<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configuring UNEP Maps (Mapbox token & defaults)

## Settings form — `/admin/config/system/unep_maps` (perm `administer modules`)
`Form/UnepMapsSettingsForm` writes `unep_maps.settings`:
- `token` — Mapbox access token. Required; the Views style validation errors out if it's empty.
- `default_style_url` — default Mapbox style (e.g. `mapbox://styles/mapbox/streets-v11`) used when a display doesn't set its own.

## Token handling / security
The token is passed to the browser via `drupalSettings.unep_map[...].mapboxToken` (Mapbox GL is a client-side library, so a public/client token is expected). Use a URL-restricted, scoped token in your Mapbox account rather than a secret/server token. The render array carries cache tag `config:unep_maps.settings`.

## Disclaimer route
`/unep-maps/carto-tile-disclaimer` (`access content`) returns a fixed UN boundary/naming disclaimer HTML fragment — static, no inputs.
