<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Geofield integration

No admin page. You configure geocoding on the Geofield itself via **geocoder_field**'s
third-party settings (Field UI → your Geofield → Edit) — see the `geocoder_field` submodule's
`configure/field-geocoding.md`. This module just supplies the Geofield-aware plugins.

## Plugins it provides (all of geocoder's existing plugin types)
| Type | Plugins | Purpose |
|---|---|---|
| Preprocessor | `Geofield` (`Plugin/Geocoder/Preprocessor/Geofield`) | Read/normalize a Geofield value as a geocode source. |
| GeocoderField | `GeofieldField` (`Plugin/Geocoder/Field/GeofieldField`) | Lets a Geofield be selected as geocode source/target. |
| Dumper | `Geometry`, `Geohash` (`Plugin/Geocoder/Dumper/*`) | Output geometry (WKT-compatible) / a geohash into the target. |
| Provider | `GeoJsonFile`, `GPXFile`, `KMLFile` (`Plugin/Geocoder/Provider/*`) | Geocode an uploaded spatial file into geometry. |

The file providers extend `Geocoder/Provider/AbstractGeometryProvider`
(`GeometryProviderInterface`), which reads the managed-file path via `geoPHP`.

## Field formatters
`GeoPhpGeocodeFormatter`, `GeoJsonFileGeocodeFormatter`, `KmlFileGeocodeFormatter`,
`GpxFileGeocodeFormatter`, `ReverseGeocodeGeofieldFormatter`
(`Plugin/Field/FieldFormatter/*`) — render or reverse-geocode geofield/file values at display
time.

## Typical setups
- **Address → Geofield:** on the Geofield, method `geocode`, source = address text field,
  dumper = `Geometry`. Saving writes WKT geometry into the Geofield.
- **Geofield → Address:** on an address field, method `reverse_geocode`, source = the Geofield.
- **File → Geofield:** use a `GeoJsonFile`/`GPXFile`/`KMLFile` provider to import geometry from
  an uploaded file into the Geofield.
