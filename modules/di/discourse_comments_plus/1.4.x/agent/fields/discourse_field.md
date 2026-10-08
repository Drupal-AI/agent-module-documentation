<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# discourse_plus_field: field type, widget & formatter

## Base field
`discourse_comments_plus_entity_base_field_info()` (`.module`) attaches a revisionable,
translatable base field `discourse_plus_field` (type `discourse_plus_field`) to every **node**
bundle, with form display widget `discourse_plus_widget` at weight 100. `hook_install` also creates
a standalone `field_discourse_plus` field storage (cardinality 1) and, if the legacy
`discourse_comments` module exists, migrates the old `field_discourse` data.

## Field type — `Plugin/Field/FieldType/DiscourseField.php`
`@FieldType(id = "discourse_plus_field", default_widget = "discourse_plus_widget")`. Properties /
schema columns:

| Property | Type | Schema |
|----------|------|--------|
| `topic_id` | string | varchar(128), binary |
| `topic_url` | string | varchar(256), binary |
| `comment_count` | string | int, not null, default 0 |
| `push_to_discourse` | boolean | int(1) |
| `category` | integer | int(3) |

`isEmpty()` returns true when `topic_id` is NULL or `''`.

## Widget — `Plugin/Field/FieldWidget/DiscourseWidget.php`
`@FieldWidget(id = "discourse_plus_widget")`. Constructed with the API client, config factory and
route match. `formElement()` renders:
- `push_to_discourse` checkbox — default from `content_types_enabled_for_discourse[bundle]`.
- `category` select — populated from `DiscourseApiClient::getCategories()` when a base URL is set;
  default from `default_category` or the per-bundle `overridden_default_category_options[bundle]`.
- `topic_id`, `topic_url`, `comment_count` — all `#disabled` (read-only, populated after push).
- A warning item noting changes after the first publish do not sync back to Discourse.
The element is grouped into the node form `advanced` sidebar (`#group => 'advanced'`).

## Formatter — `Plugin/Field/FieldFormatter/CommentCountFormatter.php`
`@FieldFormatter(id = "comment_count_plus_formatter", field_types = {"discourse_plus_field"})`.
`viewElements()` outputs each item's `comment_count` as `#markup` — a simple numeric reply-count
display for the node.

## Notes for agents
- The field is created programmatically (base field + `field_discourse_plus` storage), not via
  config, so it does not appear as exportable field config.
- `topic_id` is the join key: `DiscourseApiClient::getNodeFromTopicId()` and
  `getTopicIdsWithComments()` query `node_field_data.discourse_plus_field__topic_id` directly.
- Populate/read values through the node entity API (`$node->get('discourse_plus_field')->topic_id`),
  as the push handler and comment block do.
