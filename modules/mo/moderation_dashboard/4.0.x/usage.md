Moderation Dashboard gives each content editor a personal dashboard at `user/{uid}/moderation-dashboard` that surfaces the content they need to moderate — recently created, recently changed, and items currently in review — plus an activity chart, all built from core Views and Layout Builder.

---

Moderation Dashboard depends on core Content Moderation, Node, Views and Layout Builder. On install it ships four Views (`moderation_dashboard`, `content_moderation_dashboard_in_review`, `moderation_dashboard_recent_changes`, `moderation_dashboard_recently_created`) and a `moderation_dashboard` user view mode whose Layout-Builder layout (a three-region "Moderation Dashboard Layout") arranges those Views together with two custom blocks: "Moderation Dashboard Activity" (a Chart.js graph of the user's editorial activity) and "Moderation Dashboard Add Links" (quick links to create moderated content). The dashboard page lives at the Views route `view.moderation_dashboard.page_1` (path `user/%user/moderation-dashboard`) and is protected by a custom Views access plugin backed by the `use moderation dashboard` / `view any moderation dashboard` permissions. Because the whole dashboard is Views + Layout Builder, administrators are expected to customise it via the UI — the module deliberately ships no update hooks so your customisations are never overwritten. Two settings (`moderation_dashboard.settings`) control whether editors are redirected to their dashboard after login (`redirect_on_login`, default on) and whether Chart.js is loaded from a CDN or a local copy (`chart_js_cdn`, default off/local). A link to the dashboard is also injected into the user toolbar menu for anyone with the `use moderation dashboard` permission.

---

- Give content editors a single landing page listing everything they need to moderate.
- Show each editor the nodes they recently created, so they can pick up drafts quickly.
- Surface content that has recently changed state across the site's editorial workflow.
- List content currently "in review" awaiting an editor's approval.
- Redirect editors straight to their moderation dashboard immediately after they log in.
- Display a Chart.js activity graph of an editor's recent moderation activity.
- Provide quick "add content" links for moderated content types at the top of the dashboard.
- Let a lead editor view any other user's moderation dashboard for oversight.
- Add a "Moderation Dashboard" link to the user toolbar menu for quick access.
- Customise which Views blocks appear on the dashboard via Layout Builder (no code).
- Re-order the left/middle/right regions of the dashboard layout per your team's needs.
- Add extra Views or custom blocks into the dashboard's Layout-Builder layout.
- Serve Chart.js from a locally installed library instead of a CDN for stricter CSP/security.
- Switch Chart.js to a CDN when you cannot install the local library.
- Restrict dashboard access to specific roles by granting the `use moderation dashboard` permission.
- Build an editorial "home base" for a newsroom or publishing team running content_moderation.
- Give reviewers a filtered queue of pending content without building a custom View from scratch.
- Track per-author editorial throughput via the activity chart.
- Extend the dashboard to non-node moderated entities by adding Views to the layout.
- Use the shipped Views as starting templates for your own moderation reports.
- Gate the "redirect after login" behaviour with the `has_moderated_content_type` condition so it only fires when moderated content exists.
- Expose a "link to latest version" column in a View using the module's `link_to_latest_version` Views field.
- Onboard new editors by pointing them at one URL instead of several admin listings.
- Provide site owners a low-code moderation overview without installing a heavier dashboard suite.
