<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Seeds SEO is a code-free starter module that enables a curated set of SEO modules (metatag, pathauto, simple_sitemap, redirect, link_attributes, length_indicator) in one step as part of the Seeds distribution.

---

Seeds SEO is a metapackage: it ships no PHP, no routes, no services, and no configuration of its own. Its `seeds_seo.info.yml` simply declares dependencies on the modules that make up an SEO baseline — Metatag with its Facebook and Open Graph submodules, Simple Sitemap, Redirect, Pathauto, Link Attributes, and Length Indicator — so that enabling the single Seeds SEO module turns the whole stack on together. Its `composer.json` goes further and requires additional SEO-related projects into the codebase (Fast 404, Google Analytics, Google Tag, Yoast SEO, Schema Metatag, MS Clarity, Linkchecker) which you can then enable individually as needed. Because it is purely an aggregator, all actual behaviour, configuration, and any security surface belong to the modules it pulls in; after enabling Seeds SEO you configure each of those modules through their own admin pages. It is intended for the Seeds distribution but works on any Drupal 10 or 11 site as a convenient SEO starting point, provided you review the bundle and its per-module configuration for your needs.

---

- Enable an SEO baseline for a new Drupal 10/11 site in a single step.
- Pull the curated Seeds SEO module stack in via Composer with `drupal/seeds_seo`.
- Turn on Metatag together with its Facebook and Open Graph submodules.
- Add XML sitemap generation by bringing in Simple Sitemap.
- Add automatic URL alias generation via Pathauto.
- Add URL redirect management via the Redirect module.
- Add per-link attribute controls via Link Attributes.
- Add title/description length feedback in edit forms via Length Indicator.
- Make Yoast SEO, Schema Metatag, Google Analytics, Google Tag, MS Clarity, Linkchecker, and Fast 404 available in the codebase to enable selectively.
- Bootstrap the Seeds distribution's SEO feature set without hand-picking each module.
- Standardise the SEO module set across multiple Seeds-based sites.
- Use as an opinionated SEO starter kit on a non-Seeds site.
- Ensure a consistent baseline of meta tags, sitemaps, and clean URLs.
- Give content editors Open Graph and Facebook meta tag fields out of the box.
- Onboard a new project team onto a known-good SEO module selection.
- Reduce setup time when scaffolding a site that needs SEO from day one.
- Review which SEO modules are bundled before committing to the stack.
- Configure each pulled-in module through its own settings page after enabling.
- Disable Seeds SEO after enabling the stack if you prefer not to keep the aggregator installed.
- Audit dependency versions declared in `composer.json` when planning upgrades.
- Keep the SEO stack aligned by upgrading Seeds SEO and its dependencies together.
- Serve as documentation of the recommended SEO module set for the distribution.
- Combine with other Seeds starter modules to compose a full site profile.
