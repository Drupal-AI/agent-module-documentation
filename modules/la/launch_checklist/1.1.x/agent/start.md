<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Launch Checklist (launch_checklist) — agent index

Pre-launch checklist **inside Drupal**, built on **Checklist API** (`checklistapi`). Package `SEO`.
Version **1.1.13**. Core requirement `^9.3 || ^10 || ^11`. No PHP, JS, or library dependencies of its own.

## What it actually is

The entire module is one implementation of `hook_checklistapi_checklist_info()` plus a set of
plain-array `.inc` files that define the items. There is **no `src/`, no controller, no route of its
own, no permission of its own, no service, no config schema.** Checklist API does all the work:

- `launch_checklist.module` registers a checklist keyed `launch_checklist`, titled *Launch checklist*,
  mounted by Checklist API at `/admin/config/development/launch-checklist`
  (`configure: checklistapi.checklists.launch_checklist`), with `#callback`
  `launch_checklist_checklistapi_checklist_items()`.
- That callback assembles **14 sections** from `inc/section_01_general.inc` … `inc/section_14_printability.inc`,
  each returning a static render-style array of items (`#title`, `#description`, and one or more
  `handbook_page` links).
- `inc/routes.inc` builds the link targets: for a set of well-known contrib modules (metatag,
  redirect, google_analytics, google_tag, simple_sitemap, xmlsitemap, seckit, security_review,
  eu_cookie_compliance, real_aes, webform, unused_modules, plus core field_ui/views_ui) it links to
  the **local settings route if that module is enabled**, otherwise to the **drupal.org project page**
  (opened in a new tab). All URLs are static, built via `Url::fromRoute()` / `Url::fromUri()`.
- `launch_checklist.install` — `hook_uninstall()` deletes `checklistapi.progress.launch_checklist`.
- `config/optional/tour.tour.launch-checklist.yml` — an optional Tour entity (only active if the core
  Tour module is present). `launch_checklist.links.menu.yml` adds an admin-config menu link.

## The 14 sections

General · Browser Checks · Forms · SEO · User Permissions · Content · GDPR and Privacy ·
Performance and Security · Database · Theme · Accessibility · Drupal Modules · Other · Printability.

Representative real items: verify site email/name and favicon; analytics installed; XML sitemap;
page titles & meta tags; Schema.org; spam protection on forms; privacy/cookie policy; page/CSS/JS
aggregation & caching; unused/dev/tracking modules disabled; audit upload-field extensions; HSTS;
private files directory; RealAES; database/daily backups; image alt tags, color contrast, headings;
Lighthouse/Screaming Frog audits; cron job; notification email; status-report errors & warnings;
logging/error reporting; search-and-replace testbed URLs.

## State & audit trail

Checkbox state lives entirely in Checklist API: **checking items and clicking *Save* writes the
timestamp and the acting user** into config `checklistapi.progress.launch_checklist`. Because it is
config, completion state is **exportable via configuration synchronization** and can be committed to
version control. Access is gated by Checklist API's own permission
(`edit launch_checklist checklist`), i.e. admin-only.

## Two things worth attaching

1. **A checklist is a memory aid, not a test.** Ticking "Analytics" records a **claim** — a site with
   every box checked can still be broken. The items worth having are the ones someone genuinely
   **verifies**.
2. **Edit the list to the organisation.** A generic checklist is a starting point; the items that
   catch real problems are **the ones added after the last launch went wrong**. Because the items are
   plain arrays in `.inc` files, tailoring the list means forking or patching the module. The value
   compounds only if someone maintains it.
