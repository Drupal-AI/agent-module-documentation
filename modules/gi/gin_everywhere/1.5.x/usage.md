<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Gin Everywhere extends the Gin admin theme's node-style edit-form layout (the sticky action bar plus the "advanced" meta sidebar) to every content entity's forms — media, taxonomy terms, users, custom entities and more.

---

Gin gives node add/edit forms a polished two-column layout, but only for a fixed list of routes. Gin Everywhere widens that coverage. It implements Gin's `hook_gin_content_form_routes_alter()` and appends the create/edit/revision/translation form routes for **every content-group entity type** on the site (`entity.<type>.add_form`, `.edit_form`, `.create_form`, `.override_form`, `.revision`, `.content_translation_add`, plus `<type>.add`), along with a handful of extras that don't fit the pattern (`block_content.add_page`/`add_form`, `entity.block_content.canonical`, `entity.media.canonical`, `entity.menu.add_link_form`, `entity.menu_link_content.canonical`). It also implements `hook_form_alter()` to build the Gin form structure those templates expect: it creates the `advanced` vertical-tabs group and a `meta` details group (Status/last-saved/author), moves the `status` checkbox to the footer, adds an *Authoring information* group, and relocates the path-alias widget into the advanced sidebar — but only when the request is genuinely a Gin content form and the active theme is Gin (or a Gin sub-theme). It requires the **Gin** theme (install-time `hook_requirements` blocks installing without it) and has **no configuration at all** — enabling the module is the entire setup.

---

- Give taxonomy term add/edit forms Gin's two-column layout and meta sidebar.
- Apply Gin's content-form styling to media entity edit forms.
- Make user profile edit forms use Gin's advanced sidebar and action bar.
- Bring Gin's polished form layout to custom (contrib/custom) content entity forms.
- Style block content (custom block) add/edit forms like Gin node forms.
- Show a Status/last-saved/author meta panel on non-node entity forms.
- Move the published checkbox into Gin's sticky footer on term/media/user forms.
- Surface Authoring information (author + created) in the advanced sidebar for owner entities.
- Relocate the URL alias (path) widget into the advanced sidebar on entities that support it.
- Provide a consistent editing UX across all entity types, not just nodes.
- Cover revision and translation add forms for content entities with Gin layout.
- Extend Gin styling to menu link content forms.
- Give commerce or other custom entities Gin's form treatment without custom theming.
- Standardise the admin editing experience for editorial teams across entity types.
- Enable a modern form layout everywhere with a single module and zero configuration.
- Keep custom entity forms visually aligned with core node forms under Gin.
- Improve usability of long term/media forms via Gin's sidebar grouping.
- Ensure new custom entity types automatically get Gin's layout (routes derived dynamically).
- Apply Gin's content-form enhancements to the block_content canonical/add pages.
- Provide the Gin "advanced" meta area on entities that were previously plain forms.
- Unify status/author metadata presentation across content entity forms.
- Avoid per-entity theme overrides just to match Gin's node-form styling.
