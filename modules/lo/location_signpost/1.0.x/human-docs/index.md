# Location Signpost — manual setup guide

**Location Signpost** (`location_signpost`) helps a visitor find services for
**their** local area by entering an address or postcode. It adds a **block** and a
**paragraph type** that present a lookup: the visitor types a postcode or address,
the module works out which area they're in, and then shows a set of area-specific
"signpost" links pointing them to the right local services. It was built with
LocalGov Drupal (council sites) in mind, but it has no LocalGov dependency and
works on any Drupal 10 or 11 site.

Behind the scenes it uses two lookup services. **Address autocomplete** comes from
the **Ordnance Survey (OS) Places API**, so as a visitor types, matching addresses
appear. **Area identification** uses **postcodes.io** (free, no key required) to
look up the ONS **MSOA** code for a postcode; that code is then matched against the
MSOA codes you've configured for each of your areas, which is how the module knows
which signpost links to show.

There are important data-handling points here. The module **sends the visitor's
address or postcode to external APIs** (OS Places and postcodes.io) — that is
location data, i.e. personal data — so disclose those third-party lookups in your
privacy policy. The **OS Places API requires an API key**, which must be treated as
a secret: store it via the **Key** module (strongly recommended) or an environment
variable rather than in exported configuration, and keep the calls over HTTPS.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable it, and
   set up the Key module.
2. [Configuration](configuration/index.md) — store the OS Places API key, define
   your areas with their MSOA codes and signpost links, and place the block.

## How to use it

Once configured, place the **Location Signpost block** in a region (or add the
**paragraph type** to a piece of content) on the page where you want visitors to
find local services. A visitor enters their postcode or address, the module
identifies their area, and the matching signpost links are shown.
