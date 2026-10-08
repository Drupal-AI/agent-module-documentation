<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Bundle name in tabs (bundle_tabs) — agent index

A single-hook module that **relabels the View / Edit / Delete local-task tabs** on **node** and
**taxonomy-term** pages to include the **bundle** (content type) or **vocabulary** name — e.g.
"Edit Article", "Delete Tags". Package `Administration`. **No** dependencies beyond core, **no**
routes, **no** permissions, **no** config, **no** services, **no** entities/plugins. Core
requirement `^8 || ^9 || ^10 || ^11`. License GPL-2.0-or-later. Version 1.0.3 (dir `1.0.x`).

- **The one hook, exactly what it changes, and how to translate the labels** →
  [hooks/local-tasks.md](hooks/local-tasks.md)

## What it actually is

- The whole module is `bundle_tabs.module` (two hooks). No `src/`, no `composer.json`, no
  `config/`, no `*.routing.yml` / `*.permissions.yml` / `*.services.yml` / `*.links.*.yml`.
- `bundle_tabs_help()` — standard `hook_help()` returning the About text and the translation tip.
- `bundle_tabs_menu_local_tasks_alter(&$data, $route_name, &$cacheability)` — the actual behavior.
  It reads the current route's `node` / `taxonomy_term` parameter and overwrites the first-level
  tab titles.

## Mechanism (from source)

- For a `node` route: `$label = $node->type->entity->label();` then sets
  `$data['tabs'][0]['entity.node.canonical'|'entity.node.edit_form'|'entity.node.delete_form']['#link']['title']`
  to `t('View @label' | 'Edit @label' | 'Delete @label', ['@label' => $label])`.
- For a `taxonomy_term` route: loads the vocabulary via
  `entityTypeManager()->getStorage('taxonomy_vocabulary')->load($term->bundle())->label()` and sets
  the equivalent `entity.taxonomy_term.*` tab titles the same way.
- Labels go through `t()` as a **`@label` placeholder → auto-escaped** and **translatable**. Only
  the first tab level (`tabs[0]`) and only these six specific tab route keys are touched; everything
  else is left untouched.

## Operate it

- `drush en bundle_tabs -y`. No configuration. Behavior is immediate on node/term pages.
- Translate wording at `/admin/config/regional/translate` — search for `View @label`, `Edit @label`,
  `Delete @label`. See [hooks/local-tasks.md](hooks/local-tasks.md).
