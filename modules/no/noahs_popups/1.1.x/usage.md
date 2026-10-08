<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Noahs Popups lets you create popups and modals with the Noahs page builder easily.

---

It extends `noahs_page_builder` with a dedicated popup entity stored in the `noahs_page_builder_popups` table. Admins create popups (`/admin/structure/noahs/create-popup`), edit them in the visual builder (`/noahs-admin/noahs-popup/{editor}/{type}`), preview them in an iframe, toggle their status and delete them — all gated by the `administer noahs_page_builder` permission. Built popup markup is then rendered to visitors through `/noahs-popup/render/{noahs_id}` (permission `access content`), which loads the saved sections and returns the generated popup HTML.

The save endpoint (`NoahsPopupsBuildController::savePopupSettings`, POST `/noahs-popup-admin/save-popup`) declares both `_access: 'TRUE'` and `_permission: 'administer noahs_page_builder'`; because Drupal ANDs route requirements, the redundant `_access: 'TRUE'` does not weaken it — the endpoint remains admin-gated. Typical setup is to enable the module alongside Noahs Page Builder, build a popup, toggle it active, and let the front-end render route/JS display it to visitors.

---
- Create a marketing or announcement popup
- Build a modal with the visual Noahs page builder
- Preview a popup in an iframe before publishing
- Toggle a popup active or inactive
- Delete an unused popup
- List all configured popups in the admin UI
- Render a popup to anonymous site visitors
- Store per-language popup settings
- Save custom CSS for a popup
- Set a popup width/height and content layout
- Add a call-to-action overlay to a campaign
- Manage newsletter-signup modals
- Show a cookie/consent-style notice popup
- Reuse the Noahs builder's sections/controls inside a popup
- Localize popup content per language
- Provide a close button styled with an icon
