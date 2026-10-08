<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Lytics connects a Drupal site to the Lytics Customer Data Platform (CDP). It injects the Lytics JavaScript tag on non-admin pages, lets editors build Pathfora personalization widgets (modals, bars, recommendations) targeted at Lytics audiences, and ships a Content Recommendation block powered by Lytics interest engines and content collections.

Use it when you already have a Lytics account and want to run on-site personalization, audience-segment targeting and content recommendations driven by Lytics profiles.

---

Install the module and go to Administration > Configuration > System > Lytics (`lytics.settings_form`, permission `manage lytics connection`). Paste a Lytics Access Token; the module calls the Lytics account API to resolve and store your account name, id and domain. Toggle "Enable Tag", "Debug Mode" (non-minified tag) and "Ignore Admin Users", and optionally supply extra tag configuration as JSON.

Manage widgets at `/admin/structure/lytics_widgets/manage` (a custom `lytics-widgetwiz` web component drives the wizard). Place the "Lytics Content Recommendation" block to render recommendations. The token is stored in `lytics.settings` config; the recommendation and widget forms call the Lytics REST API server-side with that token.

---

- Inject the Lytics JS tag site-wide on non-admin routes.
- Personalize experiences for anonymous and authenticated visitors.
- Build Pathfora modal / bar / slideout widgets in a wizard.
- Target widgets to Lytics audiences (segments) evaluated client-side.
- Render published widgets only; draft/paused widgets are skipped.
- Add a Content Recommendation block per visitor interest.
- Choose an interest engine and content collection for recommendations.
- Limit or shuffle the number of recommendations shown.
- Exclude or include recently-viewed content in recommendations.
- Store the Lytics access token and account details in config.
- Optionally exclude logged-in admin users from tracking.
- Enable debug mode to load the non-minified Lytics tag.
- Pass additional tag configuration as raw JSON.
- View an (illustrative) Lytics analytics dashboard under Reports.
- Provide granular permissions for connection, widgets, recommendations and dashboard.
- Fetch available segments/collections/engines from the Lytics API server-side.
