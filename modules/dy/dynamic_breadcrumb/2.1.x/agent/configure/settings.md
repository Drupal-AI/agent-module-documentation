<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Dynamic Breadcrumb — configuration

All admin surfaces require the core `administer site configuration` permission. There are no custom permissions, Drush commands, or config schema files.

## Admin menu hub
- Route `dynamic_breadcrumb.admin` → `/admin/config/user-interface/dynamic-breadcrumb` (a system admin menu-block page; the `configure` route in info.yml).
- Two child forms live beneath it (both `_admin_route`):
  - `dynamic_breadcrumb.dynamic_breadcrumb_entity_types_form` → `/admin/config/user-interface/dynamic-breadcrumb/entity-types`
  - `dynamic_breadcrumb.dynamic_breadcrumb_config_form` → `/admin/config/user-interface/dynamic-breadcrumb/general-settings`

## Step 1 — Entity Types form
`DynamicBreadcrumbEntityTypesForm` edits config object `dynamic_breadcrumb.entity_types_config`.

- Lists every content entity type that has a `canonical` link template, as checkboxes.
- Saves the chosen set under key `entity_types` (a map of `id: id` for checked, `id: 0` for unchecked).
- Ships with `config/install` defaults: `node`, `media`, `user` selected. (`taxonomy_term` can be added here too.)

Example config:
```yaml
# dynamic_breadcrumb.entity_types_config
entity_types:
  node: node
  media: media
  user: user
  taxonomy_term: taxonomy_term
```

## Step 2 — Breadcrumbs settings form
`DynamicBreadcrumbConfigForm` edits config object `dynamic_breadcrumb.settings`. It renders one collapsible `details` fieldset per entity type selected in step 1. Inside each fieldset, for every bundle of that type:
- a `checkbox` — enable dynamic labeling for that bundle;
- a `value` textfield (shown/required when the checkbox is on) — the label pattern, tokens allowed;
- a Token browser link (`token_tree_link`, provided by the `token` dependency) scoped to that entity type's token group.

Storage shape (bundle machine name with `_` rewritten to `-` as the key; the taxonomy_term group is stored under `term`):
```yaml
# dynamic_breadcrumb.settings
node:
  article:
    checkbox: 1
    value: '[node:title]'
  page:
    checkbox: 0
    value: ''
term:
  tags:
    checkbox: 1
    value: '[term:name]'
```

## Runtime behavior (`hook_system_breadcrumb_alter`)
`dynamic_breadcrumb_system_breadcrumb_alter()` runs only on these route names: `entity.node.canonical`, `entity.taxonomy_term.canonical`, `entity.media.canonical`, `entity.user.canonical`. For each link in core's already-built breadcrumb whose route is one of those:
1. loads the linked entity and reads its bundle;
2. maps `taxonomy_term` → `term` for the config/token key;
3. reads `dynamic_breadcrumb.settings` for that `type.bundle`;
4. if `checkbox` is true, runs `\Drupal::token()->replace(value, [type => entity], ['clear' => TRUE])` and calls `$link->setText(...)`, using the entity's own label as a fallback when the replaced value is effectively empty.

It edits existing breadcrumb link text only — it never adds, removes, or reorders links.

## Setup with Drush
Both config objects can be written directly (no schema, so validation is minimal):
```
ddev drush config:set dynamic_breadcrumb.entity_types_config entity_types.node node -y
ddev drush config:set dynamic_breadcrumb.settings node.article.checkbox 1 -y
ddev drush config:set dynamic_breadcrumb.settings node.article.value '[node:title]' -y
```

## Install note
`hook_requirements()` returns an install error if Easy Breadcrumb >= 2.0.7 is enabled — these features were merged into Easy Breadcrumb (issue 3421458), so the two are redundant.
