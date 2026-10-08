# Currency Field — manual setup guide

**Currency Field** (`currency_field`) adds a field type for storing a currency
chosen from the **ISO 4217** standard list (USD, EUR, GBP, and every other code in
the standard). Add it to any entity and editors pick a currency from a proper
list, rather than typing a code into a plain text field and hoping it's valid.

It's a small, feature‑complete module: it does one thing, has **no dependencies
beyond Drupal core**, and is maintained for fixes rather than new features. The
full ISO 4217 list is bundled as data — alphabetic code, numeric code, currency
name, issuing entity, and minor unit — so there's no API call and no external
service to depend on. Withdrawn currencies keep their withdrawal date, so
historical records stay valid instead of failing validation.

Because it's a field type, there's **no central configuration page**. You add a
Currency field to an entity bundle and set it up on that bundle's field and
display screens. The field can be keyed and labelled by any pair of the ISO
columns — so it can store alphabetic codes while showing full currency names, or
store numeric codes for a system that expects them. It works on Drupal 8 through
11.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

There is **no configuration page** for this module — you set it up per field, as
described in "How to use it" below.

## How to use it

1. On a content type (or any fieldable entity), go to **Manage fields → Add
   field** and choose the **Currency** field type.
2. On **Manage form display**, use the **select** widget so editors pick from the
   ISO 4217 list.
3. On **Manage display**, set the **label format** — for example, store the
   alphabetic code but display the full currency name, or store the numeric code
   for a downstream system.

### For developers

If you need the currency data outside a field, two helpers are available:

- `currency_field_currencies()` returns the full decoded list.
- `currency_field_currency_options()` returns an options array, keyed and labelled
  by whichever columns you ask for — `AlphabeticCode`, `NumericCode`, `Currency`,
  `Entity`, `MinorUnit`, or `WithdrawalDate`.

The source data lives in `currencies.yml`, from the currency‑codes dataset.
