<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Leaflet Mapbox (leaflet_mapbox) — agent index

Registers **Mapbox** tile layers as map options for the **Leaflet** module via
`hook_leaflet_map_info()`. Depends on `leaflet:leaflet`. Core `^10.3 || ^11 || ^12`.
No JS, no field formatter of its own, no server-side HTTP — it builds a client-side
tile `urlTemplate` with the access token appended and hands it to Leaflet.

Surface is one admin config form; there are no permissions, plugins, drush commands,
or public API beyond the hook.

- **Configure maps** (add/edit Mapbox maps, tokens, API 3 vs 4, migration) →
  [configure/settings.md](configure/settings.md)

Key facts, both non-technical and both decisive:
- **Cost.** Mapbox bills **per map load** above a free tier. Establish the running cost of a
  map on a high-traffic page before launch, not on an invoice.
- **The access token is public by necessity** — the browser uses it — which is exactly why it
  must be **scoped with URL restrictions at Mapbox**. An unrestricted token in page source can
  be used by anyone on the owner's account. Use a public `pk.*` token here, never a secret `sk.*`.
- **Why not the default tiles:** Leaflet's usual default is OpenStreetMap's public tile servers,
  whose usage policy excludes heavy production traffic. Choosing a provider is correct; Mapbox is
  one option among several (compare `map_provider`, which abstracts several providers).
