<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Theme Negotiation by Rules (theme_rule) — agent index

Chooses the active theme per request from an ordered list of **theme rule** config entities. Each
rule pairs one target theme with a set of core **Condition plugins** (page path, content type, user
role, language, …). The module registers a single theme negotiator service
(`theme_rule.negotiator`, tagged `theme_negotiator` priority 10) that, on every request, loads the
enabled rules in weight order and returns the theme of the **first rule whose conditions all pass**
(AND logic). Rules are managed entirely through the admin UI at Appearance → Theme rules
(`/admin/appearance/theme-rules`) — there is no settings form and no code required. Any core, contrib
or custom `Condition` plugin (e.g. `route_condition`) is offered automatically; the module defines no
plugin type of its own.

- Depends on: nothing (info.yml declares no `dependencies`). Core: `^9.2 || ^10 || ^11`. No `package`.
  Installed version **1.2.1**.
- No `configure` settings route. All state is `theme_rule.rule.*` config entities edited through the
  entity UI (list / add / edit / delete / enable / disable).
- Permissions: uses only the **core** `administer themes` permission — it is the entity
  `admin_permission` and the requirement on every route. The module ships no `*.permissions.yml`.
- Provides config schema, one theme-negotiator service, one config entity type, a draggable list
  builder, an entity form, and one alter hook. No drush commands, no permissions of its own.

## What you'd do → where

- **Create / order / enable / disable rules; the config entity shape and the condition config keys** →
  [configure/rules.md](configure/rules.md)
- **How negotiation actually resolves; the negotiator service & entity API; write a custom condition
  plugin** → [api/negotiation.md](api/negotiation.md)

## Key facts (real machine names)

- Config entity type: `theme_rule` (`Entity\ThemeRule`, `ConfigEntityBase`), `config_prefix: rule` ⇒
  config objects `theme_rule.rule.<id>`; `admin_permission = "administer themes"`; entity keys
  `id`/`label`/`status`/`weight`; exported keys `id, label, status, theme, weight, conditions`.
- Service: `theme_rule.negotiator` — `Theme\ThemeRuleNegotiator` (implements
  `ThemeNegotiatorInterface`), tag `theme_negotiator` **priority 10**; args `@entity_type.manager`,
  `@context.repository`, `@context.handler`.
- Routes (all require `_permission: 'administer themes'`): `entity.theme_rule.collection`
  (`/admin/appearance/theme-rules`), `theme_rule.rule_add` **and** the auto-generated
  `entity.theme_rule.add_form` (both `/admin/appearance/theme-rules/add`), `entity.theme_rule.edit_form`
  (`/…/manage/{theme_rule}`), `entity.theme_rule.delete_form` (`…/delete`),
  `entity.theme_rule.enable` / `entity.theme_rule.disable` (`…/{op}`, each adds `_csrf_token: 'TRUE'`).
- Controller: `Controller\ThemeRuleStatusController::toggleStatus` (+ `getStatusOperationTitle` title
  callback) — backs the enable/disable routes.
- Form: `Form\ThemeRuleForm` (used for `add` and `default`); delete uses core `EntityDeleteForm`.
  List builder: `ThemeRuleListBuilder` (extends `DraggableListBuilder`), form id
  `theme_rule_collection_form`.
- Hook: `theme_rule_plugin_filter_condition__theme_rule_alter` (`theme_rule.module`) — removes the
  `current_theme` condition from the rule form, and removes `language` when the site is not
  multilingual.
- Library: `theme_rule/conditions` (`js/theme_rule.js`; deps `core/jquery`, `core/drupal`) — vertical
  tab summaries on the rule form.
- Local task: `theme_rule.rules` (tab on `system.themes_page`, weight 110). Action link:
  `theme_rule.rule_add` on the collection page.
- Config schema: `theme_rule.rule.*` (keys `id`, `label`, `theme`, `weight`,
  `conditions` = sequence of `condition.plugin.[id]`).
