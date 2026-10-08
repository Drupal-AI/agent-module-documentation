# RFC9557 Data Type and Validation — manual setup guide

**RFC9557 Data Type and Validation** (`rfc9557`) is a developer building block for
one very specific thing: the **RFC 9557 extended date-time format**, also known as
IXDTF. That format builds on the familiar RFC 3339 timestamp by adding a time-zone
identifier and optional tags — for example
`2024-01-01T00:00:00+01:00[Europe/Paris]`. This module gives other modules and
custom code the primitives to *produce* and *consume* those values safely.

It is a toolkit, not a feature you switch on for editors. There is no page, no
block, and no settings form. What it provides is:

- A **TypedData type** for RFC 9557 values, so fields and config can be typed
  against the format.
- A **Validator** with two modes — `MODE_STRICT`, which rejects any offset that
  mismatches its time zone (flagged as critical), and `MODE_NORMAL`, which
  requires the implementing code to resolve the mismatch.
- A **Twig filter** for outputting internationalised dates via PHP's
  `IntlDateFormatter` (this filter needs the **Intl** PHP extension installed).
- **Date model classes** for separating and manipulating the parts of a date, an
  **enum of ICU CLDR calendars**, and a helper for building the locale string PHP
  expects.

The most likely reason you are installing this is that another module depends on
it — for example the [Xdate](https://www.drupal.org/project/xdate) extensible date
field, which uses RFC9557 to support all the RFC 9557 date parts.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

This module has **no configuration page** — it is a code-facing set of data types,
validators, and helpers. There is nothing to click after enabling it.

## How to use it

RFC9557 is meant to be called from code. The project's automated tests are the
canonical examples: they demonstrate the model and utility classes, the Validator
(in both strict and normal modes), the TypedData type, and the Twig filter. If you
are building a module that stores or checks RFC 9557 date-time values, add
`rfc9557` as a dependency and use its TypedData type and validator rather than
re-implementing the format. If you only need to *display* such values, the Twig
filter formats them through `IntlDateFormatter` — just make sure the Intl PHP
extension is enabled on your server.
