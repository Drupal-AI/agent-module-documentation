# Geolocation Provider — manual setup guide

**Geolocation Provider** (`geolocation_provider`) supplies a **plugin type for
geolocation services**, so your code can ask for a location without naming which
service answers. Any site that does something with location eventually depends on
a specific provider's API — and that dependency spreads: the provider's response
shape, its identifiers, and its failure modes end up scattered through
controllers, blocks, and preprocess functions. Then the contract changes, the
free tier disappears, a data‑protection review objects to a US provider, or the
site moves behind a CDN that already supplies the answer — and the change touches
everything. A plugin type keeps the provider at one boundary, so swapping it
becomes a configuration change rather than a refactor.

It's deliberately lightweight and **does nothing on its own** — it's
infrastructure for modules that implement or consume providers. This 2.0.x branch
ships an **IGN** (French national geographic institute) provider and a
**Nominatim** provider (OpenStreetMap search by name/address, and reverse lookups
from a point). It depends on core's **Serialization** (`serialization`) module,
and it's intended to sit alongside a Geo‑Map field and a map provider.

Three things belong in any geolocation conversation, and this module's docs make
a point of them:

- **An IP address is personal data** under GDPR, and looking one up sends it to a
  third party — a processing activity that needs a lawful basis and a
  privacy‑notice entry, however routine it feels.
- **IP geolocation is approximate and confidently wrong.** It gives a country
  reliably, a city sometimes, and anything finer rarely — and it's wrong for VPN
  users, mobile networks, and corporate proxies. Gating access or content on it
  produces a support queue.
- **A lookup on the request path is a network call on the request path.** Cache
  the result per session or per IP prefix, or your site's response time becomes
  the provider's.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

There is **no dedicated settings form**. You select a provider on a field's
display, and developers create custom providers in code — described in "How to
use it" below.

## Where it lives in the admin menu

The module adds no central settings page. Instead, you pick which provider to use
on the **display settings of your Geo‑Map field**, where the providers it
registers appear as options.

## How to use it

**To use a provider (site builders).** On the display/settings form of your
Geo‑Map field, set the field type and **select the provider** you want — for
example IGN or Nominatim. That's the whole configuration: which registered
provider answers location lookups for that field.

**To add a provider (developers).** Define a new plugin using the
`GeolocationProvider` plugin type, extending the module's
`GeolocationProviderPluginBase` class. Your consuming code then asks the plugin
manager for a location and stays independent of any single service — so a future
provider swap is a configuration change, not a rewrite. When you do add a lookup,
remember the three cautions above: treat IPs as personal data, don't over‑trust
the precision, and cache results off the request path.
