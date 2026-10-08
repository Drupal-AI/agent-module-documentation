# Loqate — manual setup guide

**Loqate** (`loqate`) connects Drupal to the [Loqate](https://www.loqate.com/)
address‑capture service (formerly PCA / Addressy). It gives your forms a
type‑ahead address search: a user starts typing their address, picks the right
match from Loqate's suggestions, and the individual address fields — street,
city, postal code, country — are filled in automatically. This cuts down typing
errors and gives you cleaner, consistently formatted address data.

The base module provides a `pca_address` form element you can drop into a custom
form, plus two admin settings forms: one to tell it which API key to use, and one
to map the fields Loqate returns onto your address fields. Two optional
submodules extend it: **PCA Address** (`pca_address`) adds a widget for the
Address module's `address` field, and **PCA Webform** (`pca_webform`, deprecated)
adds a Webform address element.

One important design point: the address lookup runs **entirely in the visitor's
browser**. The module loads Loqate's hosted JavaScript SDK and hands it your API
key and field mapping directly — there is no Drupal‑side proxy. That means the
key value is exposed to the browser by design, so you should use a Loqate key
that is **restricted to your own domain(s)** on your Loqate account. The key
itself is stored through Drupal's **Key** module rather than as plain
configuration.

> **About the API key.** Following this project's convention, put your Loqate key
> in an environment variable and reference it from a Key entity, then select that
> Key in Loqate's settings form. Never hard‑code or commit the key — and remember
> to restrict it by domain on the Loqate side, since it reaches the browser.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module and the Key
   dependency with Composer, enable it, and pick the submodules you need.
2. [Configuration](configuration/index.md) — select the API key and map Loqate
   response fields to your address fields.

## Where it lives in the admin menu

Both settings forms live under **Configuration → Web services → Loqate API**
(`/admin/config/services/loqate-api`) — the API‑key form at that path and the
field‑mapping form at `/admin/config/services/loqate-api/pca-address`. Both are
gated by the single **Administer Loqate API** (`administer loqate api`)
permission.
