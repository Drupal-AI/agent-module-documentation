<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Filter Tooltips — agent orientation

D9/D10 text-format filter. Plugin: `src/Plugin/Filter/FilterTooltips.php` (+ CKEditor plugin/JS).

- Matches taxonomy term names in text (regex from term keys, `preg_quote`d) and renders each as a tooltip via the `filter_tooltips_tooltip` theme hook.
- Template outputs the term description with `{{ description|escape }}` (data attribute) — escaped, so no XSS via description.
- Config: source vocabulary, automatic vs manual, occurrence limit, excluded tags, trigger event.
- Security: description is escaped; terms are admin/curated content. No findings.
