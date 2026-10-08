<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Block ARIA Landmark Roles adds a "Landmark role" select and an ARIA "Label" textfield to every block's configuration form, and renders the chosen values as `role` and `aria-label` attributes on the block wrapper.

---

The module is two hooks and one helper class. `hook_form_FORM_ID_alter()` on `block_form` injects a **Block ARIA Landmark Roles settings** details element containing a `role` select (`- None -` plus the eight WAI-ARIA landmark roles `application`, `banner`, `complementary`, `contentinfo`, `form`, `main`, `navigation`, `search`) and a free-text `label` field, both bound to the block entity's third-party settings. `hook_preprocess_block()` then loads the `Block` config entity for the rendered block, reads `getThirdPartySetting('block_aria_landmark_roles', 'role'|'label')`, and sets `$variables['attributes']['role']` (skipped when the value is empty or the literal string `none`) and `$variables['attributes']['aria-label']`. Storage is therefore the ordinary block config entity: `block.block.<id>` → `third_party_settings.block_aria_landmark_roles.role` / `.label`, validated by the module's config schema, which constrains `role` to the nine allowed choices. There is no settings form, no configure route, no permission of its own (editing blocks already requires *administer blocks*), no Drush command and no plugin. Because it works per block placement, the same block plugin can carry different roles in different themes or regions, and roles apply to any block — core, views, custom content or contrib.

---

- Mark the site branding/header block as `role="banner"` for screen-reader landmark navigation.
- Give the main menu block `role="navigation"` with an `aria-label` of "Main menu".
- Distinguish two navigation blocks with `aria-label` "Main menu" and "Footer menu".
- Mark the footer block as `role="contentinfo"`.
- Mark a sidebar "Related content" block as `role="complementary"`.
- Give the search block `role="search"`.
- Mark a page-level content block as `role="main"` in a theme that lacks a main landmark.
- Add `role="form"` to a block that wraps a standalone form (newsletter signup).
- Label an "advertisement" complementary block so assistive tech announces its purpose.
- Fix an accessibility audit finding about missing landmarks without touching templates.
- Add landmarks to blocks placed by contrib modules you do not want to patch.
- Provide different roles for the same block plugin in two different themes.
- Add an `aria-label` alone (no role) to disambiguate two identical blocks.
- Remove a role again by selecting `- None -`, which suppresses the `role` attribute.
- Export landmark settings with the block config so they deploy with the site.
- Set the role from code/config in a deployment update hook via `setThirdPartySetting()`.
- Audit which blocks have landmarks by reading `third_party_settings` across `block.block.*`.
- Keep landmark markup out of custom Twig overrides and in configuration.
- Support editors who place blocks via the UI but should not edit templates.
- Comply with WCAG 2.x "bypass blocks"/landmark navigation techniques.
- Give a chat or help widget block `role="application"` where appropriate.
- Combine with region templates that already provide semantic elements, adding roles only where missing.
- Roll out landmarks incrementally, block by block, as accessibility work progresses.

