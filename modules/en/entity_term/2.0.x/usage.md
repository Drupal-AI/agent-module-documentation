<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Entity Term maintains a one-to-one relationship between entities of a configured bundle and taxonomy terms in a configured vocabulary. When a matching entity is created, it creates a term with the same label; when the entity's label changes, it renames the term; when the entity is deleted, it deletes the term. This lets you reference content (e.g. an "Organization" node) through taxonomy while keeping a single source of truth.
To avoid confusing editors, term edit forms for synced vocabularies get their name field disabled, the delete action hidden, and a validation guard that blocks label edits, directing editors to the source entity instead. Term links and the term canonical page are transparently pointed at the corresponding entity.
---
Install with `drush en entity_term` (requires `taxonomy`) and configure "entity term sets" at `/admin/config/system/entity_term` (permission `administer_entity_term`). Each set maps an entity type + bundle to a vocabulary. The module then reacts to entity insert/presave/delete hooks to keep terms in sync by label.
Two services drive the redirection: `TermViewSubscriber` (a response subscriber) redirects a synced term's canonical route to the matched entity's URL, and `TaxonomyPathProcessor` rewrites outbound term URLs to the entity's URL. Both, plus `hook_link_alter`, look up the target entity by label with `accessCheck(FALSE)` — but they only produce a redirect/link to the entity's own canonical URL, where normal entity access is enforced, so this does not itself disclose protected content.
---
- Install: `composer require drupal/entity_term && drush en entity_term -y` (needs taxonomy).
- Configure entity term sets at `/admin/config/system/entity_term` (perm `administer_entity_term`).
- Map an entity type + bundle to a target vocabulary.
- Creating a matching entity auto-creates a term with the same name.
- Renaming the entity renames its synced term.
- Deleting the entity deletes its synced term.
- Synced term edit forms disable the name field and hide delete.
- A validation guard blocks label edits on synced terms.
- Term canonical pages redirect to the source entity's page.
- Outbound term links are rewritten to the entity URL (via path processor).
- `hook_link_alter` replaces term links with entity links by label.
- Reference content through taxonomy while keeping one source of truth.
- Use synced terms in facets/fields that require a taxonomy reference.
- Redirects target the entity's own URL, where entity access still applies.
- Keep labels unique per bundle so the 1:1 match resolves correctly.
- Uninstalling stops sync but leaves existing terms in place.
