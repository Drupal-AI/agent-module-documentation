<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Meta Pixel provides Meta (Facebook) Pixel and Conversions API (CAPI) tracking, with unified browser-side and server-side event collection and automatic deduplication.

---

Meta Pixel integrates Meta (Facebook) advertising tracking — both the browser-side Pixel and the
server-side Conversions API (CAPI) — with unified event collection and automatic deduplication so an
event isn't counted twice across the two channels. It ships a `meta_pixel_commerce` submodule for
e-commerce events (purchases, add-to-cart). It provides its own permissions.

Use it for Meta ads measurement/attribution. This is a tracking integration with significant
privacy/consent implications: the Pixel and CAPI send user/event data to Meta (CAPI can send
server-side data including identifiers), so you must obtain appropriate consent, integrate with your
cookie-consent mechanism, disclose the tracking, and handle the CAPI access token as a secret. Configure
what events are sent and to which pixel/dataset. It has no content-access role, but its data-sharing
footprint is the main consideration.

---

- Track with Meta (Facebook) Pixel.
- Send events via the Conversions API (CAPI).
- Unify browser and server events.
- Deduplicate events automatically.
- Track e-commerce with meta_pixel_commerce.
- Measure Meta ad conversions.
- Obtain consent for tracking.
- Integrate cookie-consent.
- Disclose the tracking.
- Store the CAPI access token as a secret.
- Send purchase/add-to-cart events.
- Configure the pixel/dataset.
- Provide its own permissions.
- Handle privacy implications.
- Send server-side identifiers via CAPI.
- Attribute conversions to ads.
- Mind data sharing with Meta.
- Control which events are sent.
- Support ad measurement.
- Manage consent and disclosure.
