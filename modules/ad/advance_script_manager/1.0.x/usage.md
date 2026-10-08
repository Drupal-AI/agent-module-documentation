Advance Script Manager lets administrators register named JavaScript/CSS snippets and inject them into a site's header, body, or footer with per-path, role, and content-type visibility rules.

---

Advance Script Manager gives site administrators a UI to create, name, enable, order, and place arbitrary JavaScript and CSS snippets across the site without editing theme templates. Each snippet is assigned to one of three regions (Header, Body, or Footer), toggled active/disabled (disabled by default so nothing goes live accidentally), and constrained to specific pages by an allow/deny path list — much like the core Block module's visibility settings. Snippets are stored in a dedicated `advance_script_manager` database table, listed in a filterable/pageable admin table, ordered by draggable weight, and can be bulk-activated, disabled, moved between regions, or deleted. Header snippets are emitted with `hook_page_attachments_alter()`, body snippets with `hook_page_top()`, and footer snippets with `hook_page_bottom()`. The module has no dependencies beyond Drupal core and is a general replacement for ad-hoc tracking-code modules.

---

- Add a Google Analytics / GA4 gtag snippet to the header across the whole site.
- Inject a Google Tag Manager container snippet in the header and its noscript fallback in the body.
- Add a Facebook/Meta Pixel tracking snippet site-wide.
- Drop a LinkedIn Insight, Hotjar, or Microsoft Clarity tag without touching the theme.
- Register a marketing chat/support widget (e.g. Intercom, Drift) that loads before the closing footer.
- Load a third-party JS library from a CDN via a `<script src>` tag only on selected pages.
- Add custom inline CSS overrides scoped to the front page only.
- Inject a cookie-consent banner script in the header before other trackers fire.
- Add verification `<meta>` tags (Google Search Console, Bing) to the page head.
- Place a schema.org / JSON-LD structured-data snippet in the header.
- Add an A/B testing or personalization vendor snippet at the top of the body.
- Load a font or icon stylesheet via a `<link rel="stylesheet">` tag in the header.
- Show a promotional banner script only on a set of campaign landing pages using the allow-list path mode.
- Exclude a script from admin pages by using the deny-list ("all pages except those listed") mode.
- Add a conversion-tracking pixel that fires only on a checkout/thank-you path.
- Temporarily disable a tracking snippet during maintenance without deleting it, then re-activate it later.
- Bulk-move several snippets from the footer to the header in one action from the manage-scripts table.
- Reorder competing header scripts with the drag-and-drop weight form so a consent script runs first.
- Filter the snippet list by region (Header/Footer/Body) or status (Active/Disabled) to audit what is live.
- Bulk-activate or bulk-disable a group of snippets after a site launch or rollback.
- Add a custom `<style>` block to tweak theme presentation without a full theme deployment.
- Inject a live-chat or feedback-widget loader on content pages but not on the login page.
- Manage all site tracking tags centrally so editors/marketers' requests can be fulfilled from one admin screen.
