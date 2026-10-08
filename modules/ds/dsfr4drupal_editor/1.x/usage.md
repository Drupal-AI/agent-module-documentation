<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
DSFR for Drupal Editor adds one text-format output filter that rewrites editor-generated HTML into the markup expected by the French State Design System (DSFR).

---

French government sites must follow the DSFR (Système de Design de l'État), whose components — a quote, a responsive table, an aligned media — need specific wrapper markup and class names. Rich-text editors do not produce that markup on their own. DSFR for Drupal Editor closes the gap with a single filter plugin, `filter_dsfr4drupal` ("Apply the DSFR recommendations"), that you enable on a text format. At render time it wraps every `<blockquote>` in a `<figure class="fr-quote">`, wraps every `<table>` in the four nested `fr-table*` containers, and renames the `align-left|center|right` class that core Media writes on a `<drupal-media>` embed to DSFR's `text-align-*`. The replacements are fixed DSFR class strings — no editor or visitor input is inserted — so the module has no security surface: no routes, controllers, permissions, or settings form, and only a dependency on core's Editor module. Enable it alongside the base DSFR for Drupal theme (which provides the `fr-*` CSS), and, if you use the Align/Caption media filter, order this filter to run after it. Adopt it on a French government (DSFR) site.

---

- Make editor-created blockquotes render as the DSFR "citation" component.
- Make editor-created tables render as DSFR responsive tables (`fr-table` wrappers).
- Convert core Media's `align-*` class on embeds to DSFR's `text-align-*`.
- Bring existing rich-text content into DSFR compliance without editing each node.
- Standardise DSFR markup across all content using a given text format.
- Pair with the base DSFR for Drupal theme so the wrappers pick up `fr-*` styling.
- Enable only on the text format(s) that need DSFR output, leaving others untouched.
- Order after the Align/Caption filter so media alignment is rewritten correctly.
- Apply DSFR table/quote wrappers on a "Full HTML" format used by trusted editors.
- Keep a gov.fr site's editorial content consistent with the state design system.
- Avoid teaching editors DSFR class names — the filter adds the wrappers automatically.
- Style DSFR quote/table components via the design system's own CSS classes.
- Use on any field or block whose text format includes the filter.
- Combine with core's HTML-restriction filters (place appropriately in the order).
- Disable on formats where DSFR wrappers are not wanted.
- Review filter ordering after adding other output filters.
- Confirm the DSFR theme is active so wrappers are visible.
- Test the rendered markup before production.
- Adopt as part of the broader DSFR for Drupal module suite.
- Re-check ordering and behaviour after module or core upgrades.
