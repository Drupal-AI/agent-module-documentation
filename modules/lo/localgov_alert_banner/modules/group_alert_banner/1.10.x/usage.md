<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Group Alert banner is a submodule of LocalGov Alert Banner that integrates alert banners with the contrib Group module, so a banner can belong to a group or microsite both publicly and privately.

---

The submodule registers a `group_localgov_alert_banner` Group relation type (a `GroupRelationBase` plugin) whose derivative is generated per alert-banner bundle by `GroupAlertBannerDeriver`, each with an entity cardinality locked to 1. A `RouteSubscriber` clones the generic Group relationship add/create routes to friendlier paths `group/{group}/alert-banner/add` and `group/{group}/alert-banner/create` bound to this relation plugin. It adds a Group permission `access localgov_alert_banner overview` ("Access Alert banner listing page"), a `group_alert_banners` view listing each group's banners as an *Alert banner* tab on the Group page, and hook classes for block placement, entity handling, form alterations and LocalGov Microsites integration. When used with `localgov_microsites_group` the required Group permissions are configured automatically; otherwise grant "Entity: View any alert banner entities" to anonymous and authenticated group users and the listing permission to group admins, then place an Alert banner block near the top of the theme. Requires the `group` and parent `localgov_alert_banner` modules.

---

- Scope an alert banner to a single Group or microsite.
- Show group-specific emergency notices only to that group's audience.
- Add or create a banner directly from a Group page.
- List all of a group's banners on a dedicated *Alert banner* tab.
- Grant group admins access to the per-group banner listing.
- Let a multisite/microsites platform manage banners per site.
- Add banners to groups both publicly and privately.
- Keep each group's banner cardinality at one active relation.
- Integrate with the LocalGov Microsites distribution automatically.
- Reuse the parent module's bundles, moderation and permissions per group.
- Auto-place the banner block in the microsites base theme header.
- Separate national/regional alerts from local microsite alerts.
