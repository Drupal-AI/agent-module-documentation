# Configuration

Configuration comes in two parts: a one-time module setting for your GeoNames
account, and then per-field configuration through the standard Field UI.

## Step 1 — connect to GeoNames

1. Create a free GeoNames account at
   [geonames.org/login](https://www.geonames.org/login) and enable it for
   web-service (API) access. This gives you limitless free API access to the
   location database.
2. Log in to Drupal as an administrator and go to **Configuration → Location
   Selector → Settings**, or navigate directly to
   `/admin/config/location_selector/settings`.
3. Enter your **GeoNames username** and save.

The username is what the module uses to authenticate its lookups against the
GeoNames API. It is not a secret password, but keep the connection over HTTPS.

## Step 2 — add and configure the field

Add a **Location Selector** field to any content type (or other fieldable entity)
from its **Manage fields** tab, then tune it:

### Widget settings (Manage form display)

- **Basic parent location** — the top of the selectable tree. Choose the whole
  world, or narrow it to a single continent or country so editors only pick from
  the region that matters.
- **Level limitation** — how many children levels the cascading select lists
  display.
- **Force deepest level** — require editors to select all the way down to the
  deepest available level, rather than stopping at a broad region.
- **Save only the last selected element** — store just the final selection instead
  of the whole parent chain.

### Display settings (Manage display)

- Choose how selected locations are rendered, and optionally **link each location
  to a custom View** — point the formatter at a View that already includes the
  Location Selector field as a filter, so a location renders as a link to "all
  content here."

## Using it in Views

To let visitors filter content by location, add the Location Selector field in a
View's **filter** section, set the field's display option, and make the filter
**exposed**. Location labels appear in the current user's language.
