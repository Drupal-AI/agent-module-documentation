<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Layout Builder Sections Access adds two per-section options in core Layout Builder — deactivate a section, or restrict its rendering to selected roles.

---

Install with `composer require drupal/layout_builder_sections_access` and enable it (`drush en layout_builder_sections_access`); its only dependency is core **Layout Builder**, and there is **no settings page**. The options appear when you **Configure** a section in the Layout Builder UI, inside an **Access** fieldset: a **Disable this section in front end** checkbox and a **Roles** multi-select. Disabling removes the whole section from the rendered page for everyone; selecting one or more roles shows the section only to users who have **at least one** of them (select none to show it to all). The important layer to understand: this controls whether a section is **rendered**, by role — and it does so **server-side**, removing the section's content from the HTML for non-matching viewers (via `unset($variables['content'])` in `hook_preprocess_layout`, weighted to run late), so it is better for privacy than a CSS `visually-hidden` trick. It is section-render visibility, **not** entity/field access control: any block in a restricted section still has its own access, and content that is also reachable another way (its own URL, JSON:API, or a second placement) is not protected by the section setting — back genuinely sensitive content with the block's or entity's own access. Who can set the options is governed by core Layout Builder permissions (`configure any layout` / `configure all layouts`); the module adds none of its own.

---

- Restrict a Layout Builder section to selected roles.
- Deactivate a section without deleting it.
- Show a whole section only to editors or another role.
- Hide a marketing/CTA section from anonymous users.
- Build role-targeted page layouts.
- Temporarily switch a section off in production.
- Remove restricted section content from the HTML (not just CSS-hidden).
- Set the options from the section Configure form's Access fieldset.
- Select multiple roles (OR match: any one grants the section).
- Leave roles empty to show a section to everyone.
- Combine disable + role settings on the same section.
- Set the config in code via a Section's layout settings (`layout_builder_sections_access_config`).
- Apply role visibility in a default entity view display layout.
- Keep restricted content out of a non-matching user's page cache (role cache contexts).
- Understand it is render-visibility, not deep access control.
- Back sensitive content with the block's or entity's own access.
- Confirm restricted content is not reachable via its own URL or JSON:API.
- Gate who can configure sections with core Layout Builder permissions.
- Use with any layout plugin (one-column, two-column, etc.).
- Preview shows disabled/role-restricted sections dimmed with a label in the LB UI.
- Verify by viewing the page as a non-matching role and checking the markup.
- Provide a privacy-friendly alternative to `visually-hidden` section hiding.
