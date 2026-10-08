<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Dashboards views is a small glue submodule that ships a ready-made "last content" View for use on dashboards, so you can embed a recent-content listing without building the view yourself.

---

This submodule of Dashboards contains no PHP plugins — it is config only. On install it provides the View `dashboard_last_content` ("Dashboard: Last content"), a `node_field_data`-based listing of recent content intended to be dropped onto a dashboard. You surface it on a dashboard using the base module's "Embed a view" widget (`dashboards_block:dashboard:view_embed`), whose `view` setting points at `dashboard_last_content:<display>`. The view's default display restricts access to the `administer nodes` permission and uses tag-based caching. It requires `views` and `dashboards`. Because it is just a view, you can clone or customize it (fields, filters, sort) like any other View and still embed it the same way. There is no settings form, configure route, permission, or Drush command; the deliverable is the shipped view.

---

- Embed a ready-made "recent content" listing on a dashboard without building a view.
- Show the latest nodes on an editorial dashboard via the `dashboard_last_content` view.
- Use the base "Embed a view" widget to place `dashboard_last_content` into a Layout Builder section.
- Give editors a quick "what changed recently" panel on their dashboard.
- Clone `dashboard_last_content` and tweak its fields/filters for a custom recent-content panel.
- Combine the recent-content view with statistics/comment widgets on one dashboard.
- Provide a starting-point view that teams adapt to their content model.
- Restrict the recent-content listing to users with `administer nodes` (its default access).
- Add a "latest articles" block to an admin landing dashboard.
- Reuse the same view across multiple dashboards by embedding it in each.
- Export the `dashboard_last_content` view with your site config for consistent deployments.
- Re-enable the shipped view if it was disabled, to restore the dashboard panel.
- Sort/limit the recent-content view to show, e.g., the 10 newest nodes.
- Pair the recent-content view with a "recent comments" panel for an activity overview.
- Serve as a template for building additional dashboard-oriented views.
- Keep dashboard content listings in Views (exportable) rather than hardcoded.
- Feed a stakeholder dashboard with a live recent-content feed.
- Filter the cloned view by content type for a per-section recent list.
- Demonstrate how a view is embedded into a dashboard with the view_embed widget.
