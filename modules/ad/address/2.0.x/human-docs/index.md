# Address — manual setup guide

**Address** (`address`) provides a compound field type for storing, validating, and
displaying international postal addresses. Instead of a pile of loose text fields,
you add a single **Address** field to any entity and it captures a full address —
country, address lines, city, state/province, postal code, and name/organization —
with the right fields, labels, and ordering for whichever country the editor picks.

It solves the problem that every country writes addresses differently. Address is
driven by Google's i18n address dataset (through the `commerceguys/addressing` PHP
library), so a US address shows **State** and **ZIP code** while a UK address shows
**County** and **Postcode**, each in its own correct order — and postal codes are
validated against the selected country's pattern. It is the modern successor to the
old Address Field module and the foundation for addresses in Drupal Commerce.

Enabling the module doesn't add anything visible on its own — it makes new field
types available. You then add an **Address** field to a content type (or user
profile, or any other entity) through the normal Field UI and configure it there:
restrict which countries are allowed, mark individual properties as hidden/optional/
required, and optionally pin the address language. Alongside the main `address`
field type it also provides `address_country` (country code only) and `address_zone`
(a geographic territory set). Address depends on core's **Field** module and requires
the `commerceguys/addressing` PHP library, which Composer installs for you. It has no
submodules and adds no permissions or Drush commands of its own.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module and its PHP library
   with Composer, then enable it.
2. [Configuration](configuration/index.md) — add an Address field, tune its
   per‑field settings, and (optionally) manage country address formats.

## Where it lives in the admin menu

Most of your work happens in the standard **Field UI**: add an *Address* field under
**Structure → (your content type) → Manage fields**, then adjust its display under
**Manage form display** and **Manage display**. The module also registers a global
listing of **Address formats** (the per‑country field layouts) — its
`configure` link, route `entity.address_format.collection`, reached via
**Configuration → Regional and language → Address formats**
(`/admin/config/regional/address-formats`) — where advanced users can review or
override how each country's address is laid out. Day‑to‑day, you rarely need to touch
that page; the built‑in formats already cover every country in the dataset.
