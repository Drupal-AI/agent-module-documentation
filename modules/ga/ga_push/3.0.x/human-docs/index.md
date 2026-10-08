# Google Analytics Push — manual setup guide

**Google Analytics Push** (`ga_push`) sends events to Google Analytics **from
Drupal**, so things that happen on the server are measurable alongside the
page‑views tracked in the browser. Page‑view analytics answers *where people
went*, not *what happened* — and the events that matter to an organisation are
usually server‑side facts: a form was submitted and passed validation, an order
completed, a file was downloaded, a user registered, a search returned nothing.
Some of those can be inferred badly from a thank‑you URL; others cannot be seen
from the browser at all, because the browser only knows what it sent, not what the
server decided. Pushing events from PHP closes that gap.

The module provides both a configuration UI and an **API other modules can call**.
It supports GA4 (via the Measurement Protocol) and the dataLayer approach, and can
track pageviews, events, ecommerce, enhanced ecommerce, social interactions, and
exceptions — client‑side or server‑side. Other modules build on it, for example
Commerce Google Analytics. Note this documented release is `3.0.0-alpha1`, an
**alpha**, on core `^10.3 || ^11`.

Three things are worth keeping front of mind:

- **Server‑side events bypass the visitor's controls.** There is no browser
  request for an ad blocker or consent manager to withhold, so if a visitor
  declined tracking, *your code* must not send the event — the consent decision
  lives in PHP, not in a script the consent tool can block.
- **Event data is data leaving your site.** An event carrying an order value, an
  email address, or a search term has sent that to Google — and search terms in
  particular are notorious for containing things visitors did not mean to publish.
- **GA4 is events throughout.** It replaced the old category/action/label model
  entirely, so check that the shape the module produces matches what your GA
  property expects, or events will arrive but be unreportable.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.
2. [Configuration](configuration/index.md) — the settings form, tracking IDs, and
   secret handling.

## Where it lives in the admin menu

The settings form is registered as `ga_push.settings` and gated by the **Admin GA
Push** (`admin ga push`) permission. It sits under **Configuration** — look for
the Google Analytics Push settings there.

## How to use it

For no‑code tracking, configure the settings form and let dependent modules (like
Commerce Google Analytics) push events for you. To push your own events from a
custom module, call the services — for example
`\Drupal::service('ga_push.ga4mp')->sendEvent($event_data, 'GA_PUSH_TYPE_EVENT')`
for GA4, or `\Drupal::service('ga_push.datalayer')->pushData(...)` for the
dataLayer — or the `ga_push_add_event()` / `ga_push_add_ecommerce()` /
`ga_push_add_pageview()` / `ga_push_add_social()` helper functions. Always gate
those calls on the visitor's consent.
