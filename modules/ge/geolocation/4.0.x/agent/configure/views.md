# Geolocation Views integration

Geolocation ships Views plugins (`src/Plugin/views/`) for mapping and proximity search.

## CommonMap style
- Style plugin **CommonMap** (`src/Plugin/views/style/CommonMap.php`) renders view results as
  markers on a single map. Add a view of your entities, set Format → "Geolocation CommonMap",
  choose the geolocation field as the source, and pick a map provider + features.
- **Layer** style (`Layer.php`) supports layered map output.

## Proximity ("near me")
Under `src/Plugin/views/field|filter|sort|argument`:
- **Proximity field** — computed distance from a center point, displayable per row.
- **Proximity filter** — restrict results to within a radius of a location.
- **Proximity sort** — order results by distance.
- **Proximity argument** — pass a center/radius as a contextual filter (e.g. from the URL or
  the visitor's location) for radius search pages.

## Typical recipe
1. Create a View of the content type holding the geolocation field.
2. Add the proximity **filter** (or argument) to limit by radius and the proximity **sort** to
   order nearest-first.
3. Set Format to CommonMap to show the results as map markers, or use a normal list with a
   proximity field column.

Center strategies come from `MapCenter` plugins (e.g. fit markers, fixed point, client
location); marker/cluster behavior from `MapFeature` plugins.
