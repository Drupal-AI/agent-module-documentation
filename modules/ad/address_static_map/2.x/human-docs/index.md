# Address Static Map — manual setup guide

**Address Static Map** (`address_static_map`) shows a map image for an
[Address](https://www.drupal.org/project/address) field. It is a **field
formatter**: when you display an entity that has an address, this formatter renders
a **Google Static Maps** picture of that location instead of (or alongside) the
plain text address.

Because it uses a *static* map — a plain image — rather than an embedded
interactive map, the page does not load third-party interactive-map scripts, which
means less visitor tracking. The trade-off is that the map is not clickable or
draggable; it is a snapshot of the location.

To talk to Google, the module needs a **Google Maps API key**. That key is a
credential, so the module reads it through the [Key](https://www.drupal.org/project/key)
module rather than storing it in plain configuration. Google's Static Maps service
is billed beyond a free tier, so keep an eye on usage and restrict the key to your
site's domain (an HTTP referrer restriction). Also remember that anyone who can
see the page can see the mapped location, so only use it for addresses you are
happy to show publicly.

This is a display-only formatter with no central settings page — you configure it
per field on an entity's display. It works on Drupal 8.8, 9, 10, and 11.

This guide is written for a **human** setting the module up through the admin UI.
If you want terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable the
   module, and set up the Google Maps API key.

## How to use it

The module has no central settings page. You turn it on for a specific address
field through the entity's display settings:

1. Make sure you have a **Google Maps API key** stored as a Key entity (see
   [Installation](installation/index.md)).
2. Go to the entity's **Manage display** — for example **Structure → Content types
   → [your type] → Manage display**.
3. Find the **Address** field and, in its **Format** column, choose the Address
   Static Map formatter.
4. Open the formatter settings (the gear icon) to point it at your API key and
   adjust the map options offered there, then save.

When you view content of that type, the address field now renders as a Google
Static Map image of the location.
