<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configuring Comment Notify

- **Config UI:** `/admin/config/people/comment_notify` (route `comment_notify.settings`,
  form `CommentNotifySettings`, permission `administer comment notify`).
- **Config object:** `comment_notify.settings` (schema `config_object`). Everything the module
  does globally is driven by this one object — read/set it with `drush cget/cset` or
  `\Drupal::config('comment_notify.settings')`.

## Keys

| Key | Type | Meaning |
|---|---|---|
| `bundle_types` | sequence of strings | Which comment fields are enabled. Each entry is an `entity--bundle--field` identifier, e.g. `node--article--comment`. The checkbox only appears on comment forms for a bundle listed here. Default install: `['node--article--comment']`. |
| `available_alerts` | mapping `{1: bool, 2: bool}` | Which subscription modes the form offers. `1` = `COMMENT_NOTIFY_ENTITY` ("All comments"), `2` = `COMMENT_NOTIFY_COMMENT` ("Replies to my comment"). Default: both `true`. At least one must stay enabled. |
| `enable_default.watcher` | string | Default state of the notification select for commenters. Default install value `none` (the form's options are `0` No notifications, `1` All comments, `2` Replies to my comment). |
| `enable_default.entity_author` | boolean | Whether entity authors are subscribed to follow-up emails on their own content by default. Default `false`. |
| `mail_templates.watcher.<entity_type>.subject` / `.body` | label / text | Email sent to subscribed **commenters** ("watchers"). Provided per entity type (`node`, `taxonomy_term`). |
| `mail_templates.entity_author.<entity_type>.subject` / `.body` | label / text | Email sent to the **author of the commented entity**. Per entity type. |

Mail templates support tokens (module depends on `token`), e.g. `[node:title]`,
`[comment:author]`, `[comment:body]`, `[comment:url]`,
`[comment-subscribed:unsubscribe-url]`, `[site:name]`.

## Common tasks

- **Enable notifications on another bundle:** add its `entity--bundle--field` id to
  `bundle_types`, e.g. append `node--page--comment`.
- **Only offer "replies to mine":** set `available_alerts` to `{1: false, 2: true}` (keep at
  least one true).
- **Subscribe authors by default:** set `enable_default.entity_author: true`.
- **Change the default commenter selection:** set `enable_default.watcher` (e.g. `1` for
  "All comments").

Example (drush):

```bash
drush cset comment_notify.settings enable_default.entity_author 1 -y
drush cget comment_notify.settings bundle_types
```

Per-user default preferences are NOT in this config object — they live in `user.data`
(see [../api/service-and-hooks.md](../api/service-and-hooks.md)) and are edited on each
user's account form.
