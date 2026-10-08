<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Varbase Landing Page is a Varbase distribution feature that installs a **"Landing page (Paragraphs)"** content type (`landing_page`) whose body is a stacked list of Bootstrap Paragraph components rather than a single rich-text field. It ships as an install-time **recipe**: no runtime code beyond two form-alters.

---

The module's `hook_install()` runs `recipes/default`, which creates the `landing_page` node type and its fields, form/view displays, SEO defaults, pathauto pattern, rabbit-hole behaviour, translation settings, and role permission grants. The editorial payload is `field_lp_paragraphs` — an unlimited-cardinality `entity_reference_revisions` field targeting ~14 `bp_*` paragraph bundles (accordion, block, carousel, columns, image, modal, simple, tabs, view, webform, `from_library`, `text_and_image`) that come from the required `varbase_bootstrap_paragraphs` module; the paragraph widget is `paragraphs_previewer` with `paragraphs_features` (add-in-between, duplicate, split-text, delete-confirmation). Alongside it sit a `field_description` summary (string_long, maxlength 160), core `path`/`menu_link`, and SEO fields (`field_meta_tags` metatag firehose, `field_yoast_seo` real-time SEO) supplied via `varbase_seo`. Title editing gets a `length_indicator` (optimal 15–50 chars) and `advanced_text_formatter`. The recipe also sets pathauto pattern `[node:menu-link:parents:join-path]/[node:title]`, metatag defaults, rabbit-hole `display_page`, content-translation with an asymmetric-translation paragraph widget, and menu-UI availability on `main`. The module itself defines no routes, permissions, services, or plugins — it is pure configuration and composition. `core_version_requirement` is pinned to a single minor, `~11.4.0`.

---

- Install a component-based "Landing page" content type on a Varbase or plain Drupal 11 site.
- Build a marketing or campaign page from stacked, visually separate Paragraph components.
- Let editors add/reorder/duplicate Bootstrap paragraph components (accordion, carousel, tabs, columns, modal, webform, view…) on a page.
- Add a text-and-image hero/section component to a page.
- Compose a homepage out of reusable components instead of a single body field.
- Provide a page type where each component is independently styled and previewed.
- Reuse `from_library` paragraphs so a component can be shared across landing pages.
- Get SEO fields (meta tags, Yoast real-time SEO, page description) preconfigured on every landing page.
- Enforce an optimal title length with a live length indicator (15–50 chars) and a 160-char description limit.
- Auto-generate hierarchical URL aliases following the page's menu-parent path.
- Place a landing page directly into the `main` menu from the node form.
- Enable asymmetric translation — each language's landing page can have a different component structure.
- Grant editors/content-admins create/edit/delete/revision permissions on landing pages via the shipped recipe.
- Let content authors edit and delete their own landing pages (authenticated role grant).
- Keep landing pages promoted/sticky settings hidden and out of editors' way.
- Standardise landing-page structure and config across a multi-site Varbase estate.
- Ship a landing-page setup as an exportable, re-runnable Drupal recipe.
- Add modern page-building to an existing Varbase site without writing custom code.
- Use rabbit-hole to control what a landing page node does when viewed directly.
- Provide a preview-before-publish workflow for component-built pages.
- Adopt Varbase's landing-page conventions and editorial UX out of the box.
- Layer a component page type on top of an existing content model.
- Give marketing teams control over page layout without a developer.
- Serve as the canonical example of a Bootstrap-Paragraphs-driven content type.
