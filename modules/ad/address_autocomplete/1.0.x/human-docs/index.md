# Address Autocomplete — manual setup guide

**Address Autocomplete** (`address_autocomplete`) adds a type-ahead lookup to the
**Address** module's field. Instead of filling in street, city, postcode, and the
rest by hand, a person types a few characters, picks the right address from a list
of suggestions, and the fields fill themselves from a source that already has the
address in the correct per-country format.

Typing an address is one of the highest-friction, lowest-accuracy things a form
asks of anyone: it's several fields, the format differs by country, and a person
on a phone will abbreviate the street, misspell it, skip the county, and enter the
postcode in a shape your system doesn't expect. The data then arrives
inconsistent — and a shop finds out when a delivery fails, or a charity finds out
when a mailing bounces. A lookup replaces most of that with one interaction.

It builds on Drupal's **Address** module (a required dependency), which is the
right base because it already handles the country-specific formats the results
have to populate. This release is a **beta** (1.0.0-beta6), so test it before you
rely on it in production.

Three things are worth planning before you turn it on — the lookup provider is a
paid or rate-limited contract, what users type is sent to that provider (a privacy
matter), and the manual entry path must stay open. These are covered in
[Configuration](configuration/index.md).

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — the settings form, the lookup
   provider, and the three things to plan.

## Where it lives in the admin menu

The module's settings form lives under **Configuration** at
`/admin/config/…/address_autocomplete`. After configuring it, you switch an
Address field over to the autocomplete widget under **Structure → Content types →
[type] → Manage form display**.
