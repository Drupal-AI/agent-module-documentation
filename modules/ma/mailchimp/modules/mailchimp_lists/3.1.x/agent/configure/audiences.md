# Audiences, subscription field & merge vars

Config schema: `config/schema/mailchimp_lists.schema.yml`. All admin routes require
`administer mailchimp` (from the base module).

## Subscription field
Provides the **`mailchimp_lists_subscription`** field type. Add it to an entity (usually
`user`) via Manage fields. On its settings you pick the target Mailchimp audience, whether the
subscription is required/hidden, double opt-in, and which merge fields / interest groups are
exposed. Widgets: `MailchimpListsSelectWidget` (subscribe checkbox/select) and an info widget;
formatters render status or a subscribe control.

## Admin pages (routes)
| Route / path | Purpose |
|---|---|
| `mailchimp_lists.overview` — `/admin/config/services/mailchimp/lists` | List the account's audiences. |
| `mailchimp_lists.fields` — `/admin/config/services/mailchimp/fields` | Map Drupal fields ↔ Mailchimp merge variables. |
| `mailchimp_lists.refresh` — `/admin/config/services/mailchimp/list_cache_clear` | Reset the cached audience data. |
| `mailchimp_lists.update_mergevars` — `.../lists/update_mergevars/{entity_type}/{bundle}/{field_name}` | Batch push merge-var updates for existing subscribers. |
| `mailchimp_lists.webhook` — `.../lists/{list_id}/webhook` | Configure the audience's webhook so external changes sync back. |

## Altering data
Use the base module's hooks: `hook_mailchimp_lists_mergevars_alter()` and
`hook_mailchimp_lists_interest_groups_alter()` (see the mailchimp base module's hooks doc).
Subscribe/unsubscribe operations can be queued for cron via `mailchimp.settings.cron`.
