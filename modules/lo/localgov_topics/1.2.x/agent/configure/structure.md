<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# LocalGov Topics — vocabulary, field, view, roles

Everything ships as config in `config/install` and `config/optional`. There is no settings form.

## Vocabulary — `taxonomy.vocabulary.localgov_topic`

| Key | Value |
|---|---|
| `vid` | `localgov_topic` |
| `name` | `Topic` |
| `description` | `Topic tags group together related content across all services` |

Manage terms at `admin/structure/taxonomy/manage/localgov_topic/overview`.

## Field storage — `field.storage.node.localgov_topic_classified`

| Key | Value |
|---|---|
| `field_name` | `localgov_topic_classified` |
| `entity_type` | `node` |
| `type` | `entity_reference` (target `taxonomy_term`) |
| `cardinality` | `-1` (unlimited) |
| `translatable` | `true` |

The storage is installed but **not** attached to any content type. To make a bundle topic-taggable,
add a field instance that uses this storage, e.g.:

```php
// Attach the topic field to node.page.
\Drupal\field\Entity\FieldConfig::create([
  'field_storage' => \Drupal\field\Entity\FieldStorageConfig::loadByName('node', 'localgov_topic_classified'),
  'bundle' => 'page',
  'label' => 'Topics',
  'settings' => ['handler' => 'default:taxonomy_term', 'handler_settings' => ['target_bundles' => ['localgov_topic' => 'localgov_topic']]],
])->save();
```

(Within LocalGovDrupal the attaching is normally done by the distribution's content-type modules.)

## Topics view — `views.view.topics` (optional config)

Installed only if Views is present. Base table `taxonomy_term_field_data`, filtered to
`vid = localgov_topic`.

| Display | Type | Notes |
|---|---|---|
| `default` (Master) | page-style, `access content` | Lists topic term names, linked to the term. |
| `entity_reference_1` "Private topics" | `entity_reference` | Selection view usable by topic reference fields; both published and unpublished. |
| `entity_reference_2` "Public topics" | `entity_reference` | Same, but filtered to `status = 1` (published terms only). |

Point a topic entity-reference field's handler at `views` → `topics:entity_reference_2` to let editors
pick only published topics.

## Roles integration — `localgov_topics_localgov_roles_default()`

`hook_localgov_roles_default()` returns, for `RolesHelper::EDITOR_ROLE`, the permissions
`create terms in localgov_topic`, `edit terms in localgov_topic`, `delete terms in localgov_topic`.
This only fires when the optional `localgov_roles` module is installed (it is not a dependency); on a
plain site you grant those core taxonomy permissions yourself at `admin/people/permissions`.
