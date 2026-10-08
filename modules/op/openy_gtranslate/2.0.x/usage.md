<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Open Y Google Translate provides a single block that places the Google Translate widget on a site, packaged for the Open Y / YMCA Website Services distribution.

---

Install and enable the module (`drush en openy_gtranslate`), then place the **Open Y Google Translate** block (category *OpenY*) through the normal Block Layout UI at `/admin/structure/block`, choosing a region and any visibility conditions — commonly a header region site-wide, or restricted to the pages that matter. The block has no settings of its own: it renders a "Select Language" link and, when a visitor clicks it, lazily loads Google's translate script and builds the widget in the visitor's language, so nothing is fetched from Google until someone actually asks to translate. Three things are worth being clear about because they are properties of the widget rather than of this module: **machine translation is not site translation** (nothing is reviewed, terminology is uncontrolled, and translated pages are not indexed as translations, so legal, medical and safety content still needs human translation); **it is a third-party script** that sends page content to Google, which on EU-facing sites belongs in the privacy notice and behind cookie consent (e.g. Usercentrics or a Consent Mode module); and **Drupal's own multilingual system is unaffected** — this is a display-layer overlay that coexists with real translations, which you should still use where accuracy matters.

---

- Offer machine translation on a community or YMCA site.
- Serve a multilingual population without a translation budget.
- Place a translate widget in a header region.
- Show the widget only on selected pages via block visibility.
- Provide a fallback where real translations are absent.
- Translate programme and opening-hours information roughly.
- Combine the widget with real translations for key pages.
- Add translation to an Open Y site quickly.
- Restrict the widget by block visibility conditions.
- Gate the widget behind cookie consent for GDPR.
- Document the third-party Google script in a privacy notice.
- Identify pages that need human translation instead.
- Understand why machine-translated pages are not indexed.
- Audit which pages rely on machine translation.
- Decide which pages must not rely on the widget.
- Style the placeholder link for desktop and mobile menus.
- Reuse the same block in popups and dynamically injected content.
