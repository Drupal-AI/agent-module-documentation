<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Announcements provides a fieldable, dismissible announcement content entity rendered into site regions with per-announcement visibility conditions.

---

Announcements defines an `announcements_announcement` content entity (revisionable, translatable, editorial/publishable) plus three config-entity building blocks: **Announcement Type** bundles (which can be flagged dismissible), **Style** entities (adding CSS classes to the rendered markup), and **Region** entities (display locations). Each announcement carries a title, body (text-with-summary), style reference, one or more region references, and a `visibility` field powered by the `condition_field` module — giving the same page/role/language condition system core Blocks use. Announcements are placed on the page by the derived **Announcements Region** block plugin (one block per region), which loads and renders the published, access-passing announcements for its region. Dismissible types render a close button whose click sets a per-announcement cookie via `js_cookie`, keeping the notice hidden for that visitor. The module supplies dynamic per-bundle permissions, an access control handler that also evaluates each announcement's visibility conditions, full revision routes/forms, and admin listings under Structure. It performs no external HTTP calls.

---

- Show a site-wide banner or alert to visitors on chosen pages.
- Create a dismissible cookie-notice or promotion bar users can close.
- Display a maintenance or downtime notice only on specific routes via visibility conditions.
- Target announcements to specific user roles (e.g. authenticated-only messages).
- Restrict an announcement to certain languages with the language condition.
- Group announcements into bundles (Types) with different dismissible behaviour.
- Style announcements (error / warning / information) with reusable Style entities and CSS classes.
- Place announcements in distinct page Regions via the derived Announcements Region block.
- Show the same announcement in multiple regions at once (multi-value region field).
- Publish/unpublish an announcement to control visibility without deleting it.
- Keep an edit history with revisions, revert, and revision-delete workflows.
- Translate announcement title/body/visibility into multiple languages.
- Schedule visibility with request/time-based condition plugins from other modules.
- Delegate announcement authoring to editors with per-bundle create/edit/delete permissions.
- Let editors manage only their own announcements ("own" permissions per bundle).
- Add custom fields to announcement bundles through Field UI.
- Theme individual announcements with granular template suggestions (by id, bundle, style, region, view mode).
- Render a rich body via a text format, with an optional summary.
- Build a rotating set of promotions by assigning several announcements to one region block.
- Override display per view mode using the block's configured display mode.
- Provide a cookie-persisted dismissal so a closed announcement stays hidden per browser.
- Expose announcements to Views via the entity's Views data integration.
- Manage Types, Styles, and Regions from dedicated admin listings under Structure > Announcements.
- Gate the announcement admin overview behind a dedicated overview permission.
