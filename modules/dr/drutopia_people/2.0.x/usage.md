<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Drutopia People ships a ready-made "Person" content type plus its fields, displays, a people listing view, a content-by-author view, URL patterns, a people_type taxonomy vocabulary, and role permission grants as installable configuration.

---

Drutopia People is a config-only Features module (bundle `drutopia`) from the Drutopia distribution. Apart from a tiny `drutopia_people.install` file it contains no PHP code, and it defines no routes, services, hooks, or permissions of its own. Enabling it imports a `people` node type (label "Person") for profile pages of staff, volunteers and contributors, together with a field set (title relabelled "Name", a required Summary, an optional Body, a "Bio" Paragraphs field, a Media image, a Position/job title string, a People type taxonomy reference, a Topics taxonomy reference, and Meta tags), a default form display, seven view displays (default, full, teaser, card, simple_card, small_card, search_index), a Search API index (`people`, database server), a `views.view.people` listing (page at `/people` titled "Our people", grouped by People type, rendered through the `teaser` view mode) plus a `views.view.content_by_author` view/block that lists nodes referencing a person through `field_authors`, pathauto patterns for people nodes and people_type terms, a `people_type` taxonomy vocabulary, an "Add person" action link on the listing, and Metatag/SEO wiring inherited from Drutopia. Config actions grant people create/edit permissions to the Drutopia `contributor`, `editor`, and `manager` roles. The only executable code is update hook `drutopia_people_update_8201()`, which installs the `views_plain` dependency. It is installed here as a dev checkout tracking the 2.0.x branch and pulls in the whole Drutopia dependency chain, so it is normally deployed through the distribution rather than on its own.

---

- Add a fully structured Person/people content type to a site without hand-building fields.
- Publish profile pages for staff, volunteers, board members, and contributors.
- Give each profile a required Summary that drives teaser and listing displays.
- Record a person's Position or job title in the `field_people_position` string field.
- Attach a portrait to profiles via the `field_media_image` Media-library reference (image bundle).
- Build rich biographies from Paragraphs (text, image, file) through the "Bio" `field_body_paragraph` field.
- Classify people with a site-defined People type term from the shipped `people_type` vocabulary.
- Tag people with cross-content-type Topics terms to show areas of experience or involvement.
- Manage per-profile SEO metadata through the Metatag `field_meta_tags` field.
- Present a paginated-free people listing page at `/people` grouped by People type.
- Let editors add profiles quickly via the "Add person" local action on the listing page.
- Show a person's authored content (articles/blogs) via the `content_by_author` view, keyed on `field_authors`.
- Render profiles consistently across contexts using the card, simple_card, small_card, teaser, and full view modes.
- Feed a dedicated `search_index` view mode into the Search API `people` index for searchable profiles.
- Generate clean profile URLs automatically (`people/[node:title]`) via pathauto.
- Generate clean taxonomy URLs for People type terms (`[term:vocabulary]/[term:name]`) via pathauto.
- Grant contributors the ability to create and edit their own people, and editors/managers to edit any person, through bundled config actions.
- Add People profiles to the site's main menu (the node type enables menu placement under `main`).
- Serve as the base "people" feature that other Drutopia site builds and features (e.g. article authors) reference.
- Provide a distribution-managed content model that upgrades in step with Drutopia rather than being hand-maintained.
