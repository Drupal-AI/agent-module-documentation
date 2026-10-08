<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Search Tracking logs the search terms visitors type into a configured search form, storing each keyword together with the client IP and timestamp so admins can review what people search for.

---

An admin form at `/admin/config/search/search-tracking/form-config` (role `administrator`) tells the bundled JavaScript how to find the search field — by form ID, form class, or URL parameter — plus the input name. On submit, `js/formData.js` sends the entered term as JSON to `POST /api/form-data`, whose controller inserts `{search, ip_address, created_on}` into the `search_tracking` table. The route requires `_permission: access content`; the insert is parameterized and values are capped at 100 chars. The results-display method exists but is not wired to a route (commented out).

---

- Log which keywords visitors search for on the site.
- Capture the client IP and timestamp for each search.
- Point the tracker at a search form by ID, class or URL param.
- Review popular search terms for content strategy.
- Attach the tracking JS to every page automatically.
- Configure the input name attribute of the search box.
- Store search history in a dedicated database table.
- Identify gaps where users search but find nothing.
- Track searches from a themed or custom search form.
- Feed keyword data into editorial planning.
- Support ID/class/URL-parameter capture modes.
- Record queries submitted via GET URL parameters.
- Gate the configuration form behind the administrator role.
- Understand visitor intent from real queries.
