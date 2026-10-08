# Google Places — manual setup guide

**Google Places** (`google_places`) fetches data from the Google Places API —
place details, search results, autocomplete, addresses, business metadata and
photos — and makes it available to your Drupal site. It is part of the **AI Tools**
package and depends on the [Key](https://www.drupal.org/project/key) module, which
holds your Google API credentials securely.

The module has two sides. First, it exposes a **service** (`google_places.api`)
that other modules and custom code can call to run place searches, fetch details
for a place ID, and download place photos. Second, when the
[AI](https://www.drupal.org/project/ai) module and a chat provider are installed,
it provides two **AI Automator** types that can take a search field, an address
field, or even unstructured text and use it to fill out address fields or the rich
metadata Google Places offers.

One important compliance note carried over from the module's own documentation:
Google's Terms & Conditions allow you to hold Places data *temporarily* (for
example, for context chaining in AI Automator), but storing it persistently to
display on your website is against those terms. Keep that in mind when you design
how the fetched data is used.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module and the Key dependency.
2. [Configuration](configuration/index.md) — add your Google Places API key via the
   Key module.

## Where it lives in the admin menu

The settings form is at **Configuration → Google Places → Settings**
(`/admin/config/google_places/settings`), where you register the API key the
service and AI Automators use.

## How to use it

- **As an AI Automator type:** install the AI module and a chat provider, add your
  API key on the settings form, then add an address field to an entity and enable
  the AI Automator on it — a text/search field can drive the address field, or
  unstructured text can be resolved to a real address.
- **From code:** call the `google_places.api` service — for example
  `\Drupal::service('google_places.api')->placesSearchApi('Bars near Brandenburger Tor', 'places.id')`
  to search, `->placesDetailsApi($id, '*')` for details, and `->getPhoto(...)` for
  a photo.
