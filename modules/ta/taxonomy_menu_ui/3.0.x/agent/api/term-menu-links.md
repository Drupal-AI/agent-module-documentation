<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Term menu links — form, storage, access, tokens

## The term form addition

`taxonomy_menu_ui_form_taxonomy_term_form_alter()` adds `$form['menu']`, a `details` element
titled "Menu settings" (`#group: advanced`, `#tree: TRUE`, class `menu-link-form`, library
`menu_ui/drupal.menu_ui`), open when the term already has a link. Children:

| Form key | Type | Notes |
|---|---|---|
| `menu[enabled]` | checkbox | "Provide a menu link" |
| `menu[link][id]` | value | menu link *plugin* id (e.g. `menu_link_content:<uuid>`) |
| `menu[link][entity_id]` | value | the `menu_link_content` entity id, or `0` |
| `menu[link][title]` | textfield | max length from the base field |
| `menu[link][description]` | textfield | hover text |
| `menu[link][menu_parent]` | select | `<menu_name>:<parent plugin id>`, built by `menu.parent_form_selector` |
| `menu[link][weight]` | number | ordering |

It also adds the class `js-form-item-title-0-value` to `$form['name']` so core's
`menu_ui.js` auto-title behaviour (which expects a node `title` field) works against the
term's `name` field.

Early returns — the group is **not** rendered when the vocabulary's
`menu_ui.available_menus` is empty, or when `menu.parent_form_selector` yields no options.

## Access

```php
$access = \Drupal::currentUser()->hasPermission('administer menu');
// plus, only if the menu_admin_per_menu module exists:
//   TRUE when the user holds 'administer <menu_id> menu items' for any available menu.
```

The result is set as `$form['menu']['#access']`. The module itself declares **no
permissions** (`taxonomy_menu_ui.permissions.yml` does not exist).

## What gets written

Submit handler `taxonomy_menu_ui_form_taxonomy_term_form_submit()` (appended to every non-preview
submit action) plus entity builder `taxonomy_menu_ui_taxonomy_term_builder()` (which parks the
values on `$term->menu`):

- **Unticked + an existing `entity_id`** → `MenuLinkContent::load($entity_id)->delete()`.
- **Ticked with a non-empty trimmed title** → `_menu_ui_taxonomy_term_save()`:

```php
MenuLinkContent::create([
  'link' => ['uri' => 'internal:/taxonomy/term/' . $term->id()],
  'langcode' => $term->language()->getId(),
])->set('enabled', 1);
// then title, description, menu_name, parent, weight (default 0) — and, when the
// menu_item_extras module exists, bundle = menu_name.
```

`menu_parent` is exploded on the first `:` into `menu_name` + `parent` before saving. An
existing link is re-loaded and, if translatable, translated into the term's langcode rather
than duplicated.

## Finding a term's existing link

`taxonomy_menu_ui_get_menu_link_defaults($term)` queries `menu_link_content`:

1. First in the vocabulary's default menu (`strtok($parent, ':')`), matching
   `link.uri = 'taxonomy/term/<tid>'`.
2. Then across all `available_menus`, matching `link.uri = 'internal:/taxonomy/term/<tid>'`.

Both sort `id ASC`, range 0,1. Note the first query's URI lacks the `internal:` prefix, so in
practice it is the **second** query that matches links this module created. Returned array:
`entity_id, id, title, title_max_length, description, description_max_length, menu_name,
parent, weight` — or a zeroed default set with `menu_name` = the vocabulary default.

To find them yourself:

```php
$links = \Drupal::entityTypeManager()->getStorage('menu_link_content')
  ->loadByProperties(['link__uri' => 'internal:/taxonomy/term/' . $tid]);
```

## Creating a term link programmatically

The form is the only UI, but the end state is a plain entity — so this is equivalent:

```php
use Drupal\menu_link_content\Entity\MenuLinkContent;
MenuLinkContent::create([
  'title' => 'Cameras',
  'link' => ['uri' => 'internal:/taxonomy/term/' . $tid],
  'menu_name' => 'main',
  'parent' => '',
  'weight' => 0,
  'enabled' => 1,
  'langcode' => 'en',
])->save();
```

## Tokens

`taxonomy_menu_ui.tokens.inc` registers a chained token on the `term` type:

```
[term:menu-link]  →  type 'menu-link'  (so [term:menu-link:title], [term:menu-link:url], …)
```

`taxonomy_menu_ui_tokens()` only resolves it for `$type === 'entity'` with
`$data['entity_type'] === 'taxonomy_term'`, and only when `$term->menu['enabled']` is set —
i.e. during a term form save / entity-token context, not for an arbitrarily loaded term.

## Translation cleanup

`taxonomy_menu_ui_taxonomy_term_translation_delete()` loads every `menu_link_content` with
`link__uri = internal:/taxonomy/term/<tid>` and removes the translation matching the deleted
term translation's langcode.
