# Configuration

Search API Location has **no settings form of its own**. You configure it entirely
through Search API's admin UI, on the **Fields** page of each index. The work is in
telling Search API to index your geofield as a spatial data type, and then
building the actual proximity search with the Views submodule or a map facet.

## First: check your backend supports spatial search

This is the most common stumbling block. The spatial data types only work if the
search server's backend supports them. **Search API Solr** is the known-good
backend; the **default database backend does not** support spatial search, so a
location search there will simply do nothing. Make sure your index is attached to a
server whose backend supports the `location` / `rpt` data types before you go
further.

## Index a geofield with a spatial data type

1. Your source content needs a **geofield** storing a latitude/longitude value
   (for example a field provided by the Geofield module).
2. Go to **Configuration → Search and metadata → Search API**
   (`/admin/config/search/search-api`) and open your index's **Fields** page.
3. Click **Add fields** and add the geofield property.
4. Set that field's **Type**:
   - **Latitude/longitude** (`location`) — use this for distance filtering and
     sorting via the *Search API Location Views* submodule.
   - **Recursive Prefix Tree** (`rpt`) — use this for map **heatmap facets** via
     the *Facets Map Widget* submodule.
   - You can index the **same geofield twice** under different field names — once as
     `location` and once as `rpt` — if you want both Views distance search and a
     heatmap.
5. **Reindex** the index so the coordinate values are written to the backend.

When indexing, the module converts the geofield's stored geometry to a `lat,lon`
coordinate (using the shape's center point), so points, polygons, and other WKT
values all work.

## Build the search

The data type alone doesn't create a search UI — that comes from the submodules:

- **Search API Location Views** — add a proximity **filter** (for example "within
  10 km"), a contextual **argument**, and/or a distance **sort** to a Search API
  view. You can expose the filter with a distance dropdown (5 / 10 / 25 km). A
  special `-` radius option ignores distance for *filtering* but still computes it
  for *sorting*.
- **Facets Map Widget** — add an interactive Leaflet heatmap facet that clusters
  results on a map. This is only offered when the backend supports the `rpt` type.

## How users enter the "search from here" point

The origin point comes from a **Location Input** plugin, chosen where you place the
proximity filter/facet:

- **Raw** — the user types coordinates as `lat,lon`.
- **Geocode on map** — the user picks a point on a Google map.
- **Geocode address** — the user types a street address that is geocoded to
  coordinates (available when the *Search API Location Geocoder* submodule is
  enabled).

The Location Input settings include the radius options (one per line), whether the
radius is a dropdown or a free text field, and the radius units.

## Distance units

Distance searching is kilometre-based, with kilometres and miles available as
units in the location UI (miles are converted at ×1.60935). Developers can add or
change units — see the [`agent/`](../agent/start.md) references for the relevant
hook.
