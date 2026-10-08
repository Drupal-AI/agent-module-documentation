<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Mapkit plugin types

Mapkit is a framework; enable a provider module to get a usable map.

| Plugin type | Manager service | Base namespace |
|---|---|---|
| Map provider | `plugin.manager.mapkit.map_provider` | `Plugin/Mapkit/MapProvider` |
| Marker | `plugin.manager.mapkit.marker` | `Plugin/Mapkit/Marker` |
| Location resolver | `plugin.manager.mapkit.location_resolver` | `Plugin/Mapkit/LocationResolver` |
| Location input | `plugin.manager.mapkit.location_input` | `Plugin/Mapkit/LocationInput` |
| Geo parser (strategy) | `strategy.manager.mapkit.geo_parser` | discovery id `mapkit.geo_parser` |
| Autocomplete (strategy) | `strategy.manager.mapkit.autocomplete` | discovery id `mapkit.autocomplete` |

- Annotations: `@MapkitMapProvider`, `@MapkitMarker`, `@MapkitLocationResolver`, `@MapkitLocationInput`.
- A map provider may declare a `config_route` (route_name + route_parameters); the provider list page renders a **Configure** link for it (see `MapProviderController::providerList`).
- Geo parsers implement `FieldGeoParserInterface` / `ViewFieldGeoParserInterface`; `mapkit_field_formatter_info_alter()` adds every field type a parser supports to the `mapkit_map` formatter's `field_types`.
- Views: `MapkitLocationStyle`/`Row`, `MapkitDistanceField`, `MapkitLocationFilter`, `MapkitLocationArgument`, and `SearchApiProximityTrait` + `LocationDataType` for Search API proximity.
