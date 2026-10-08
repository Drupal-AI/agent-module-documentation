<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Varbase SEO is a feature/bundle module from the Varbase distribution that installs and pre-configures a curated stack of SEO contrib modules (Metatag, Pathauto, Redirect, Simple Sitemap, Schema.org Metatag, Real-Time SEO/Yoast, Google Analytics, and more) in one step. It ships opinionated default configuration — metatag defaults, pathauto/redirect/sitemap settings, meta-tag and Yoast fields on nodes — rather than providing an SEO engine of its own.

---

Enabling `varbase_seo` runs a bundled Drupal recipe (`recipes/default/recipe.yml`) at `hook_install()` that enables ~21 SEO-related modules — `metatag` and its submodules (`metatag_facebook`, `metatag_open_graph`, `metatag_twitter_cards`, `metatag_hreflang`, `metatag_mobile`, `metatag_verification`, `metatag_google_plus`), `eca_metatag`, `pathauto`, `redirect` / `redirect_404` / `redirect_domain`, `schema_metatag` (+ `schema_article`, `schema_item_list`, `schema_web_page`, `schema_web_site`), `simple_sitemap`, `yoast_seo`, `script_manager`, and `entity_clone` — then imports each module's default config and applies opinionated overrides. It creates a `field_meta_tags` (Metatag) field and a `field_yoast_seo` (Real-Time SEO analysis) field on nodes, ships Metatag defaults for global/front/node/taxonomy_term/user/403/404 contexts, and sets Pathauto (URL-alias punctuation, safe tokens, 100-char aliases), Redirect (301 auto-redirect, deslash, normalize aliases), and Simple Sitemap (cron generation for node/taxonomy_term/menu links) defaults. Its own code is small: a single `#[Hook]` class relabels the Yoast widget to "Real-time SEO analyzer", rebuilds the Metatag defaults edit form through the Metatag manager, loads custom Google Analytics settings when `google_analytics` is enabled, and adds extra Pathauto punctuation characters (typographic dashes/quotes plus a full set of Arabic diacritics and guillemets). If Varbase editorial roles (`editor`, `content_admin`, `seo_admin`, `site_admin`) exist, the recipe grants them SEO permissions (`use yoast seo`, `administer meta tags`, `administer redirects`, `administer scripts`, `administer sitemap settings`, `clone script entity`). It defines no routes, permissions, services, plugin types, or Drush commands itself; it is a config-and-dependency bundle. It can be installed on any Drupal 11 site but is designed for Varbase, where the roles and content types it references already exist. After install it also sets its own module weight after the SEO modules so its hooks run last.

---

- Install a complete, pre-configured SEO stack on a Drupal 11 site in one step.
- Bootstrap SEO tooling on a Varbase-based site as part of the distribution's extra components.
- Add Metatag support with sensible default meta tags for global, front page, nodes, taxonomy terms, and users.
- Provide `robots: noindex` meta-tag defaults for 403 and 404 pages.
- Add an Open Graph / Twitter Cards / Facebook / hreflang meta-tag setup out of the box.
- Add a `field_meta_tags` field to content so editors can override meta tags per node.
- Add a Real-Time SEO (Yoast) analysis field (`field_yoast_seo`) to content for live content-quality scoring.
- Enable and pre-configure Pathauto with a 100-character alias pattern, transliteration, and a curated safe-token list.
- Add typographic and Arabic-script punctuation handling to Pathauto URL aliases.
- Enable automatic 301 redirects, alias normalization, and deslashing via the Redirect module.
- Track and manage 404s with `redirect_404` (with a "Redirect 404" admin view) and domain redirects.
- Enable Schema.org structured-data output (Article, WebPage, WebSite, ItemList) via Schema.org Metatag.
- Enable Simple Sitemap with cron-based XML sitemap generation for nodes, taxonomy terms, and menu links.
- Enable Google Analytics with a privacy-friendly default (IP anonymization, admin/user paths excluded from tracking).
- Add Google Tag Manager support via `google_tag`.
- Manage custom third-party scripts/snippets through `script_manager`, with a cloneable script entity.
- Grant SEO management permissions to Varbase editorial roles automatically.
- Give SEO admins access to the Metatag plugins report.
- Standardize SEO configuration across multiple Varbase sites by reusing one module.
- Provide a starting point you can further customize per site after install.
- Relabel the Yoast widget on node forms to "Real-time SEO analyzer".
- Ensure SEO module hooks run last by ordering `varbase_seo` after the SEO modules via `set_weight_after`.
