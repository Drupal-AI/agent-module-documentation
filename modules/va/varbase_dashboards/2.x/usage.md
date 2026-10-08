<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Varbase Dashboards adds a Layout Builder-based administrative dashboard on top of the Dashboard module, with enhanced blocks and a set of Views for content, drafts, activity, users and terms.

---

Varbase Dashboards extends the contrib Dashboard (drupal/dashboard) module to give administrators and editors a concise home screen for site administration. It ships block plugins (a "Varbase Dashboard User" welcome block, a "My Site Overview" content/comment count block, and an extensible dashboard-block deriver with an "Add content" menu plugin), a set of Views (all content, content in draft, recent changes, recently created, terms, users, scheduled publishing content), and a default `dashboard` layout that arranges them via core Layout Builder. An install recipe provisions the default dashboard and supporting Views, restricts the available Layout Builder blocks and layouts, and grants a graded set of dashboard permissions to the standard Varbase editorial roles. It targets Drupal ~11.4 and is designed for the Varbase distribution but can be installed on any Drupal 11 site.

---

- Give administrators a single Layout Builder-based dashboard as their admin landing page.
- Show a personalized "Welcome back" block with a link to edit the current user's account.
- Display a "My Site Overview" table of published node counts per content type.
- Show comment counts (and optional spam/unpublished comment counts) alongside content counts.
- Offer editors a configurable "Add content" quick-menu listing content types they may create.
- Include a destination parameter on add-content links so users return to the dashboard after creating content.
- List all site content in a Views block with title, author, created, changed and status columns.
- Surface content currently in draft (content-moderation) for editorial follow-up.
- Show each user only their own drafts via the "by user" permission variants.
- Present a "recent changes" activity feed of edits across the site.
- Present recently created content for quick review.
- List taxonomy terms and users in dedicated dashboard Views blocks.
- Show scheduled/publishing content awaiting publication.
- Restrict which Layout Builder blocks and layouts editors can add to the dashboard (via layout_builder_restrictions).
- Grade dashboard visibility by role using the module's ten "access varbase dashboards ..." permissions.
- Apply Gin- or Claro-specific layout templates for a polished admin dashboard appearance.
- Add a Dashboard link to the Navigation sidebar when the core Navigation module is enabled.
- Extend the dashboard with custom widgets by implementing the VarbaseDashboard plugin type.
- Provision the whole setup (dashboard, Views, role permissions) automatically through the bundled install recipe.
- Use as the administration home when building a site on the Varbase distribution.
- Enable on a standard or minimal Drupal 11 profile to get a ready-made admin dashboard.
