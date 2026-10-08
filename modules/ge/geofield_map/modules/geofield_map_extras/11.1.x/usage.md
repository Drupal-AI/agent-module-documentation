Geofield Map Extras is a submodule of Geofield Map that adds two cheaper, lighter Google Map field formatters for geofield points: a static-image map and an iframe-embedded map.

---

Geofield Map Extras ships inside the Geofield Map project and depends on the main `geofield_map` module; it is not enabled by default. It adds two extra field formatters for the `geofield` field type, both supporting only Points (not geometries such as polylines or polygons). The **Geofield Google Map (static)** formatter (`geofield_static_google_map`) renders the location as a single static image via the Google Maps Static API — no controls, zoom or pan — with configurable width, height, scale, zoom, langcode, map type, and marker color/size; static maps are significantly cheaper than dynamic maps. The **Geofield Google Map (embed)** formatter (`geofield_embed_google_map`) renders the map inside an `<iframe>` via the Google Maps Embed API with just width and height settings and requires no JavaScript, and its basic "places" mode is even free. Both reuse the Google Maps API key configured in the main module's settings. The submodule also registers two theme hooks (`geofield_static_google_map`, `geofield_embed_google_map`) with matching Twig templates, and provides config schema for the two formatters' settings.

---

- Display a content location as a lightweight static Google Map image instead of a full interactive map.
- Cut Google Maps billing by using the cheaper Static Maps API for simple location displays.
- Show a map on high-traffic or listing pages where an interactive map would be too heavy.
- Render a location map with a custom marker color and size on a static image.
- Choose the static map type (roadmap, satellite, etc.), zoom level, and pixel dimensions.
- Set the static map image scale (e.g. 2x for retina displays).
- Localize the static map labels via a two-letter langcode setting.
- Embed a Google Map in an `<iframe>` with no JavaScript required on the page.
- Use the free "places" mode of the Google Maps Embed API for basic map displays.
- Size the embedded iframe map by width and height.
- Provide a fallback map display where dynamic JS maps are undesirable (e.g. emails-style rendering, strict CSP).
- Reuse the main Geofield Map Google Maps API key for these formatters without extra config.
- Add a static location thumbnail to teaser/card view modes of geolocated content.
- Show a simple map for a single Point without loading marker clustering or theming logic.
- Override the static/embed map markup by overriding the module's Twig templates.
