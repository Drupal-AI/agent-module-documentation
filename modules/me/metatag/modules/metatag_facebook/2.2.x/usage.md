Adds Facebook-specific `fb:*` meta tags (app id, admins, pages) that complement Open Graph for Facebook integrations.

---

Facebook reads Open Graph tags for link previews, but a few Facebook-only tags control administrative and app-level features such as Insights, the Facebook app association, and page ownership. This submodule registers those `fb:*` tags as Metatag plugins so they can be set as defaults or per entity. It is typically used alongside `metatag_open_graph`. Depends on the main Metatag module. Small but essential for sites that use Facebook Insights, Facebook Login, or claim Facebook Pages.

---

- Associate the site with a Facebook App via `fb:app_id` (enables Insights/Login).
- Declare Facebook admin user IDs via `fb:admins` for domain insights.
- Link content to Facebook Pages via `fb:pages`.
- Enable Facebook Domain Insights analytics.
- Set the app id globally as a Metatag default.
- Override Facebook tags per content type if needed.
- Populate the app id from a token or site setting.
- Support Facebook Login by declaring the app association.
- Claim page ownership for shared links.
- Pair with Open Graph tags for complete Facebook sharing.
- Keep Facebook credentials in exportable config.
- Provide multiple admin IDs for a team.
- Ensure share-debugger recognizes your app.
- Track engagement in Facebook Analytics.
- Standardize Facebook integration across a multisite.
- Avoid hard-coding Facebook IDs in templates.
