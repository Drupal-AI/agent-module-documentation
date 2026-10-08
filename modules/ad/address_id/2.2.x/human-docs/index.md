# Address Indonesia — manual setup guide

**Address Indonesia** (`address_id`) extends the **Address** module with
Indonesia's provinces and cities. The addressing library behind Address doesn't
ship city-level subdivisions for Indonesia — they aren't needed for basic postal
addressing — so an Indonesian address field normally can't offer structured
province and city selects. This module fills that gap.

Once enabled, any Address field set to country **Indonesia** switches to a
three-level subdivision format: a **province** select, and a **city** select nested
under each province. That gives you clean, structured Indonesian address data
instead of free text — useful for Commerce tax and shipping zones, Views filters,
reporting, and reliable imports.

There's nothing to configure. The module is a single event subscriber that reacts
to the Address module's format and subdivision events, and it only touches
addresses with country code **ID** — every other country is left exactly as it was.
The province/city data is built into the module's code. **Enabling it is the entire
setup.**

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

## Where it lives in the admin menu

There is no admin page. It works automatically. To see it, edit any entity with an
**Address** field, set the country to **Indonesia**, and the province and city
selects appear.

## How to use it

1. Make sure you have an **Address** field on a content type (or user, profile,
   Commerce customer profile, etc.).
2. Enable Address Indonesia (see [Installation](installation/index.md)).
3. On an address form, choose country **Indonesia** — the province select appears,
   and choosing a province populates the matching city select. The structured
   values can then drive tax/shipping zones, Views filters, or exports.
