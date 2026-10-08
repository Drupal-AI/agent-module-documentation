# Smart Content Paragraphs — manual setup guide

**Smart Content Paragraphs** (`smart_content_paragraphs`) brings [Smart
Content](../../smart_content/3.1.x/human-docs/index.md) personalization to
**Paragraphs**. Editors build "smart" component paragraphs that hold several
variation children, each gated by Smart Content conditions — so a single page
component can show a different variation to a different visitor segment while
falling back to a default for everyone else.

For example, a *"Spanish on the Go"* variation might target visitors on a mobile
device whose browser language is Spanish, while a *"Desktop Mac"* variation targets
people on a Mac desktop — and any visitor who matches neither sees the default. The
conditions can key off device and operating system, geolocation region, browser
geolocation (latitude/longitude), cookies, a referenced node/page, or plain
textfield / number / select values, and they can be combined with AND/OR grouping.
At runtime the visitor's browser posts the collected condition data to a reaction
endpoint, which returns which variation(s) to display — so it works for anonymous
visitors too.

The module depends on **Smart Content**, **Paragraphs**, **Paragraphs Library** and
**Geocoder**. Region-based conditions are geocoded on the server using the Google
Maps geocoder (so you'll need a Google Maps API key configured on the geocoder
provider), and the resulting region bounds are stored in a custom database table.
A set of sub-submodules — `pce_device`, `pce_geolocation`, `pce_geobrowser`,
`pce_node`, `pce_cookie` — supply the individual condition types.

This guide is written for a **human** working through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

> **A note for reviewers:** the reaction endpoint that resolves variations
> (`POST /personalised_content/reactions/{nid}`) is available to anonymous visitors
> (permission *access content*) and looks up the node by its id without an explicit
> view-access or published check. What it returns is limited to the integer IDs of
> the matching variation paragraphs — it does not render restricted content — but
> if you personalize sensitive components, keep this behaviour in mind. Note also
> that this project is not covered by Drupal's security advisory policy and is
> "minimally maintained."

## Contents

1. [Installation](installation/index.md) — install with Composer, enable the
   module and the condition sub-submodules you need.
2. [Configuration](configuration/index.md) — the geolocation HTTP-header setting,
   building Smart Segments, and adding variations to paragraphs.

## How to use it

You build content types that include a **smart component paragraph**, then add
**variation paragraphs** inside it, each carrying a reference to the condition
segment set that should reveal it. When a visitor loads the page, the front-end
posts their collected values (current page, OS derived from the user agent,
latitude/longitude, and so on) to the reaction endpoint, which evaluates each
variation's conditions and returns the ones that match for display.
