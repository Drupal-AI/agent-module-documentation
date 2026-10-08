<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Launch Checklist provides a pre-launch checklist inside Drupal, built on Checklist API, so the tasks that must be done before a site goes live are tracked where the work happens — at `/admin/config/development/launch-checklist`.

---

Every agency keeps this list, and most keep it in a document that is copied per project and diverges immediately. The items are unglamorous and each one has caused a real incident: analytics never installed, the XML sitemap never generated, cron not configured, error reporting and verbose logging left on, upload fields still accepting `.php`/`.exe`/`.html`, no HSTS, the private-files directory misconfigured, no database backup, the favicon and site email still the install defaults. Launch Checklist ships **14 sections** (General, Browser Checks, Forms, SEO, User Permissions, Content, GDPR and Privacy, Performance and Security, Database, Theme, Accessibility, Drupal Modules, Other, Printability), each a list of items with a description and helpful links. The links are smart in one specific way: for well-known contrib (metatag, redirect, simple_sitemap, seckit, security_review, google_analytics, and more) the item links to that module's **local settings page if it is enabled**, otherwise to the **drupal.org project** so you can go install it. Putting the list in the site makes it visible to whoever is working on that site rather than to whoever remembers the document exists, and because it is built on **Checklist API, ticking an item and clicking Save records who did it and when** into config (`checklistapi.progress.launch_checklist`), which turns a list into an audit trail and lets you export launch state through configuration synchronization into version control. Two caveats. **A checklist is a memory aid, not a test** — ticking "Analytics installed" records a claim, and a site with every box checked can still be broken, so the items worth having are the ones a person genuinely verifies. And **the list is fixed in code** — items are plain PHP arrays in the module's `.inc` files, so tailoring it to your organisation means patching or forking the module; the value compounds only if someone maintains it.

---

- Track pre-launch tasks inside the site rather than in a shared document.
- Record who checked each launch item and when (Checklist API stores user + timestamp).
- Export launch/sign-off state via configuration synchronization into version control.
- Check analytics (Google Analytics / Tag Manager) is installed before launch.
- Verify the XML sitemap and page titles / meta tags are configured.
- Confirm Schema.org / structured metadata settings.
- Ensure error reporting and verbose logging are turned off for production.
- Confirm cron is configured and running.
- Verify page caching plus CSS/JS aggregation are enabled.
- Audit upload fields to block unsafe extensions (php, exe, html, js, …).
- Confirm HSTS / HTTPS-only policy and a defined base URL in settings.php.
- Check the private files directory and filesystem permissions.
- Verify database and daily backups are in place.
- Confirm spam protection on public forms and correct form emails.
- Check privacy policy and EU cookie-compliance items for GDPR.
- Review accessibility items: image alt tags, color contrast, headings, alt audits.
- Run and record Lighthouse and Screaming Frog audits.
- Verify site email, site name, and favicon are the client's, not install defaults.
- Ensure unused, development, and tracking modules are disabled before go-live.
- Confirm search-and-replace of testbed/staging URLs in content.
- Support a repeatable, auditable agency launch and client-handover process.
- Discover recommended contrib modules via the checklist's install links.
