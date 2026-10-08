<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Hooks, theme & the entity-display override — y_branch

All runtime behavior lives in `y_branch.module` (three hooks) plus one entity subclass. There are no
routes, controllers or forms.

## `hook_entity_type_alter()` — swap the display class

`y_branch.module:13` (`y_branch_entity_type_alter`) replaces the class of the `entity_view_display`
config entity with `Drupal\y_branch\Entity\YBranchLayoutBuilderEntityViewDisplay`:

```php
$entity_types['entity_view_display']
  ->setClass(YBranchLayoutBuilderEntityViewDisplay::class);
```

This is site-wide (it applies to every `entity_view_display`, not just Branch). The subclass
(`src/Entity/YBranchLayoutBuilderEntityViewDisplay.php`) extends core
`LayoutBuilderEntityViewDisplay` and overrides only `buildSections()`:

```php
protected function buildSections(FieldableEntityInterface $entity) {
  if ($entity->hasField('field_use_layout_builder')
    && !$entity->field_use_layout_builder->value) {
    return [];
  }
  return parent::buildSections($entity);
}
```

Effect: any node carrying the boolean `field_use_layout_builder` (only the Branch bundle gets it, see
fields/fields.md) renders its Layout Builder sections **only when that field is TRUE**. When the
editor unchecks "Use Layout Builder", `buildSections()` returns an empty array and the node falls
back to the normal field-formatter rendering. This is the per-node LB on/off switch.

## `hook_theme()` — two template overrides

`y_branch_theme()` (`y_branch.module:22`) registers:

- `node__branch__lb` → template `templates/node--branch--lb.html.twig`, base hook `node`. The
  template prints `content|without('openy_branch_selector')` inside a `node__content` wrapper and adds
  the classes `node--lb`, `node--type-branch`, `node--type-branch--use-lb`.
- `page__node__branch` → template `templates/page--node--branch-lb.html.twig`, base hook `page`. It
  attaches the `y_branch/y_branch` library and simply includes
  `@y_lb/templates/page--node--landing-page-lb.html.twig` (delegates the whole page shell to `y_lb`).

These are theme suggestions; Drupal picks them for Branch nodes / the branch page respectively when
they match the standard suggestion pattern.

## `hook_form_FORM_ID_alter()` — attach CSS to the LB form

`y_branch_form_node_branch_layout_builder_form_alter()` (`y_branch.module:38`) attaches the
`y_branch/y_branch` library to the `node_branch_layout_builder_form` (the Layout Builder editing form
for Branch nodes). No other form change.

## Library

`y_branch.libraries.yml` defines a single library `y_branch/y_branch` (version 1.4) loading
`assets/css/y_branch.css` (theme group, preprocessed). Source SCSS is in `assets/scss/y_branch.scss`
with a Bootstrap-4 build pipeline declared in `package.json` (`npm run build`). No JS library.
