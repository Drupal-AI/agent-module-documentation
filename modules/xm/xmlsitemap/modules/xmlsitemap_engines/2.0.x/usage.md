XML Sitemap Engines is a submodule of XML Sitemap that automatically notifies (pings) search engines when your sitemap is updated, and can submit custom sitemap URLs.

---

Once a sitemap exists you still have to tell search engines about changes. XML Sitemap Engines automates this: on a configurable minimum interval it pings the search engines you select whenever the sitemap is regenerated, so crawlers re-fetch it promptly. You choose which engines to notify, can add extra custom sitemap URLs to submit, and set a minimum submission lifetime to avoid pinging too often. The set of available engines is pluggable through `hook_xmlsitemap_engine_info()` (and its alter), so other modules can register additional destinations. Settings live in the `xmlsitemap_engines.settings` config object and are managed under the XML Sitemap admin section, reusing the parent module's `administer xmlsitemap` permission. It depends on the xmlsitemap module.

---

- Automatically ping search engines when the sitemap updates.
- Select which search engines to notify.
- Avoid over-pinging with a minimum submission interval.
- Submit an additional custom sitemap URL to engines.
- Keep search engines aware of frequently changing content.
- Trigger submission automatically after cron regeneration.
- Register a new search engine destination via a hook.
- Alter the list of available engines in code.
- Reduce time-to-index for new content.
- Notify multiple engines from one configuration.
- Configure submission behavior without writing code.
- Reuse the parent module's admin permission for access control.
- Disable pinging for staging environments by unselecting engines.
- Submit a secondary sitemap hosted at a custom path.
- Integrate a regional/alternative search engine via a custom plugin.
- Ensure updated priority/frequency changes get re-crawled sooner.
