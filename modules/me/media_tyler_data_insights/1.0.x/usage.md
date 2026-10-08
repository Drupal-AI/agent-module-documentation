<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Media: Tyler Technologies Data & Insights adds a Media source and matching field formatter so editors can paste a Data & Insights (Socrata) share/embed snippet and have it rendered as an iframe anywhere Drupal Media is used.

---

The module provides a `media_tylerdi` **media source** plugin (label "Tyler Data & Insights") backed by a `string_long` source field that stores the pasted embed snippet, plus a media-library add form that lets editors paste the embed code inline. A `media_tyler_data_insights` **field formatter** parses the stored snippet, extracts the iframe `src`, and renders it through the `media-tyler-data-insights.html.twig` template at a configurable width and height. A validation constraint (`media_tyler_data_insights`) rejects snippets that don't contain exactly one iframe, whose path is not `/w/…` or `/stories/…`, or whose host is not in the site's **allowed hosts** list. Allowed hosts are the module's only configuration (`media_tyler_data_insights.settings` → `allowed_hosts`), edited at `/admin/config/media/tyler-data-insights`; each must be an `https://` origin with no path. If the CSP module is installed, an event subscriber automatically appends those hosts to the `frame-src` Content-Security-Policy directive on non-admin routes so the iframes are allowed to load. You use it by creating a Media type whose source is "Tyler Data & Insights", granting the create/administer permissions, and listing the Data & Insights domains you embed from.

---

- Embed a Tyler Data & Insights chart or map into a page by pasting its share/embed code as a Media item.
- Let editors add Data & Insights visualizations through the Media Library without writing HTML.
- Reuse one embedded visualization across many nodes via a Media reference field.
- Insert a Data & Insights story or dataset visualization into a WYSIWYG body with the media embed button.
- Restrict which Data & Insights servers may be embedded by maintaining an allowed-hosts list.
- Enforce that only valid `/w/` (visualization) or `/stories/` embed URLs are accepted.
- Set a consistent iframe width and height for all Data & Insights embeds via the formatter settings.
- Automatically allow the embed hosts in the site's Content-Security-Policy frame-src (with the CSP module).
- Create a dedicated "Data Visualization" media type governed by media permissions.
- Give only trusted roles the ability to add new allowed hosts while others can still create media.
- Standardize how public-sector open-data dashboards are surfaced on a Drupal site.
- Display a live government-data table (crime, budget, permits) sourced from Data & Insights.
- Curate a media library of approved open-data visualizations for reuse by content teams.
- Validate pasted embed codes at entry so broken or off-domain iframes never get saved.
- Present the same visualization at different sizes by adjusting the formatter's width/height settings.
- Provide a governed alternative to editors pasting raw iframe HTML into the body field.
- Swap a visualization site-wide by editing one Media entity's embed code.
- Keep embeds compliant with a strict CSP by driving frame-src from the allowed-hosts config.
- Support multi-tenant/agency setups by allowing several Data & Insights domains.
- Migrate existing raw iframe embeds into managed Media entities of this type.
- Show a Data & Insights visualization inside a Layout Builder block via a media field.
- Block embeds from an unapproved host with a clear validation error message.
