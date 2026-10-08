<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Regex Text Replacement (regex_text_replacement) — agent index

Text-format **filter** applying regex replacements at render time. Configured as a textarea of
`pattern||replacement` lines; `(1)`-style backreferences become `$1`. Depends on core `filter`.
Version **1.0.1**. Core requirement `^9 || ^10 || ^11`.

**Where it fits:** inherited content you cannot or will not edit in place — a legacy domain in
every migrated link, a tracking parameter on every image, an old shortcode syntax. Stored text is
untouched; output is corrected. Reversible by unchecking the filter.

Robustness: a failed `preg_replace` logs a warning (with `preg_last_error_msg()`) and skips that
line rather than throwing — a bad pattern degrades to no replacement, not a WSOD.

**Three cautions. The patterns come from text-format settings, which need `administer filters` —
already one of the most powerful permissions on a site, so these are configuration hazards, not
vulnerabilities:**
1. **Catastrophic backtracking.** A pattern that is fine on a paragraph can hang on a long node,
   and this runs on **every render of every affected field**.
2. **Filter order.** A replacement that inserts markup *after* the HTML-restricting filter has run
   inserts it **unfiltered**.
3. **Regex on HTML is fragile.** Anchor tightly and test against the site's worst content, not
   its best.

PHP 7 removed the `/e` modifier, so an admin-supplied pattern cannot execute code.

**See also:** [`filters/regex-replacement-filter.md`](filters/regex-replacement-filter.md) —
plugin ID, rule syntax, and the full `process()` behaviour.
