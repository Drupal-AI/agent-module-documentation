<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Theme By Author switches the active theme depending on the author of the page currently being viewed.

---

It adds a `theme` base field to user entities (a `list_string` whose allowed values are the installed themes, via `theme_by_author_get_allowed_themes()`), exposed on the user form. A theme negotiator (`theme.negotiator.theme_by_author`, priority 100) resolves the page's author and, if that user has chosen a theme, applies it. This lets each author present their content in a personal theme without any per-node configuration.

Operationally it is passive: there is no admin route or permission of its own — the only editable surface is the per-user "Theme" field on the user profile form (governed by normal user-edit access). No external calls or mutating endpoints.
---
- Let each author pick a personal theme for their content
- Set a user's theme on their profile edit form
- Automatically switch theme when viewing an author's page
- Limit choices to installed themes
- Give guest bloggers a distinct look
- Provide brand-per-author on a multi-author blog
- Leave theme empty to fall back to the site default
- Combine with content-type or path theming needs
- Hide the theme field from display while keeping it on the form
- Use the high-priority negotiator to override default theme
- Give editorial sections author-driven theming
- Support previewing content in an author's chosen theme
- Assign themes to columnists/contributors
- Avoid custom code for per-author theming
- Keep the theme field off the rendered profile display
- Apply an author theme across all of that author's nodes
- Support seasonal/campaign themes chosen per author
- Override lower-priority negotiators for author pages
