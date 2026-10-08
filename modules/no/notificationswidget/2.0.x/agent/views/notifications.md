# Views — the notifications base table

`notifications_widget_views_data()` exposes the custom `notifications` table to Views so you can build
your own notification listings instead of (or beside) the block.

## Base table

`notifications` is registered as a Views **base table** (`base field: id`, group "Notifications"), so a
view can have "Notifications" as its base.

## Relationships (notification → source entity)

Each maps `notifications.entity_id` to the entity's id column, matched on bundle:

| Added on table | Joins to | Match (`bundle` = …) |
|---|---|---|
| `comment_field_data` | `notifications` (`entity_id` ↔ `cid`) | `comment_type` |
| `node_field_data` | `notifications` (`entity_id` ↔ `nid`) | `type` |
| `taxonomy_term_field_data` | `notifications` (`entity_id` ↔ `tid`) | `vid` |
| `profile` | `notifications` (`entity_id` ↔ `profile_id`) | `type` |
| `message` | `notifications` (`entity_id` ↔ `mid`) | `template` |

(The `profile` and `message` relationships assume the contrib Profile / Message modules provide those
base tables.)

## Fields / filters / sorts on `notifications`

| Field | Handlers |
|---|---|
| `id` | numeric field + filter |
| `entity_id` | numeric field, sort, filter, argument |
| `uid` | numeric field, sort, filter, argument (notification author/operator) |
| `user_name` | markup field (full_html) + string filter |
| `bundle` | markup field (full_html) + string filter |
| `message` | markup field (full_html) + string filter |
| `status` | numeric field + filter |
| `created` | date field, sort, filter |
