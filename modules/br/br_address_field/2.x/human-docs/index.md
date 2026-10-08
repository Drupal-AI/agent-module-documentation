# Brazilian Address Field — manual setup guide

**Brazilian Address Field** (`br_address_field`) provides an address field built
for Brazilian addresses, complete with postal-code (CEP) lookup. Brazilian
addresses follow a specific structure, and Brazil's postal-code system can
auto-fill much of an address from the CEP alone. This field does exactly that: an
editor types the CEP and the module fills in the matching address parts.

The lookup works by making an outbound request to an external CEP service (such
as ViaCEP) each time a code is entered. Two things follow from that. First, the
lookup depends on that external service being reachable, so the field needs to
handle the service being slow or unavailable. Second, the request should go over
TLS with certificate verification, since address data is personal data. Treat the
addresses you collect accordingly.

There is nothing to configure — the field has no settings page. You add it to a
content type through the Field UI and it works. It supports a wide range of core
versions (`^8 || ^9 || ^10 || ^11`).

This guide is written for a **human** adding the field through the admin UI. If
you want a terse, token-cheap reference for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — installing with Composer and enabling
   the module.

## Where it lives in the admin menu

Brazilian Address Field has no settings page of its own. You use it from the
**Field UI**: edit a content type (or any fieldable entity) under **Structure**,
add a field, and pick the Brazilian address field type. It then appears on that
entity's add/edit form.

## How to use it

Add the field to a content type through the Field UI, then edit a piece of
content. Enter the CEP (postal code) and the module queries the external CEP
service and auto-fills the address parts for you. This saves editors from typing
a full Brazilian address by hand and keeps the address well-structured. Because
each lookup is a live call to an outside service, expect occasional lookups to
fail if that service is down, and remember the addresses you store are personal
data to be handled with care.
