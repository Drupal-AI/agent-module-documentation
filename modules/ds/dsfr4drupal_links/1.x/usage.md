<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
DSFR for Drupal - Links makes external links compliant with the French State Design System (DSFR) by adding target="_blank", rel="noopener external", and a "new window" title attribute to every link Drupal treats as external.

---

The module implements two complementary mechanisms. First, `hook_link_alter` (in `Dsfr4drupalLinksHooks::linkAlter()`) inspects every link Drupal renders through its link generator: when the URL is external and the `external_blank` setting is on, it forces `target="_blank"`, then on any `_blank` link adds `rel="noopener external"` and a translatable `@label - new window` title (only when those attributes are not already set). Second, a text-format filter plugin (`ExternaLinks`, id `dsfr4drupal_external_links`) does the same for links embedded in CKEditor/WYSIWYG body content: it parses the HTML with `Html::load()`, skips `mailto:` links, sets `target="_blank"` on external links, and merges `noopener`/`external` into the existing `rel` plus a `title`. All of this runs server-side, so it works without client JavaScript. The single configuration key `external_blank` (default `true`, in `dsfr4drupal_links.settings`) gates the automatic target-blank behavior for both mechanisms. There is no admin UI, no route, and no permission shipped by the module — configure the filter per text format on the Text formats page, and edit the config value via config import/drush. It is meant to accompany the base DSFR for Drupal theme.

---

- Automatically open external links in a new tab across a DSFR government site.
- Add `rel="noopener external"` to outbound links for tab-nabbing safety and SEO.
- Add an accessible "opens in a new window" title to external links.
- Apply DSFR external-link conventions without writing client-side JavaScript.
- Mark links that leave the site consistently, site-wide.
- Enable the `dsfr4drupal_external_links` filter on a rich-text format to treat links inside body/WYSIWYG content.
- Apply new-window/rel handling to links that Drupal generates (menus, fields, theme links) via `hook_link_alter`.
- Keep `mailto:` links untouched while still processing web links.
- Preserve any `rel`, `target`, or `title` an editor already set instead of overwriting it.
- Comply with the DSFR "lien" (link) component recommendations.
- Improve accessibility by signalling new-window links to assistive technology.
- Turn the automatic target-blank behavior off by setting `external_blank` to `false`.
- Pair with the base `dsfr4drupal` theme for a full DSFR implementation.
- Translate the "new window" mention (French translation shipped in `translations/fr.po`).
- Ensure outbound links carry `noopener` even when an editor manually set `target="_blank"`.
- Standardize external-link behavior on multilingual gov.fr sites.
- Avoid hand-editing every link in content to add new-window markup.
- Run on Drupal 10.3+, 11, or 12.
- Deploy the `external_blank` setting through configuration management.
- Combine with menu links and content links for uniform external-link treatment.
- Review external-link markup after content migrations for DSFR compliance.
