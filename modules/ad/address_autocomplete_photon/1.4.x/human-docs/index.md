# Address Autocomplete (with Photon API) — manual setup guide

**Address Autocomplete (with Photon API)** (`address_autocomplete_photon`) adds
type-ahead address suggestions to the **Address** module's field, backed by
**Photon** — an open-source geocoder built on OpenStreetMap data. As a person
types an address, Photon returns matching suggestions and the module fills the
address fields from the one they pick.

The appeal of Photon over commercial services (like Google Places) is that it is
**open-source and self-hostable**. You can run your own Photon instance so that the
partial addresses your users type never leave your own infrastructure, and — unlike
most paid providers — a public Photon endpoint can be used **without an API key**.

It depends on Drupal's **Address** module and ships an optional **geofield
submodule** (`address_autocomplete_photon_geofield`) for storing coordinates
alongside the address.

**One privacy point matters:** if you point the module at a *public* Photon
instance, the addresses users type are sent to that third party. For privacy and
reliability, prefer self-hosting Photon; and if the endpoint you use happens to
require a key, store that key as a secret rather than committing it. This is
covered in [Configuration](configuration/index.md).

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer,
   enable it, and (optionally) the geofield submodule.
2. [Configuration](configuration/index.md) — set the Photon endpoint and switch an
   Address field to the autocomplete widget.

## Where it lives in the admin menu

The module's settings form is at the `address_autocomplete_photon.configure` route
under **Configuration**. After configuring the endpoint, you switch an Address
field to the autocomplete widget under **Structure → Content types → [type] →
Manage form display**.
