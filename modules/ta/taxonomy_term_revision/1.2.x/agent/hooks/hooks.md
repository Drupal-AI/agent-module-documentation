<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Hooks implemented (`taxonomy_term_revision.module`)

Four procedural hooks carry all of this module's runtime behavior — there are no services.

## `hook_entity_base_field_info_alter`

For `taxonomy_term`, if the core `revision_log_message` base field exists it is re-configured to be
usable on the term form:

- label `Revision log message`, description "Describe the changes you have made."
- `setRevisionable(TRUE)`, default value `''`
- form display: widget `string_textarea`, weight `25`, `rows: 4`.

Effect: editors get a revision-log textarea on the term add/edit form.

## `hook_entity_presave` — forced new revision on EVERY term save

```php
if ($entity instanceof \Drupal\taxonomy\TermInterface) {
  $entity->setNewRevision(TRUE);
  $entity->setRevisionUserId(\Drupal::currentUser()->id());
  $entity->setRevisionCreationTime(\Drupal::time()->getRequestTime());
}
```

Applies to **any** `TermInterface` save — UI, API, migration, import, cron sync — with no
per-vocabulary or per-bundle opt-out. Expect `taxonomy_term_revision` /
`taxonomy_term_field_revision` tables to grow on sites that save terms programmatically. This is why
the revision list always has entries once the module is enabled.

## `hook_entity_type_alter` — Content Moderation handler for terms

```php
$entity_types['taxonomy_term']->setHandlerClass(
  'moderation', 'Drupal\content_moderation\Entity\Handler\ModerationHandler');
```

Core deliberately leaves the `taxonomy_term` moderation handler unset; this module sets it, which is
what lets a Content Moderation workflow target taxonomy terms. Only meaningful when the optional
`content_moderation` module is installed (it is **not** a declared dependency); the referenced class
must be available for a workflow to be applied to terms.

## `hook_help`

Provides help text on `help.page.taxonomy_term_revision` (About section). No behavior.
