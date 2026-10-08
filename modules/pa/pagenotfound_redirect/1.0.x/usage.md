<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Page Not Found Redirect shows visitors a meaningful, branded page when a non-existent URL or node is requested.

---

It exposes a configurable 404 controller at `/friendly-404` (`PageNotFoundController::display`, permission `access content`) that renders an admin-defined title, message and a list of link "buttons" and returns HTTP 404. The settings form (`/admin/config/system/pagenotfound-redirect`, `administer site configuration`) lets an admin edit the title/message and add label+URL rows for the buttons. A small logger service records each broken-URL hit to the `page_not_found_redirect` channel. You wire it up by setting the site's 404 page (system.site `page.404`) to `/friendly-404`.

Note for operators: the destination links are taken only from module configuration (editable by users with `administer site configuration`), not from the request. Keep that permission to trusted admins and use validated URLs.

---
- Replace the default plain 404 with a branded page
- Set a custom 404 title and message
- Add helpful navigation buttons to the 404 page
- Point the site's 404 handler at `/friendly-404`
- Give visitors links back to key sections after a dead link
- Localize the 404 wording via config
- Log every broken-URL hit for later review
- Identify frequently-hit missing URLs from the log
- Provide a search or homepage link on the error page
- Style the error page via the module's library
- Curate different helpful links for a campaign
- Improve UX for mistyped or expired URLs
- Present a 404 that still returns the correct 404 status code
- Add/remove link rows dynamically in the settings form
- Keep the 404 page uncached (max-age 0) for fresh content
