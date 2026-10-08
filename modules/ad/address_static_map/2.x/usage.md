Address Static Map renders a contrib Address field value as a Google Static Maps image on the entity display.

---

Address Static Map provides one field formatter, "Address Static Map", that you attach to an Address field on a bundle's Manage display. For each address value it builds a Google Static Maps URL (maps.googleapis.com/maps/api/staticmap) centred on the formatted address, with a marker, and outputs it as an `<img>` — so the visitor's browser fetches the picture directly from Google. A site-wide settings form (/admin/config/system/address_static_map) holds the Google credentials: a standard API key plus a URL-signing secret, or a Google Maps Premier client ID plus crypto key. The signing secret and crypto key are stored as Key module entities and used to HMAC-SHA1 sign each URL. Per-display formatter options set the zoom, image size, map style, retina scale, a custom marker icon and extra Static Maps parameters. It is the modern-Address-field successor to addressfield_staticmap and requires the Address and Key modules.

---

- Show a small locator map next to a business or venue address stored in an Address field.
- Add a static map to a "Contact us" or "Find us" page rendered from an office Address field.
- Display a map thumbnail on event nodes for the event's venue address.
- Render a map for each store in a store-locator list built on the Address field.
- Put a map image on a member/agent profile using their public address field.
- Show a property location map on real-estate listings.
- Include a map in a teaser/card view mode where a full interactive JS map would be too heavy.
- Provide a JavaScript-free map that works when scripts are blocked (it is a plain image).
- Include the address map in printable or PDF-exported views (static images print reliably).
- Add a map image to email-friendly or RSS output where interactive maps cannot run.
- Switch map presentation between roadmap, satellite, terrain and hybrid per view mode.
- Offer retina (2x/4x) map images for high-DPI displays via the Scale setting.
- Control zoom per display, from auto framing to a fixed close-up street level.
- Set a custom map size (e.g. 600x300 banner strip vs 400x400 square) per display.
- Brand maps with a custom marker icon hosted on your site.
- Apply Google Static Maps styling or feature parameters via the free-form "additional parameters" field.
- Sign map URLs with a Google URL-signing secret so requests pass Google's signature checks.
- Use a Google Maps Premier (Premium Plan) client ID and crypto key instead of an API key.
- Keep the signing secret and crypto key out of plain config by storing them as Key entities.
- Migrate a Drupal 7 addressfield_staticmap setup to the modern Address field on Drupal 8-11.
- Display maps for multi-value address fields (one image is rendered per address delta).
- Show country/region-level context maps by choosing a lower zoom for coarse addresses.
