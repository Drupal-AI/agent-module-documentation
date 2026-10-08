SEO Checklist gives you a fillable, persistent checklist of Drupal search-engine-optimization tasks — the recommended SEO modules to install and the technical steps to configure — and tracks which ones you have completed.

---

SEO Checklist provides almost no functionality of its own; it is a curated task list built on top of Checklist API. It implements `hook_checklistapi_checklist_info()` to register a single checklist (id `seo_checklist`, title "SEO checklist") whose items are the recommended steps for on-page and technical SEO, grouped into sections such as Clean URLs, Meta tags and Schema.org, Search engines, Optimizing content, On-page optimization, Security and performance, and Mobile. Each item carries an augmented schema: a `#module` key (project/machine name of a recommended contrib module such as redirect, pathauto, metatag, simple_sitemap, robotstxt, google_tag, easy_breadcrumb, yoast_seo, security_review), a `#configure` key (a route name to that module's settings page), and an optional `#seo_training_camp` key (an external learning link). A preprocess helper (`_seo_checklist_preprocess_checklist_items()`) expands those keys into Download/Install/Configure/Configure-permissions links, and pre-checks (`#default_value`) any item whose module is already installed, so the list auto-detects work you have already done. Checklist API supplies the route, the two per-checklist permissions, the vertical-tab UI, the progress bar, and persistence of who checked each item and when. The checklist lives at `/admin/config/search/seo-checklist` (route `checklistapi.checklists.seo-checklist` → `checklistapi.checklists.seo_checklist`), reachable under Admin → Configuration → Search and metadata → SEO Checklist. It ships no config settings form, no permissions of its own, no services, and no Drush commands; uninstalling it deletes the stored progress (`checklistapi.progress.seo_checklist`).

---

- Track completion of on-page and technical SEO tasks for a Drupal site launch.
- See a curated, ordered list of the recommended SEO contrib modules to install (redirect, pathauto, metatag, etc.).
- Auto-detect and pre-check items whose module is already installed.
- Jump straight to each recommended module's project page to download it.
- Jump to the modules install page anchored to the right module.
- Jump to a recommended module's configuration form via the item's Configure link.
- Jump to a module's permissions page when it is already installed.
- Record who checked off each item and the date/time they did it.
- Watch overall progress with the progress bar at the top of the checklist.
- Work through SEO setup section by section using the vertical-tab layout.
- Set up Clean URLs by installing/configuring Redirect, Redirect 404, and Pathauto.
- Configure Metatag and Schema Metatag for meta tags and Schema.org structured data.
- Add hreflang tags for multilingual pages via the Alternate hreflang module.
- Create and submit an XML sitemap (Simple XML Sitemap) to Google and Bing.
- Edit robots.txt through Drupal with the RobotsTxt module and verify the sitemap is listed.
- Set up cron so the XML sitemap stays up to date.
- Install Google Tag Manager for analytics and submit the sitemap to search engines.
- Add breadcrumbs and an HTML sitemap for content optimization (Easy Breadcrumbs, Sitemap).
- Enable real-time content SEO analysis with the Yoast/Real-time SEO module.
- Turn on revisions and Diff to see how content changes affect rankings.
- Harden and speed up the site (Security Review, CSS/JS aggregation, CDN, HTTPS).
- Verify the site is responsive/mobile-friendly.
- Follow external "SEO training camp" links for extra guidance on specific tasks.
- Save incremental progress and resume the checklist later without losing state.
- Hand a site off with a documented, auditable record of SEO steps completed.
- Extend or alter the SEO item list from a custom module via Checklist API's info-alter hook.
