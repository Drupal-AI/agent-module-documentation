<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Manage Display — agent index

Makes entity **base fields** (`title`, `uid`, `created`, comment `subject`/`pid`, user `name`,
aggregator fields) display-configurable, and ships three formatters to render them.
No configure route (`configure: null`), no permissions, no Drush, no services, no plugin types.
Its only persistent state is the components it enables inside `core.entity_view_display.*`.

- **Which base fields become configurable, their defaults, and how to set them in config** →
  [configure/base-fields.md](configure/base-fields.md)
- **The three field formatters (`title`, `submitted`, `in_reply_to`) and their settings keys** →
  [plugins/formatters.md](plugins/formatters.md)
- **Theme hooks, templates and the render-time re-assembly of the "Submitted by" line** →
  [theming/templates.md](theming/templates.md)

Key facts:

- `title` formatter settings = `{tag: h2, link_to_entity: true}`; `submitted` = `{user_picture: ''}`;
  `in_reply_to` has no settings.
- Node defaults: `title` visible (`type: title`, `label: hidden`, `weight: -49`); `uid` and
  `created` default to `region: hidden`.
- The `submitted` formatter is only assembled into one sentence when it is on the entity type's
  **owner** key field (`uid`); `hook_entity_view_alter()` then absorbs `created` (and comment `pid`).
- Submodule `manage_display_fix_title` is **obsolete** and cannot be installed on Drupal 11 →
  [../../modules/manage_display_fix_title/3.0.x/agent/start.md](../../modules/manage_display_fix_title/3.0.x/agent/start.md)
