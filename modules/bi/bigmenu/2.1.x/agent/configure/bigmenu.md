<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configure Big Menu

Big Menu has **one** setting and no per-menu configuration. Its whole job is to replace
core's menu overview UI with a depth-limited version.

## The route it overrides

Big Menu does **not** add its own menu-editing page. It reuses core's existing route
`entity.menu.edit_form` at `/admin/structure/menu/manage/{menu}` and swaps the form class
that renders it. In `bigmenu.module`:

```php
function bigmenu_entity_type_alter(array &$entity_types) {
  $entity_types['menu']->setFormClass('edit', \Drupal\bigmenu\BigMenuForm::class);
}
```

So after enabling the module, editing any menu at `/admin/structure/menu/manage/{menu}`
renders `BigMenuForm` (a subclass of `menu_ui`'s `MenuForm`) instead of the core form.
Disabling the module instantly restores the core menu overview form. Drilling into a branch
uses the same route with a query arg: `…/manage/{menu}?menu_link={plugin_id}`.

## Its own settings page

| | |
|---|---|
| Config UI route | `bigmenu.settings` (the `configure` route in `bigmenu.info.yml`) |
| Path | `/admin/config/bigmenu` |
| Permission | `administer site configuration` (core) |
| Config object | `bigmenu.settings` |
| Form class | `\Drupal\bigmenu\Form\BigMenuSettingsForm` |

## The only setting: `max_depth`

| Key | Type | Default | Range | Meaning |
|---|---|---|---|---|
| `max_depth` | integer | `1` | 0–10 (enforced by the form's `#min`/`#max`) | How many levels of the menu tree render at once on the edit form. `1` = top level only; each parent with children shows an "Edit child items" link to load the next level. |

The form field is a number input labelled "Max depth" ("The max depth to display on a menu.").
If `max_depth` is unset/`0`, `BigMenuForm` falls back to `1` (`$this->config->get('max_depth') ?: 1`).

### Read / set it with drush

```bash
# read
drush config:get bigmenu.settings max_depth

# set (e.g. show two levels at a time)
drush config:set bigmenu.settings max_depth 2 -y
```

Default install config (`config/install/bigmenu.settings.yml`) ships `max_depth: 1`, and
schema (`config/schema/bigmenu.schema.yml`) types it as a single integer under the
`bigmenu.settings` config object. There are no other keys.