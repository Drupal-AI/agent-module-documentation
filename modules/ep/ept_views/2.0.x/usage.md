<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
EPT Views adds an "EPT Views" paragraph type that embeds an existing Views display, so an editor can drop a listing into a page built from paragraphs.

---

It belongs to the **Extra Paragraph Types (EPT)** family and requires `ept_core`, `paragraphs`, and `viewsreference`; install it with `composer require drupal/ept_views` and enable it with `drush en ept_views` (the three dependencies come along), which creates a paragraph bundle called **EPT Views** with four fields — an optional title and intro (`field_ept_title` / `field_ept_text`), a required view picker (`field_ept_views_view`, a `viewsreference` field), and the shared ept_core design settings (`field_ept_settings`). To let editors use it, add a Paragraphs field to a content type (or other entity) and allow the **EPT Views** type; when authoring, the editor types to autocomplete a **view and display** in the picker, optionally adds a heading and intro text, and adjusts the design options (margins, padding, background, container width, title wrapper). There is **no module settings page** — configuration is the paragraph type's *Manage form display* / *Manage display* plus the `viewsreference` field settings, where `preselect_views` restricts which views are selectable (empty means all views, including administrative ones, so it is worth setting) and `enabled_settings` controls which per-placement options (title, arguments, pager, limit, …) the editor sees. At render the embedded view is executed and built by `viewsreference_formatter`; because it is returned as a Views core render element, the view still applies **its own display access check against the current viewer** and carries the view's cache metadata onto the host page. This version is **2.0.0**, core requirement `^10.1 || ^11 || ^12`.

---

- Embed a news listing in a landing page.
- Show recent articles on a campaign page.
- Add a staff listing to a department page.
- Show related documents in a section.
- Embed an events calendar view.
- Place a filtered product grid in a page.
- Show a taxonomy term's content inline.
- Add a case studies listing to a service page.
- Embed a publications view with a pager.
- Show upcoming courses on a homepage.
- Add a team listing component.
- Embed a search-results view.
- Show a project's related outputs.
- Add a resources listing to a guide.
- Embed a job-vacancies view.
- Show latest blog posts in a section.
- Add a partner/logo listing.
- Embed a testimonials view.
- Restrict editors to an approved set of views via `preselect_views`.
- Give one view display multiple placements without duplicating the view.
