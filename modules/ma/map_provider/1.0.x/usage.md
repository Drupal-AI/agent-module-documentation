<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Map Provider manages map tile providers as plugins and supplies a render element that draws a map with Leaflet, so a site can switch base maps — OpenStreetMap, a national mapping agency, a commercial tile service — without every mapping module hard-coding its own.

---

Any module that renders a map needs a tile source, and the usual outcome is that each of them ships its own provider list and its own configuration, so a site ends up declaring the same API key three times. This module centralises that: providers are plugins discovered through `YamlMapProviderManager` (with `YamlMapProviderManagerInterface` and `src/Annotation`), and — the distinctive part — they can be declared in **YAML** rather than PHP, with `map_provider.map.provider.yml` shipping the module's own definitions. Adding a tile provider is therefore a config-style file, not a class. `src/Element` supplies the render element and `js/map.js` with `map_provider.libraries.yml` render it via Leaflet. There are no routes, permissions or configuration forms; the audience is developers, as the description says. Its core range is a wide `^8 || ^9 || ^10 || ^11`, and the description's reference to "the Drupal 8 Plugin API" dates it without meaning it is unmaintained. Note that tile providers have usage terms — OpenStreetMap's tile servers in particular are not intended for heavy production use — so choosing a provider is an operational decision, not only a technical one.

---

- Define map tile providers once for a whole site.
- Switch base maps without changing mapping modules.
- Add a provider by writing a YAML file.
- Render a Leaflet map from a render element.
- Use a national mapping agency's tiles.
- Share one API key across mapping features.
- Offer several base maps to choose from.
- Add a custom internal tile server.
- Give developers a map render element.
- Standardise map appearance across a site.
- Swap providers when licensing changes.
- Render a map in a custom block.
- Support an offline or self-hosted tile source.
- Reduce duplicated map configuration.
- Provide a satellite base layer option.
- Build a mapping module on a shared abstraction.
- Configure tile attribution centrally.
- Prototype with OSM before moving to a paid provider.
