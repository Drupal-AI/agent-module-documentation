<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Alias list on entity forms

All behavior lives in `alias_manager.module`. There is no admin settings form, no config object,
and no config schema — enabling the module is the only setup step.

## Install / enable

```
drush en alias_manager -y
```

Grant `administer alias_manager` to the roles that should see the alias list (permission is defined
in `alias_manager.permissions.yml`, `restrict access: true`). Optionally grant core's
`create url aliases` to roles that should also get the per-row Edit/Delete links.

## When the section appears

`alias_manager_form_alter(&$form, FormStateInterface $form_state, $form_id)` adds the section only
when **all** of these hold:

1. `$form_state->getFormObject()` is an `EntityFormInterface` (i.e. an entity add/edit form).
2. The entity's type ID is in `alias_manager_get_entities_definitions()` — every entity type whose
   definition `hasLinkTemplate('canonical')`.
3. `!$entity->isNew()` — existing entities only (nothing on the "add" form).
4. The current user `hasPermission('administer alias_manager')`.

## How the list is built

- The entity's URL is resolved with `$entity->toUrl()`; its `getInternalPath()` gives the source
  path used to look up aliases.
- Aliases are loaded from core storage:
  `\Drupal::entityTypeManager()->getStorage('path_alias')->loadByProperties(['path' => '/' . $entityPath->getInternalPath()])`.
  (Parameterized entity-query lookup — no raw SQL.)
- Each alias becomes a table row: `link` = `$alias->getAlias()`, `language` =
  `$alias->language()->getName()`, `operations` = an `#type => operations` element.

## Operation links

Edit/Delete links are added to a row **only if** the user also has `create url aliases`. They are
plain `Url::fromUserInput()` links to core's path admin routes:

- Edit: `/admin/config/search/path/edit/{alias id}`
- Delete: `/admin/config/search/path/delete/{alias id}`

The module performs no deletion or editing itself — those core routes carry their own access checks
and (for delete) confirm form / CSRF handling. Alias and language strings are placed in a
`#type => table` render array, so they are rendered through core's auto-escaping.

## Render structure

The section is a `#type => details` element titled "Alias manager", `#group => 'advanced'`
(vertical tab), `#open => FALSE`, containing a `#type => table` with headers Alias / Language /
Operations and `#empty` = "No alias found for this entity." The table gets class
`alias-manager-table`.

## Help page

`alias_manager_help()` handles `help.page.alias_manager` by reading the module's `README.md`
(`@file_get_contents(dirname(__FILE__) . '/README.md')`) and rendering it through the `markdown`
filter plugin when the `markdown` module is enabled, otherwise wrapping it in `<pre>`.
