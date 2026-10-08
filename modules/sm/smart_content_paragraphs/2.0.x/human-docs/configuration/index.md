# Configuration

Setting up Smart Content Paragraphs is a three-part job: configure geolocation (if
you'll use region conditions), define the Smart Segments you want to target, then
add variations to your paragraphs.

## Geolocation HTTP header

If you enabled the geolocation sub-submodule, configure the HTTP header used to
determine a visitor's location at:

```
/admin/config/content/smart_content_paragraphs/pce_geolocation/settings
```

Set the header your hosting/CDN uses to convey the visitor's geolocation, and
save. This is what the region conditions read when deciding which variation a
visitor should see. (Region conditions also geocode their configured areas
server-side via the Google Maps geocoder and store the resulting bounds in a
custom table, so make sure your Geocoder provider has a valid Google Maps API
key.)

## Add a Smart Segment

Smart Segments are the reusable condition sets your variations reference.

1. Go to **Structure → Smart segment** in the administration toolbar. This lists
   every Smart Segment you've created; if there are none yet you'll see the message
   *"There are no Smart Segment entities yet."*
2. Click **Add Smart segment**.
3. Build all the conditions you need inside the segment — device/OS, region,
   browser geolocation, cookie, referenced node, or textfield/number/select — and
   combine them with AND/OR grouping.
4. Click **Save**.

Once saved, a Smart Segment becomes available to use in the conditions section of
any Smart Content Variation Set.

## Build smart component paragraphs

With your segments in place, add a **smart component paragraph** to a content
type's paragraph field, then add **variation paragraphs** inside it. Give each
variation a reference to the Smart Segment (condition set) that should reveal it,
and leave a default variation for visitors who match no segment. At runtime the
front-end evaluates each variation's conditions and shows the matching one(s).
