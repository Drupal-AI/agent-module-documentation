<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Bamboo Twig - Extensions ports three Twig-Extensions filters into Drupal — `bamboo_extensions_truncate` (Text), `bamboo_extensions_time_diff` (Date) and `bamboo_extensions_shuffle` (Array).

---

This submodule of Bamboo Twig wires the historical `twig/extensions` Text, Date and Array extensions into Drupal's Twig environment as three tagged services (`bamboo_twig_extensions.twig.text`, `.date`, `.array`; classes `TwigText`, `TwigDate`, `TwigArray`). The filters are exposed under **`bamboo_extensions_`-prefixed names** — `bamboo_extensions_truncate`, `bamboo_extensions_time_diff` and `bamboo_extensions_shuffle` — so templates can truncate/word-safe-cut text, render human-readable relative dates, and shuffle arrays. Enabling the submodule makes these filters available site-wide without adding the composer package or a custom Twig extension.

---

- Truncate a body summary to a fixed length with an ellipsis (`| bamboo_extensions_truncate(120, true, '…')`).
- Safely cut a string without breaking words using `preserve=true`.
- Limit a teaser to 30 characters with the default truncate length.
- Change the truncation suffix from `...` to a custom separator.
- Render "3 days ago"-style relative times with `| bamboo_extensions_time_diff`.
- Show how long ago a node was created or updated.
- Display a comment's age in human-friendly form.
- Compare a date against a specific reference time via the `now` argument.
- Randomise the order of a list with `| bamboo_extensions_shuffle`.
- Show a random subset of promoted content each render.
- Shuffle testimonial or banner arrays for variety.
- Trim teaser text to a consistent length across a listing.
- Provide relative timestamps in an activity feed template.
- Avoid pulling `twig/extensions` into composer manually.
- Reuse familiar Twig-Extensions behaviour under the bamboo_extensions_ prefix.
- Truncate meta descriptions to a safe character count.
- Present "posted X ago" labels without PHP.
- Randomise gallery image order on each page load.
- Combine `striptags | bamboo_extensions_truncate` for clean plain-text excerpts.
