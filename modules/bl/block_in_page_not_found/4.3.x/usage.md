<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Block In Page Not Found adds a block **visibility condition** ("Page not found") so you can make any block appear only on the site's 404 / page-not-found responses.

---

The module provides a single core Condition plugin, `page_not_found_request` ("Page not found"), usable from any block's *Visibility* settings. The condition form adds one checkbox, "Show in page not found". When checked (`page_not_found = 1`), the condition's `evaluate()` returns TRUE only if the current request carries a 404 `exception` (status code 404) — so the block renders solely on the not-found page. When unchecked (default `''`/0) the condition returns TRUE unconditionally, i.e. it imposes no restriction. The setting is stored on the block config entity under `visibility.page_not_found_request.page_not_found`, and the condition adds a `url.path` cache context. There is no admin settings page, permission, service or Drush command — you configure it entirely through core's Block layout UI (`/admin/structure/block`) per block. This lets you build a custom 404 experience (search block, helpful links, contact CTA) out of ordinary blocks without a custom controller or template.

---

- Show a "helpful links" custom block only on the 404 page.
- Place a search block on the page-not-found page to help lost visitors.
- Display a "Report a broken link" contact CTA exclusively on 404s.
- Add a sitemap or popular-content block that appears only when a page is missing.
- Build a custom 404 experience from ordinary blocks instead of a custom error controller.
- Show a branded "Oops, page not found" marketing block on 404 responses.
- Add a "Back to homepage" call-to-action block on the not-found page.
- Surface recent articles or products on 404 to recover the visit.
- Display a promotional banner only when users hit a dead link.
- Combine with other visibility conditions (roles, pages) to fine-tune the 404 block.
- Negate the condition to hide a block on 404 pages (using the condition's Negate option).
- Show a language switcher on the 404 page for multilingual sites.
- Present a "Did you mean…" suggestions block on not-found pages.
- Keep a normal block on all pages while also placing a dedicated 404-only block.
- Add a support/helpdesk widget that only appears on error pages.
- Configure the 404-only visibility per theme through the block layout UI.
- Store the 404 visibility in exported block config for deployment (`visibility.page_not_found_request.page_not_found: true`).
- Show a custom illustration/hero block on the not-found page.
- Provide quick navigation menus specifically on 404 responses.
- Recover SEO/UX value from broken links by guiding users from the 404 block.
