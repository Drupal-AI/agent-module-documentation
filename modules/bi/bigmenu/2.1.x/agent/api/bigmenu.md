<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Big Menu — programmatic surface

Big Menu exposes **no services, public API functions, plugins, or hooks of its own**. Its
programmatic surface is (1) the `bigmenu.settings` config object and (2) the `BigMenuForm`
class it substitutes for the core menu edit form. This doc covers both.

## Read / write the config programmatically

```php
// read
$depth = \Drupal::config('bigmenu.settings')->get('max_depth') ?: 1;

// write (mutable)
\Drupal::configFactory()->getEditable('bigmenu.settings')
  ->set('max_depth', 2)
  ->save();
```

`max_depth` is the only key (integer, default 1). `BigMenuForm::buildOverviewForm()` reads it
via the injected `config.factory` and passes it as the tree depth.

## How the override works

`bigmenu_entity_type_alter()` sets the `menu` entity's `edit` form handler to
`\Drupal\bigmenu\BigMenuForm`:

```php
$entity_types['menu']->setFormClass('edit', \Drupal\bigmenu\BigMenuForm::class);
```

`BigMenuForm extends \Drupal\menu_ui\MenuForm`. It overrides `buildOverviewForm()` to build a
*shallow* overview: it loads the menu tree only to `max_depth` (via `MenuTreeParameters`),
and, when a `?menu_link=<plugin_id>` query arg is present, roots the tree at that link and
adds a breadcrumb back to the top. Parents that have children (checked with the protected
`hasAnyChildren()` helper, so branches whose children are all disabled still show it) get an
"Edit child items" link that reloads the edit form rooted at that link. Save behavior is
inherited from `MenuForm` (plus a redirect back to the current destination).

## Extending it

To customize the depth-limited editor, subclass `BigMenuForm` and re-point the `menu`
entity's `edit` form class from your own module's `hook_entity_type_alter()` (run after
bigmenu). Useful override points, all `protected`:

| Method | Role |
|---|---|
| `buildOverviewForm(&$form, $form_state)` | Entry point; reads `max_depth` and delegates. |
| `buildOverviewFormWithDepth(&$form, $form_state, $depth, $menu_link)` | Builds the shallow tree table for a given depth/root. |
| `getTree($depth, $root = NULL)` | Loads + access-checks + sorts the tree via the menu tree service. |
| `processLinks(&$form, &$links, $menu_link)` | Maps built tree rows into the draggable table, adding the "Edit child items" link. |
| `hasAnyChildren(MenuLinkTreeElement $element)` | TRUE if a link has any children (enabled *or* disabled). |

Because the module only swaps a form class, there is nothing to call at runtime and no event
to subscribe to — behavior is changed entirely through the config value and (optionally) a
subclass.