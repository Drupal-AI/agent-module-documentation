<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
A DEPRECATED, configuration-only Drutopia "feature" module that installs a Landing Page content type and its supporting configuration for building standalone pages such as a home page; the maintainers recommend the Page feature instead.

---

Drutopia Landing Page is a base feature (Features bundle `drutopia`) of the Drutopia distribution. It contains no PHP, routes, services, hooks, or permissions — everything ships as YAML under `config/install/` and `config/actions/`. Enabling it imports a `landing_page` node type, a paragraph body field (`field_body_paragraph`, an entity_reference_revisions field targeting the text/file/image/slide paragraph types), a Metatag `field_meta_tags` field, a default form display, a default and a Display Suite `ds_1col` "full" view display (plus a disabled teaser), a `[node:title]` pathauto pattern, a promote base-field override, an exclude_node_title configuration action, and config actions that add landing-page permissions to the Drutopia `editor` and `manager` roles. It builds on `drutopia_core`, `drutopia_seo`, Paragraphs, Display Suite, Exclude Node Title, Metatag and Pathauto.

The module is explicitly marked **DEPRECATED** in its own module name and description ("Use Page instead."), so it should not be chosen for new builds. Because it defines no code, access to landing pages is governed entirely by core per-bundle node permissions and the shipped display configuration. It is normally installed through the Drutopia distribution rather than standalone; on this site it is a dev checkout (no `version:` line in info.yml) and did not enable because its Drutopia dependency chain is absent, which is expected and does not affect these source-grounded docs. Typical legacy use is enabling it to obtain a ready-made, paragraph-composed landing/home page content type, then authoring paragraph content and meta tags per node.

---
- Provide a ready-made Landing Page content type (legacy Drutopia sites)
- Build a home page or marketing page as a landing_page node
- Compose page bodies from paragraphs (text, file, image, slide types)
- Add a paragraph body field (`field_body_paragraph`) to a page type
- Attach SEO meta tags to landing pages via the Metatag field
- Generate landing-page URL aliases from the node title via Pathauto
- Render the landing page body through a Display Suite `ds_1col` layout
- Exclude (user-selectable) the node title on landing pages in the full view mode
- Ship default, full, and (disabled) teaser view displays for the type
- Keep landing pages off the front page by default (promote override defaults to Off)
- Expose landing pages in the main menu (menu_ui available menu `main`)
- Grant the Drutopia `editor` role create + edit-any landing-page permissions
- Grant the Drutopia `manager` role create + edit-any landing-page permissions
- Provide a standalone page type distinct from Article/Blog content
- Bootstrap a Drutopia site's page-building content type as part of the distribution
- Serve as a base whose config a site can override or extend
- Reference an example Features/config-actions module structure
- Audit or understand deprecated config on an existing Drutopia site
- Plan and migrate legacy landing pages before moving to the Page type
- Reuse Drutopia SEO defaults on landing-page content
