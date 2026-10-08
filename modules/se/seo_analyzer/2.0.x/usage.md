<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
SEO analyzer adds an "SEO Analyzer" tab to each node (and Canvas page) that runs on-page SEO checks and reports them to the editor.

---

Install it like any contrib module (`composer require drupal/seo_analyzer` then enable **SEO analyzer**); it needs no other modules and runs on Drupal 11 (`core_version_requirement: ^11`, PHP 8.0+). After enabling, grant the single **`access seo analyzer`** permission to the roles that should see the tool (People → Permissions, or `drush role:perm:add editor 'access seo analyzer'`) — there is **no settings page**, so that permission is the entire configuration. A new **SEO Analyzer** local task and operation link then appears on every saved node next to Edit/Translate (and on Canvas pages when the Canvas / Experience Builder module is installed). Opening it fetches the page over HTTP from its own canonical URL, parses the returned HTML, and shows three tables — keyword analytics, content analytics and general analytics — with a per-row "negative impact" score (green/orange/red). At the top a **keyword** box lets you type the keyword or keyphrase to score the page against; submitting reloads the tab with a `?keyword=` query parameter and re-runs the checks. The checks include meta title/description presence and length, keyword usage in headings and body, keyword density and overuse, heading structure, code-to-text ratio, image alt text, URL length, HTTPS/SSL, redirects, HTML source size, page load time, and whether `robots.txt` and `sitemap.xml` exist on the host. Nothing is stored: every view re-fetches and re-computes. Because the analyzer fetches the site's own rendered page, the pages you want to check must be reachable over HTTP from the web server itself.

---

- Add an on-page SEO checklist tab to nodes.
- Give editors SEO feedback inside the content workflow.
- Check whether a page has a meta description.
- Check the meta title and description lengths against recommended ranges.
- Find images that are missing alt text.
- Review a page's heading structure (single H1, presence of H2/H3).
- Score a page against a target keyword or keyphrase.
- See if the keyword appears in the title, description, headings, URL and path.
- Spot keyword overuse (stuffing) in headings and body content.
- Check the code-to-text (content) ratio of a page.
- Verify the page is served over HTTPS/SSL.
- Detect that a URL redirects to another URL.
- Check whether the page URL is too short or too long.
- Confirm the site exposes a `robots.txt` file.
- Confirm the site exposes a `sitemap.xml` file.
- Review the raw HTML source size of a page.
- See the measured page load time.
- Audit a landing page before a campaign.
- Review a node's SEO before publishing.
- Analyze a Canvas / Experience Builder page's on-page SEO.
- Train editors on on-page SEO basics with concrete per-page findings.
- Restrict who can run the analyzer with a single permission.
- Call the bundled analysis library from custom code to analyze an arbitrary URL, HTML string or file.
