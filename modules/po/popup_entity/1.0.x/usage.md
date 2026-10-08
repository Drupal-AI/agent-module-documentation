<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Popup Entity introduces a fielded "Popup" content entity type; each active popup is rendered as a configurable, dismissible modal that appears on the page.

---

Editors create popup entities and configure per-popup presentation: width/height (as CSS percentages), on-screen position (`position_x`/`position_y` → CSS classes), open delay, how many times to show it (`times_to_show`), cookie expiration, and which theme breakpoints it should appear on. The module's `hook_page_bottom()` queries all published popups, filters them through `entity_content_visibility`'s visibility checker (so per-popup visibility rules apply), and renders the visible ones in the page bottom. A bundled behavior (`popup.js`) shows/hides each popup, honors breakpoint media queries, and tracks a per-popup view count in a cookie so a popup stops showing after its configured number of impressions; a close button dismisses it. Cache contexts/tags from the visibility service and the theme are merged for correct caching.

Entity operations are permission- and access-gated: routes for add/edit/delete/view use `_entity_access`/`_entity_create_access` backed by `PopupAccessControlHandler`, which grants on the entity's admin permission or the granular `add/edit/delete/view popup entity` permissions; settings and the collection list require `administer popup entity`. Popup content itself is rendered through the standard entity view builder (fields are output via their normal, sanitized formatters). Typical setup: grant the popup permissions, create a popup entity with content and display settings, set its visibility conditions, and publish it.
---
- Show a site-wide announcement or promo as a modal popup
- Create multiple popups as manageable content entities
- Configure popup width/height as percentage of the viewport
- Position a popup (top/middle/bottom, left/middle/right)
- Delay a popup's appearance by a configurable time
- Limit how many times a visitor sees a popup (cookie-tracked)
- Set cookie expiration to control the impression window
- Restrict a popup to specific theme breakpoints (responsive)
- Use entity_content_visibility rules to target where popups appear
- Let editors dismiss/close popups with a close button
- Manage popups from an admin content collection list
- Gate popup create/edit/delete/view with granular permissions
- Theme popups via per-view-mode / per-id template suggestions
- Render arbitrary fields inside a popup via view modes
- Publish/unpublish popups with the status flag
- Provide GDPR-friendly consent or notice modals
- Show newsletter sign-up or lead-capture modals
- Cache popups correctly using visibility + theme cache metadata
