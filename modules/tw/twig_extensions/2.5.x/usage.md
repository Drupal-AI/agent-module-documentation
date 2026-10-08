<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Ports the classic `twig/extensions` package to Drupal as native Twig extensions, adding seven template filters that core Twig lacks: `shuffle`, `time_diff`, `localizeddate`, `localizednumber`, `localizedcurrency`, `truncate`, and `wordwrap`.

---

The module registers four `twig.extension`-tagged services — `ArrayExtension`, `DateExtension`, `IntlExtension`, `TextExtension` — each contributing filters usable directly in any Twig template. `shuffle` randomizes an array (accepting `\Traversable`). `time_diff` turns a timestamp into a human "3 minutes ago" / "in 2 days" string using core's `datetime.time` and `string_translation` (so it is translatable and pluralized). The Intl filters wrap PHP's `\IntlDateFormatter` / `\NumberFormatter`: `localizeddate` formats a date by locale + named format (`none`/`short`/`medium`/`long`/`full`), `localizednumber` formats numbers (decimal, percent, scientific, spellout, ordinal, duration, currency), and `localizedcurrency` formats a currency amount — all requiring the PHP `intl` extension (a `RuntimeException` is thrown if it is missing). `truncate` shortens a string to a length with an optional word-preserving mode and separator, and `wordwrap` breaks long strings onto new lines at a given width; both are charset-aware via the Twig environment. The filters return plain strings/values (the code is adapted from the upstream twig/extensions package) and do not mark output as safe HTML, so Twig's autoescaping still applies. No configuration, permissions, routes, services beyond the extensions, or Drush.

---

- Randomize the order of an array of items before looping in a template (`shuffle`).
- Show a "posted 5 minutes ago" relative time from a node's created timestamp (`time_diff`).
- Display "in 3 days" style future relative times for upcoming events (`time_diff`).
- Format a date according to the user's locale and a named style (`localizeddate`).
- Render a full localized date/time (e.g. weekday + long month) in a chosen language.
- Format numbers with locale-aware grouping and decimals (`localizednumber`).
- Spell out a number in words for a locale (`localizednumber` with `spellout`).
- Render ordinals ("1st", "2nd") localized (`localizednumber` with `ordinal`).
- Format a percentage or scientific number by locale (`localizednumber`).
- Format a monetary amount with the correct currency symbol/placement (`localizedcurrency`).
- Truncate a teaser/summary to N characters with an ellipsis (`truncate`).
- Truncate without cutting a word in half using the preserve option (`truncate`).
- Wrap long unbroken strings so they don't overflow their container (`wordwrap`).
- Insert custom line separators into long text at a fixed width (`wordwrap`).
- Shuffle testimonials or featured cards for variety on each page load.
- Localize dates in a multilingual site's templates without a preprocess function.
- Format currency in a commerce template consistently by locale.
- Build a compact "time ago" label for comment listings.
- Avoid writing PHP preprocess code for common string/date/number formatting in themes.
- Provide designers translatable, pluralized relative-time output out of the box.
