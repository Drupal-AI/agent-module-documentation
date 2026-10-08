<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Webform Gmap Field (webform_gmap_field) — agent index

**Webform element** rendering a **Google Map**; records the clicked point's **lat/long** into the
submission. Version **1.1.1**. Core `>=8`. Depends on `webform`.
Settings at `/admin/config/services/webform_gmap_field`.

**Cost to plan for is Google, not code:** needs the Google Maps JS API → an **API key + billing**
(Maps Platform is paid past a free tier). Confirm: (1) the key is **referrer-restricted** so it
can't be lifted from your pages and spent elsewhere; (2) embedding third-party Google script on the
form page fits the site's privacy posture.

For capturing a point (not an address) on a form, it's the direct tool.