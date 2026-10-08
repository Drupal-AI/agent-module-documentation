# Telephone Validation — manual setup guide

**Telephone Validation** (`telephone_validation`) adds real phone‑number checking
to Drupal's core **Telephone** field (and to any `tel` form element). Core's
Telephone field accepts almost any text; this module checks that what an editor or
visitor typed is actually a valid, dialable number, rejecting typos and fake
numbers before they are saved. It does this with the well‑known
`giggsey/libphonenumber-for-php` library — a PHP port of Google's libphonenumber.

Validation is **opt‑in per field**. On any Telephone field's settings form you get
a small "Telephone validation" section with an **Enabled** checkbox, a **Format**
choice, and a **Country** selector. The two formats are:

- **E164** — the international format like `+14155552671`. The country is
  auto‑detected from the `+` country code, and you can optionally restrict which
  countries are allowed.
- **National** — a local number with no `+` prefix. Because there is no country
  code to read, you must pick exactly one country to tell the validator which
  region to assume.

Beyond individual fields, the module stores a **site‑wide default** (format plus
allowed countries) at **Configuration → Content authoring → Telephone Validation**.
Those defaults are automatically applied to core's `tel` render element, so custom
forms that use a `tel` field validate too, without extra code.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer (it pulls in the
   libphonenumber library) and enable it.
2. [Configuration](configuration/index.md) — enable validation on a field, choose a
   format and countries, and set the site‑wide defaults.

## Where it lives in the admin menu

- **Per‑field** validation is configured on each Telephone field's settings form
  under **Manage fields**.
- The **site‑wide defaults** form is at **Configuration → Content authoring →
  Telephone Validation** (`/admin/config/content/telephone_validation`).
