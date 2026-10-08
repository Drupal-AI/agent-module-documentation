<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The `listjs` theme hook, behavior and JS events

## Theme hook

`listjs_theme()` registers one theme hook, `listjs`, with template `templates/listjs.html.twig` and
variables: `placeholder_text`, `items`, `attributes`, `list_id`, `value_names`.

Render it from any module/controller:

```php
$build['render'] = [
  '#theme' => 'listjs',
  '#placeholder_text' => $this->t('Kittens'),
  '#items' => [
    ['data' => ['#markup' => '<h2 class="value_name-house">Jones\'s</h2><div class="value_name-cat">Kitty</div>']],
    ['data' => ['#markup' => '<h2 class="value_name-house">Hudson\'s</h2><div class="value_name-cat">Binky</div>']],
  ],
  '#attributes' => ['class' => ['mykittens']],
  '#list_id' => 'mykittens-are-unique',
  '#value_names' => [
    'value_name-cat'   => ['sort' => TRUE,  'sort_text' => $this->t('Sort Kittens')],
    'value_name-house' => ['sort' => FALSE],
  ],
];
```

- **`#value_names`** is keyed by the **CSS class** that marks each searchable/sortable value inside
  an item's markup. List.js reads the text of elements carrying those classes. Each value maps to
  `sort` (bool → whether to render a sort button) and optional `sort_text` (the button label).
- **`#list_id`** must be a unique HTML id; it becomes the container `<div id="…">` and the List.js
  instance target.
- `#items` is an array of render arrays under a `data` key; the template wraps each in `<li>`, and
  the `<ul>` gets class `list` automatically.

## Preprocess & attachment

`template_preprocess_listjs()`:

- Adds class `list` to the `<ul>` attributes.
- Sets `drupalSettings.listJs.valueNames = listjs_prepare_list_value_names($list_id, $value_names)`
  and attaches the `listjs/listjs-init` library.

`listjs_prepare_list_value_names($list_id, $value_names)` uses a `drupal_static` accumulator so that
**multiple listjs widgets on one page don't overwrite each other** — a value-name map is stored per
`$list_id` and only set once. This function is also called by the Views submodule.

## The behavior

`Drupal.behaviors.listjs` (in `js/listjs-init.js`, deps `core/jquery`, `core/once`, `core/drupal`,
`listjs/listjs`) iterates `settings.listJs.valueNames`, and for each `listId` runs
`once('listjs', '#' + listId, context)` then:

```js
Drupal.listJs.enableListJs(listId, { valueNames: Object.keys(value) });
// → new List(listId, options)
```

`Drupal.listJs.enableListJs(listId, options)` is public and reusable; it instantiates List.js and
binds its events.

## JS events (List.js event → jQuery document trigger)

| List.js event    | Module trigger          |
|------------------|-------------------------|
| `updated`        | `listJsUpdated`         |
| `searchStart`    | `listJsSearchStart`     |
| `searchComplete` | `listJsSearchComplete`  |
| `filterStart`    | `listJsFilterStart`     |
| `filterComplete` | `listJsFilterComplete`  |
| `sortStart`      | `listJsSortStart`       |
| `sortComplete`   | `listJsSortComplete`    |

```js
$(document).bind('listJsUpdated', function (event, listObject) {
  // e.g. update a result count / empty-state message
});
```

The List.js instance object is passed as the second argument. See the List.js API for its methods
(`search`, `sort`, `filter`, `.matchingItems`, etc.).

## Markup contract (from the template)

```
<div id="{list_id}">
  <div class="filter-wrapper"><input class="search" name="{list_id}-filter" type="text"></div>
  <div class="sort-wrapper">
    <input type="submit" class="sort" data-sort="{value_name}" value="{sort_text}">  {# per sortable value #}
  </div>
  <ul class="list …">
    <li>{{ item.data }}</li>
  </ul>
</div>
```

Keep `.search`, `.sort[data-sort]` and `.list` if you override the template — they are the List.js
selectors.
