# Simple Currency Converter — manual setup guide

**Simple Currency Converter** (`simple_currency_converter`) lets visitors convert
the prices shown on your pages into a currency of their choosing. It adds a
currency picker (a small dialog) and some JavaScript that finds the price elements
on the page — matched by a CSS selector you configure — and rewrites them into the
selected currency, using live exchange rates fetched server‑side.

The exchange rates come from **pluggable feeds**. The module ships submodules for
the **European Central Bank** feed (`ecb_scc`) and the **FloatRates** feed
(`floatrates_scc`), and a **notifier** submodule (`notifier_scc`) that emails an
administrator when a rate check fails. You pick a primary feed and an optional
secondary feed that acts as a fallback, and developers can register their own feed
by implementing a simple interface. Fetched rates are cached — either in Drupal's
cache backend or in a cookie — for a lifetime you set, so the site is not hitting
the feed on every request. It works without Drupal Commerce; any rendered prices
that match your selector can be converted.

The module needs configuration before it is useful: at minimum you enable a feed
submodule, choose that feed in the settings, and set the CSS selector that matches
your prices. The currency‑switch endpoint that returns a rate is intentionally open
to anonymous visitors (so anyone can switch currency) — it only returns a numeric
rate as JSON and does not fetch any URL you supply.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer, enable
   it and at least one feed submodule.
2. [Configuration](configuration/index.md) — the settings form, the feeds, and how
   to add your own, field by field.

## Where it lives in the admin menu

Once enabled, the settings form sits at **Configuration → Regional and language →
Simple Currency Converter**
(`/admin/config/regional/simplecurrencyconverter`), reachable by users with the
**Administer simple currency converter** permission. The FloatRates submodule adds
its own form at `/admin/config/regional/simplecurrencyconverter/floatrates`.
