DubBot integrates the external DubBot SaaS (automated accessibility, broken-link, spelling, SEO and web-governance scanning) into Drupal, surfacing each crawled page's report inside the admin UI via an overview page, an embeddable report block, and an optional toolbar item.

---

The module talks to DubBot's HTTP API using an **embed key** you generate in your DubBot account, stored in the `dubbot.settings` config object (with `api_url`, a `dialog_renderer` position, and a `preview_selector`). A `dubbot.client` service validates the key and fetches per-page and per-site reports, caching the "enabled" state (cache tag `dubbot:client`); a `dubbot.domain_negotiator` service decides which site domains to request reports for (alterable via `hook_dubbot_domains_alter()`, and language-domain aware out of the box); and a `dubbot.link_generator` builds the report iframe links. The admin **Overview** page (`/admin/config/content/dubbot`) lists crawled pages with issue counts and links to individual reports, which open in an off-canvas tray, an off-canvas top panel, or a modal depending on `dialog_renderer`. A **DubBot Report** block plugin (`dubbot_report`, with a configurable `link_color`) can be placed anywhere to show the current page's report inline. Access is gated by a rich permission set: `administer dubbot configuration`, `access dubbot report`, and one permission per report pane (`view dubbot accessibility tab`, `… spellcheck tab`, `… seo tab`, `… links tab`, `… practices tab`, `… governance tab`) so roles can be limited to specific report tabs. The bundled **DubBot Toolbar** submodule adds a toolbar item linking to the current page's report. The module ships no fields or entities of its own — its state is the settings config, block placements, and role permissions; live reporting requires a valid DubBot account and embed key.

---

- Surface DubBot accessibility (a11y) scan results for each page directly inside the Drupal admin.
- Show editors a per-page broken-links report without leaving the site.
- Expose spelling-mistake reports from DubBot to content authors.
- Review SEO findings from DubBot per page.
- Enforce custom web-governance rules and view violations in Drupal.
- Give each crawled page an issue-count overview at `/admin/config/content/dubbot`.
- Open an individual page's DubBot report in an off-canvas side tray.
- Switch the report to open at the top of the screen (`off_canvas_top`) or as a modal instead.
- Place a "DubBot Report" block on node pages so authors see issues inline while editing context.
- Brand the report block's link color to match the site theme.
- Add a toolbar shortcut to the current page's report by enabling the DubBot Toolbar submodule.
- Restrict which roles can see the accessibility tab vs the SEO tab via per-pane permissions.
- Let a content team see spelling/links reports but hide the configuration form from them.
- Limit report access entirely to a QA role using `access dubbot report`.
- Point the integration at a custom DubBot API endpoint via the `api_url` setting.
- Fix issue-highlighting on an unusual theme by changing the `preview_selector` CSS selector.
- Validate a DubBot embed key from the settings form before saving.
- Report on multiple domains (e.g. per-language domains) by extending the domain negotiator.
- Add or remove domains sent to DubBot with `hook_dubbot_domains_alter()`.
- Integrate DubBot reporting into a multilingual, domain-per-language site automatically.
- Cache the "is DubBot enabled" check to avoid repeated key validation (tag `dubbot:client`).
- Programmatically fetch a page's report via the `dubbot.client` service.
- Build report iframe URLs in custom code via the `dubbot.link_generator` service.
- Provide a governance/best-practices dashboard link to compliance stakeholders.
- Roll out automated content-quality QA across a large editorial site.
