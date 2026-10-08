# Geocoder AJAX Prepopulate — manual setup guide

**Geocoder AJAX Prepopulate** (`geocoder_ajax_prepopulate`) makes geocoded fields
fill in **as the editor types an address**, rather than waiting until the form is
saved. The Geocoder module's normal flow is save‑then‑geocode: you submit the
form, Geocoder runs its provider, and the latitude/longitude or formatted‑address
fields are populated during save. That works, but it hides the result until
afterwards — so an editor who mistyped a street name only finds out when the map
comes back wrong.

This module moves that feedback forward. As the address settles in the field, it
fires an AJAX request that runs the existing Geocoder configuration and drops the
coordinates (or formatted address) into their target fields right there on the
form. The editor can see where the point landed — for example in a Geofield Map
widget — and correct the address, or nudge the coordinates by hand, before saving
anything.

Crucially, it changes **when** geocoding happens, not **how**. It depends
specifically on the **`geocoder_field`** submodule (not on Geocoder as a whole),
and it uses whatever provider, field mapping, and storage you've already
configured in Geocoder. It slots into an existing setup without altering it. The
module ships no routes, permissions, or configuration of its own — it's purely a
behaviour layer over a configuration that already exists. Its client‑side script
debounces the requests, waiting for the field to settle rather than firing on
every keystroke, which is helpful when your geocoding provider is rate‑limited or
billed per request.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable it, and
   confirm your Geocoder setup is in place.

There is **no configuration page** for this module. All the setup lives in
Geocoder itself; configure Geocoder first and this module simply changes the
timing of the geocoding.

## Where it lives in the admin menu

Geocoder AJAX Prepopulate adds no admin page and no settings form. Once enabled,
it acts on the content forms where your Geocoder‑driven geofields already appear.
There is nothing to configure in the admin UI.

## How to use it

1. Set up **Geocoder** and **Geocoder Field** first: choose your geocoding
   provider and configure the field that stores the address to geocode and the
   target field(s) that receive the coordinates or formatted address. (A
   map‑enabled widget such as Geofield Map is a good choice for the target so the
   editor can see and adjust the result.)
2. With this module enabled, open a content form that has that address field.
3. Type or paste an address. After the field settles, an AJAX button/request
   geocodes it and prefills the target fields — right on the form, before save.
4. The editor confirms the point looks right (or fixes the address, or edits the
   coordinates directly) and then saves. No more save‑and‑check cycles.
