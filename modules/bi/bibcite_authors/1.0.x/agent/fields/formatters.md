<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Bibcite Authors — field formatters

Three formatter plugins, all extending `Drupal\Core\Field\FormatterBase`, all registered for the
`bibcite_contributor` field type. None declare settings, a settings form, or config schema — they render
directly. Each `viewElements(FieldItemListInterface $items, $langcode)` loops the field deltas and, per
item, reads `$item->target_id` (the Contributor entity id) and loads
`Drupal\bibcite_entity\Entity\Contributor::load($author_id)`. Names come from the Contributor's
`first_name`, `middle_name`, `last_name` fields via `->getString()` (each `trim()`-med).

## Plugins

### LastNameFirst — `bibcite_authors_last_name_first`
File `src/Plugin/Field/FieldFormatter/LastNameFirst.php`, label "Authors (Last name first)". No user
lookup. For each Contributor it emits `#markup = '<p>' . $last . ', ' . $first . $middle . '</p>'`
(middle prefixed with a space only when present). Skips items whose Contributor fails to load.

### LastNameWithLink — `bibcite_authors_last_name_with_link`
File `LastNameWithLink.php`, label "Authors (Last name first with link to user)". Same
`Last, First Middle` name string, but first runs an entity query to find a linked account:
`\Drupal::entityQuery('user')->accessCheck(FALSE)->condition('field_author', $author_id)->execute()`.
If the result is empty → plain `<p>…</p>`; otherwise wraps the name in
`<a href="/user/{uid}">…</a>` using `reset($user)` as the uid.

### LinkToUser — `bibcite_authors_authors_with_link_to_user`
File `LinkToUser.php`, label "Authors (with link to user)". Runs the same `field_author` user query. When
no account matches, it loads the Contributor and emits `First Middle Last` order in a `<p>`. When an
account matches, it loads that `User` and emits `<a href="/user/{uid}">` whose link text is the user's
`field_name` field (`$author->field_name->getString()`), i.e. the account's display name rather than the
Contributor's name.

## Prerequisite for linking

Linking requires user accounts to carry an entity-reference field named `field_author` that points at the
Contributor. That field is NOT created by this module — a site builder adds it to the User entity and
populates it. Without it, all three formatters simply render plain names.

## Install / use

1. `drush en bibcite_authors` (pulls in the `bibcite` dependency; Contributor entity is from
   `bibcite_entity`).
2. On a reference entity type's **Manage Display** (e.g. a Bibcite reference bundle), for the
   contributor/author field pick one of the three "Authors …" formatters. Also selectable as a field
   formatter in Views.
3. For profile links, add a `field_author` reference field to User accounts pointing at Contributors.

## Notes for agents

- Rendered name strings are set as plain-string `#markup`; Drupal's renderer passes such strings through
  `Xss::filterAdmin()`, so `<script>` and event-handler/`javascript:` attributes are stripped at output.
- The formatters have no settings — nothing to configure per display beyond choosing the plugin.
- `LinkToUser`'s linked branch shows the *user's* `field_name`, while the two others always show the
  Contributor's own name parts; pick the plugin accordingly.
