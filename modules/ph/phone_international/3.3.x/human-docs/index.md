# International Phone — manual setup guide

**International Phone** (`phone_international`) adds a proper field type for phone
numbers that works the way people expect on international sites. Editors get a
country selector with flags and dial codes (built on the popular intl‑tel‑input
JavaScript library), type their number, and the module validates and normalises it
to the standard **E.164** format (for example `+351912345678`) using the
libphonenumber library. On the page, valid numbers render as a clickable `tel:`
link.

You add it like any other field: create a field of type *International Phone* on a
content type, user, or other entity, and choose how the country list behaves —
which country is preselected, whether to auto‑detect the visitor's country by
geolocation, which countries are pinned to the top, and which countries to allow or
hide. Numbers are reformatted to E.164 when the entity is saved, so your stored
data stays consistent no matter how editors type it.

The module also ships a reusable form element you can drop into custom forms, a
validation service you can call from code, and a Feeds target for imports. It
requires the PHP library `giggsey/libphonenumber-for-php`, which Composer installs
for you.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable the
   module, and optionally download the JavaScript library for local (non‑CDN) use.
2. [Configuration](configuration/index.md) — the global CDN setting, plus the
   per‑field widget settings that control the country list, field by field.

## How to use it

1. Enable the module (see [Installation](installation/index.md)).
2. On the entity you want to add a phone number to — say a content type — go to
   **Manage fields**, add a new field, and choose **International Phone** as the
   field type.
3. On **Manage form display**, the field uses the *International Phone* widget
   (the country selector plus number input). Click its cog to set the default
   country, geolocation, preferred countries, and any country allow/deny list —
   all covered in [Configuration](configuration/index.md).
4. On **Manage display**, the field uses the *International Phone* formatter, which
   renders valid numbers as a `tel:` link and shows anything invalid as plain text.

## Where it lives in the admin menu

There is one small global settings page at **Configuration → International Phone**
(`/admin/config/phone_international`), which just chooses whether the JavaScript
assets load from a CDN or from a local copy. Everything else is configured on the
field itself.
