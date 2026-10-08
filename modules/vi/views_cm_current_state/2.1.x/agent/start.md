<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Views content moderation current state — agent index

Adds one Views field, **"Current state"** (plugin id `current_state_views_field`), that shows the
Content Moderation state of each row entity's **latest** revision (including an unpublished forward
draft), falling back to "Published"/"Unpublished" for non-moderated content. No config, no settings
form (`configure: null`), no permissions, no Drush, no plugin types of its own. Requires `views` +
`content_moderation`.

- **Add the field to a view / where it lives in the Views UI / config shape** →
  [configure/add-to-view.md](configure/add-to-view.md)
- **How the field handler works (latest-revision lookup, fallback, no-op query) and how it differs
  from core's `moderation_state`** → [plugins/current-state-field.md](plugins/current-state-field.md)

Key fact: the handler is registered in `views_cm_current_state.views.inc` via `hook_views_data()` on
the global `views` table (group "Content revision"), so it appears in **every** view. In a view's
config it is a field keyed `current_state_views_field` with `table: views`, `field:
current_state_views_field`, `plugin_id: current_state_views_field`.
