<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Drutopia Organization is a config-only Features module that ships a ready-made Organization content type, listing view and taxonomies for profiling groups, nonprofits and businesses on a Drutopia site.

---

It carries only configuration — no PHP, routes, services, hooks, or permissions of its own. Enabling it imports an `organization` node type with a required summary, a body, a paragraph-based Description field, an image with focal-point cropping, an organization_type taxonomy reference, a topics reference and meta tags; a default form display and five view displays (default, full, teaser, small_card, search_index) laid out with Display Suite; a Search API database index and a `view.organization` listing view mounted at `/organization`; an organization facet; two pathauto URL patterns; `organization` and `organization_type` taxonomy vocabularies; an "Add organization" action link on the listing; and a config action granting create/edit-own/delete-own organization permissions to the Drutopia contributor role. It also provides optional config that adds a `field_organization` node-reference field to the Event content type so events can name their host organization. It builds on drutopia_core, drutopia_event and drutopia_seo plus supporting contrib (paragraphs, inline_entity_form, facets, focal_point, field_group, ds, pathauto, metatag, search_api). Because everything is configuration, access to organization nodes follows standard node permissions and whatever editorial workflow you configure; setup is simply enabling the module (which pulls its dependencies) and then creating Organization nodes.

---
- Add an Organization content type to a Drutopia site.
- Build a browsable directory of nonprofits, businesses or groups.
- Associate organizations with events via the optional `field_organization` reference on the Event type.
- Present organization profiles with a focal-point image and paragraph-composed Description.
- Capture a required short Summary shown on teasers and cards.
- Categorize organizations with an `organization_type` taxonomy the site can filter on.
- Tag organizations with cross-content `topics` terms.
- Provide pathauto URL aliases (`organization/[node:title]`) for organization pages.
- Provide pathauto aliases for organization_type terms (`[term:vocabulary]/[term:name]`).
- Add Metatag/SEO meta tags to organization pages.
- Offer a Search API-indexed, faceted listing view at `/organization`.
- Group the listing by organization type using Views grouping.
- Show an "Add organization" action link on the listing view.
- Render organizations in multiple view modes (full, teaser, small card, search index).
- Feed organizations into a Search API database index for site search.
- Grant the contributor role create/edit-own/delete-own organization rights.
- Add organizations to the main menu (menu_ui enabled for the type).
- Preview organizations before publishing (preview mode enabled).
- Edit related paragraphs inline via inline_entity_form / ief_complex_open.
- Extend the type with additional paragraphs or fields like any content type.
- Reuse Display Suite layouts (ds_1col, ds_2col) for organization displays.
- Maintain organization content model as exportable Features configuration.
- Deploy the organization content type as part of the Drutopia distribution.
