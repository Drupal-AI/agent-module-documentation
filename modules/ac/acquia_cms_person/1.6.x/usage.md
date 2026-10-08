<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Acquia CMS — Person provides a ready-made **Person content type** with its fields, form and view displays, a `person_type` vocabulary, a People search/listing view with facets, and related configuration already built — one component of the Acquia CMS (Acquia Drupal Starter Kit) content model.

---

Acquia CMS is Acquia's Drupal distribution, assembled from small single-purpose feature modules like this one. Rather than a site builder creating a structured person/staff-profile type from scratch — the fields (Bio, Job Title, Image, Email, Telephone, Person Type, Place, Categories, Tags), the widgets, the six view modes, the pathauto pattern, the schema.org Person metatags, the editorial workflow and scheduler settings, and the faceted People listing — this module ships all of that as installed config, so the Person type exists and is editor-ready the moment it is enabled. The only PHP is thin install/update glue: it grants the Person node permissions to the family's `content_author`/`content_editor` roles and runs a handful of `hook_update_N` migrations. There is no settings form, no service, no drush command.

The value and the limitation are the same fact: it is **distribution configuration, not a generic feature**. It encodes Acquia's opinions about what a Person is, wires into `acquia_cms_common` (workflow, metatag, the `acquia_cms_common.utility` service) which it pulls in transitively through its `acquia_cms_place` dependency, and expects sibling types such as `place`, `categories` and `tags` to exist. On an Acquia CMS site it is exactly right; on an unrelated site it is a strong set of assumptions to adopt — usable as a starting point, but you inherit the whole model and its siblings.

Because it is configuration, what it does is fixed by that config. Extending it means adding fields and adjusting displays as you would for any content type; it travels with a config export like any other content-type configuration.

---
- Add a ready-made Person content type to an Acquia CMS site.
- Author structured person/staff profiles with a consistent set of fields.
- Get Person fields (Bio, Job Title, Image, Email, Telephone, Person Type, Place) pre-configured.
- Categorize people with the `person_type` taxonomy vocabulary.
- Reference a Place node from a person via `field_place`.
- Provide editors a ready Person edit form with Media and Taxonomy field groups.
- Get six Person view displays (default, card, horizontal_card, referenced_image, search_results, teaser) out of the box.
- Publish a faceted People listing page at `/people` backed by Search API.
- Filter people by category and person type using the shipped facets/blocks.
- Apply the editorial content-moderation workflow to Person nodes.
- Schedule Person publish/unpublish with the scheduler integration.
- Emit schema.org Person, Open Graph and Twitter Card metatags for people.
- Generate clean `person/<type>/<name>` URLs via the pathauto pattern.
- Grant Person authoring/editing permissions to content roles automatically.
- Standardize Person content and its editing experience across a site.
- Enable Person as part of the Acquia CMS / Drupal Starter Kit stack.
- Base a custom person type on Acquia's model rather than building from scratch.
- Translate Person content (content translation enabled on the bundle).
- Export the Person configuration with the rest of the site config.
- Extend the Person type with extra fields and adjusted displays.
