<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
LocalGov Topics ships the shared "Topic" taxonomy used across the LocalGovDrupal distribution to tag and group related content, plus a node entity-reference field and a Topics view for listing/selecting terms.

---

The module is almost entirely configuration. Installing it creates a taxonomy vocabulary
`localgov_topic` ("Topic", "Topic tags group together related content across all services"), an
unlimited-cardinality node entity-reference field storage `field.storage.node.localgov_topic_classified`
targeting taxonomy terms, and (as optional config) a `topics` View with a default page-style master plus
two `entity_reference` displays ("Private topics" and "Public topics") that other modules/fields can use
as a reference selection view. The only PHP is `hook_localgov_roles_default()`, which — when the optional
`localgov_roles` module is present — grants the LocalGov Editor role the `create/edit/delete terms in
localgov_topic` permissions. There is no admin settings page (`configure` is null), no permissions
of its own, no services, plugins, or Drush commands. It depends only on core `taxonomy`; the field
storage is installed but not attached to any bundle, so you (or the wider distribution) attach
`field_localgov_topic_classified` / add the `localgov_topic_classified` field to the content types that
should carry topics.

---

- Provide a single shared "Topic" vocabulary for tagging content across many LocalGov services.
- Tag nodes with one or more topic terms via the `localgov_topic_classified` entity-reference field.
- Group related content from different content types under a common topic.
- Build topic landing/hub pages that aggregate everything tagged with a given topic.
- Offer editors a consistent, cross-service taxonomy instead of per-section tag vocabularies.
- Use the bundled `topics` View as a reference-selection widget source for topic fields.
- Restrict a topic reference widget to published topics using the "Public topics" entity_reference display.
- Expose all topics (including unpublished) to admin selection via the "Private topics" display.
- Auto-grant LocalGov Editors the ability to create/edit/delete topic terms (with `localgov_roles`).
- Seed a new LocalGovDrupal site with the standard topic taxonomy structure on install.
- Add the `localgov_topic_classified` field to a custom content type to make it topic-taggable.
- Drive faceted or filtered listings of content by topic term.
- Provide autocomplete selection of existing topics when authoring content.
- Standardise topic naming/description ("Topic tags group together related content across all services").
- Support multilingual topic tagging (the field storage is translatable).
- Integrate topics into search or menu structures built on the taxonomy.
- Reuse the vocabulary across the distribution's directories, services, and news content types.
- Migrate legacy category/tag data into the shared `localgov_topic` vocabulary.
- Build "related content" blocks that match on shared topic terms.
- Keep topic management permissions aligned with the distribution's role model.
