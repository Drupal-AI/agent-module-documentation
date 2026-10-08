<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Site24x7 RUM injects the Site24x7 Real User Monitoring beacon script into your pages so front-end performance and real-user metrics are reported to your Site24x7 account. It supports the five Site24x7 datacentres and filters which pages and roles are monitored.

Use it to measure real-world page-load and front-end performance from your visitors' browsers via Site24x7.

---

Install and go to Administration > Configuration > System > Site24x7 (`/admin/config/system/site24x7`, permission `administer site24x7`). Paste your RUM key (validated to 24-34 alphanumeric chars) and pick your datacentre (US/EU/IN/AU/CN). The beacon domain is derived from the datacentre and the appKey (RUM key) is appended as a query parameter.

Restrict monitoring by pages (all-except-listed or listed-only, with wildcard paths) and by roles (include or exclude selected roles) - the visibility logic mirrors the Google Analytics module. 403/404 pages are always trackable. If the CSP module is present the module warns you to allow the Site24x7 datacentre in your `script-src-elem` directive.

---

- Add Site24x7 RUM beacon JS to your site.
- Report real-user front-end performance to Site24x7.
- Select one of five Site24x7 datacentres.
- Validate the RUM key format before saving.
- Append the RUM app key to the beacon URL.
- Monitor every page except a listed set.
- Monitor only a listed set of pages.
- Use wildcard path patterns for page targeting.
- Include specific roles in monitoring.
- Exclude specific roles from monitoring.
- Always track 403 and 404 error pages.
- Cache the attachment using config cache tags.
- Warn to update Content-Security-Policy when csp is installed.
- Prompt to register a free Site24x7 account when no key is set.
- Gate configuration behind the `administer site24x7` permission.
- Render help from the module README.
