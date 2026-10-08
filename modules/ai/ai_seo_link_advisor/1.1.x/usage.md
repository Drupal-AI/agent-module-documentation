AI SEO Link Advisor analyzes an internal site URL for SEO metrics and returns AI-generated, per-issue recommendations using the drupal/ai provider abstraction.

---

The module provides a single form at /ai-seo-link-advisor-form where a user with the "access seo analyzer" permission enters a URL on the site. The submitted URL is validated (format, http/https scheme, host matched against the site's trusted_host_patterns, and resolution to a routable, non-admin Drupal page the user can access), then fetched and parsed into a set of SEO metrics: meta tags, heading structure, content-to-code ratio, image alt text, URL length, SSL, redirects, content size, load time, and robots.txt/sitemap.xml presence. For each metric that flags a problem, the module composes a prompt and asks the configured AI chat provider for a specific recommendation, then renders everything as two collapsible analytics tables with status icons. It uses whichever chat provider/model the AI module has set as the site default; there is no separate settings screen, and the trusted-host gate is configured in settings.php.

---

- Run an on-demand SEO audit of a specific page on your own Drupal site from an admin-facing form.
- Get AI-written, per-issue fix recommendations for meta tags, headings, alt text, content ratio, and URL length.
- Check whether a page's meta title and meta description are present and reasonably sized.
- Review a page's heading structure (H1-H5) for SEO issues.
- Measure the content-to-code ratio of a page to spot thin or markup-heavy content.
- Audit image alt text coverage, counting images with and without alt attributes.
- Flag overly long URLs that may hurt SEO.
- Confirm a page is served over HTTPS (SSL) and detect redirects.
- Measure page content size and approximate page load time.
- Verify that robots.txt and sitemap.xml exist for the site.
- Restrict who can run analyses with the dedicated "access seo analyzer" permission.
- Limit analysis to the site's own hosts by configuring trusted_host_patterns in settings.php.
- Prevent analysis of administrative pages and pages the current user cannot access.
- Use any chat-capable AI provider supported by the drupal/ai module (OpenAI, Anthropic, Ollama, and others) via the site default.
- Present results in collapsible content-analytics and general-analytics tables with clear status icons.
- Localize keyword-density analysis using the bundled English, Dutch, and Polish stopword lists.
- Refresh results inline via the form's AJAX callback without a full page reload.
- Integrate SEO review into an editorial workflow so authors and SEO staff can check pages before or after publishing.
- Get a quick prioritized view (no action / attention / immediate action) of a page's SEO health.
