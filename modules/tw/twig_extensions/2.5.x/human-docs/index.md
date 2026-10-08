# Twig Extensions — manual setup guide

**Twig Extensions** (`twig_extensions`) brings the classic `twig/extensions`
package to Drupal as native Twig extensions. It adds seven template filters that
core Twig does not include, so theme and template authors can format arrays, dates,
numbers, currencies, and text without writing PHP preprocess code.

The seven filters are: **shuffle** (randomize an array), **time_diff** (turn a
timestamp into a translatable "3 minutes ago" / "in 2 days" string),
**localizeddate**, **localizednumber**, and **localizedcurrency** (locale-aware
date, number, and currency formatting), plus **truncate** and **wordwrap** for
shortening and wrapping text. The three "localized" filters wrap PHP's `intl`
functions, so they need the PHP `intl` extension installed.

This is a developer/theming module: there is **no configuration, no permissions,
and no admin page**. You enable it and use the filters in your `.html.twig`
templates. The filters return plain values and do not mark their output as safe
HTML, so Drupal's normal Twig autoescaping still applies — they carry no special
security surface.

This guide is written for a **human** working in templates. If you want terse,
token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

## Where it lives in the admin menu

Nowhere — there is no admin page. The module simply registers the Twig filters so
they are available in every template.

## How to use it

After enabling, use the filters directly in any Twig template:

- **shuffle** — `{{ items|shuffle }}` randomizes an array (or any traversable)
  before you loop over it. The order changes on every render; it is not
  cryptographically random.
- **time_diff** — `{{ node.created.value|time_diff }}` produces a translatable,
  pluralized relative time such as "3 minutes ago" or "in 2 days" (an exact match
  renders as "now").
- **localizeddate** — `{{ date|localizeddate('medium', 'short', 'fr') }}` formats a
  date/time by locale and named style (`none`, `short`, `medium`, `long`, `full`).
- **localizednumber** — `{{ 1234.5|localizednumber('decimal', 'default', 'de') }}`
  formats numbers with locale-aware grouping; styles include `decimal`, `currency`,
  `percent`, `scientific`, `spellout`, `ordinal`, and `duration`.
- **localizedcurrency** — `{{ 19.99|localizedcurrency('EUR', 'fr') }}` formats a
  monetary amount with the correct currency symbol and placement.
- **truncate** — `{{ text|truncate(80, true, '…') }}` shortens a string to a length,
  optionally without cutting a word in half, appending a separator.
- **wordwrap** — `{{ text|wordwrap(80, "\n") }}` breaks long unbroken strings onto
  new lines at a given width.

The three localized filters require the PHP **intl** extension — without it they
throw a runtime error. See [Installation](installation/index.md) for that
prerequisite.
