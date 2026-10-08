# Facebook Pixel — manual setup guide

**Facebook Pixel** (`facebook_pixel`) adds the Meta / Facebook tracking pixel to
your Drupal site without you ever pasting the snippet into a template. Enter your
pixel id once, decide which pages and which user roles should be tracked, and the
module injects the pixel and fires standard events for you. It is the clean,
config‑driven way to wire up Facebook/Meta conversion tracking, with privacy
opt‑outs built in.

Out of the box it fires the pixel's **PageView** on tracked pages, a **ViewContent**
event on full node pages (with the content name, type and id), and a
**CompleteRegistration** event when a user registers. Any module can push additional
events — a **Lead**, **Contact**, **Subscribe**, or a custom conversion — through a
simple service, and an Ajax command lets a controller fire an event from an Ajax
response. The bundled **Facebook Pixel Commerce** submodule adds the e‑commerce
events (AddToCart, InitiateCheckout, Purchase, product ViewContent) for Drupal
Commerce sites.

Privacy is treated seriously: you can honour the browser's Do‑Not‑Track header,
respect a global `fb-disable` opt‑out (with a ready‑made `fbOptout()` JavaScript
function), delay tracking until EU Cookie Compliance consent is given, and drop the
`<noscript>` fallback image so no request is made before consent. Page‑ and
role‑based visibility rules let you, for example, track only anonymous visitors, or
only a handful of landing pages, or exclude your logged‑in editors.

Everything lives in one configuration object and one settings form at *Configuration →
Web services → Facebook Pixel*. The module supports Drupal 10 and 11, has no
third‑party library requirements, and includes a migration to carry a pixel id over
from a Drupal 7 site.

This guide is written for a **human** setting the pixel up through the admin UI. If
you want the terse, token‑cheap reference for an AI coding agent — every config key,
the event service, the alter hook and the Ajax command — read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer, enable
   it, and optionally enable the Commerce submodule.
2. [Configuration](configuration/index.md) — the settings form, field by field: the
   pixel id, page and role visibility, and the four privacy options.

## Where it lives in the admin menu

The settings form is at **Configuration → Web services → Facebook Pixel**
(`/admin/config/facebook_pixel`). Access is gated by the **Configure facebook_pixel**
permission that the module provides.

## How to use it

1. Install and enable the module (see [Installation](installation/index.md)).
2. Go to **Configuration → Web services → Facebook Pixel** and enter your **Facebook
   pixel id**. (Leaving it empty disables tracking entirely.)
3. Set the **page** and **role** visibility rules and choose the **privacy** options
   appropriate for your jurisdiction (see [Configuration](configuration/index.md)).
4. Save. The pixel now loads on tracked pages and fires PageView, plus ViewContent on
   node pages and CompleteRegistration on new registrations, automatically.
5. To track custom conversions, push events from your own code via the
   `facebook_pixel.facebook_event` service, or add the **Facebook Pixel Commerce**
   submodule for e‑commerce events. Those APIs are documented in the
   [`agent/`](../agent/start.md) reference.
