# International Phone — manual setup guide

**International Phone** (`phone_international`) gives you a proper field type for
collecting and validating telephone numbers from anywhere in the world. Instead
of a plain text box, editors get a friendly widget — built on the popular
**intl-tel-input** JavaScript library — with a country flag selector, dial codes,
and an example-number placeholder that updates as they pick a country. Behind the
scenes each number is parsed and normalized to the standard **E.164** format
(for example `+351912345678`) using Google's `libphonenumber` library, so every
number you store is clean, consistent, and internationally valid.

The problem it solves is the messiness of free-text phone numbers: people type
numbers with spaces, dashes, missing country codes, or invalid digits. This
module validates the input against the selected country's rules at save time and
stores a single canonical form, which is invaluable if you later push those
numbers to a CRM, an SMS gateway, or a verification workflow. On display, valid
numbers can be rendered as clickable `tel:` links.

The module works as soon as you add a field of the new type, but it does have two
setup prerequisites worth knowing up front: it requires the PHP library
`giggsey/libphonenumber-for-php` (installed automatically by Composer) and the
**intl-tel-input** JavaScript library (v25.3 or newer), which you either serve
from a CDN or install locally into your `libraries/` folder. A single global
setting on the module's own settings page controls that CDN-vs-local choice, and
a bundled Drush command can download the JS library for you.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable the
   module, and get the intl-tel-input JavaScript library in place.
2. [Configuration](configuration/index.md) — the global CDN setting plus the
   per-field widget and formatter options.

## Where it lives in the admin menu

The module's own settings form sits at **Configuration → International Phone**
(`/admin/config/phone_international`), where you choose whether to load the
JavaScript assets from a CDN or from a local copy. Everything else happens on
your fields: you add a **phone_international** field to a content type (or any
fieldable entity) at **Structure → Content types → *(type)* → Manage fields**,
then tune its widget on **Manage form display** and its output on **Manage
display**.

## How to use it

Add a field of type **International Phone** to, say, a Contact or Profile content
type. On the field's form display the country-aware widget lets editors pick a
flag and dial code and type the number; on save the value is validated and stored
as E.164. On the display side, the **International phone** formatter renders valid
numbers as clickable `tel:` links (invalid values fall back to plain text), while
the **Plain** formatter shows the number as text. The module also exposes a
reusable `phone_international` form element and a Feeds target for imports, and a
`phone_international.validate` service you can call from custom code to validate
or reformat a number.
