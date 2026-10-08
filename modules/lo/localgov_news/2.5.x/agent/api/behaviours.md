<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Editorial behaviours and extension points

All of the module's PHP behaviour funnels through one class,
`Drupal\localgov_news\NewsExtraFieldDisplay`, instantiated via `class_resolver` from four
procedural hooks in `localgov_news.module`.

## `entityExtraFieldInfo()`

Registers four pseudo-fields:

| Entity/bundle | Type | Key |
|---|---|---|
| `node.localgov_newsroom` | display | `localgov_newsroom_all_view` |
| `node.localgov_newsroom` | display | `localgov_news_search` |
| `node.localgov_newsroom` | display | `localgov_news_facets` |
| `node.localgov_news_article` | **form** | `localgov_news_newsroom_promote` |

Nothing renders unless the component is enabled in the relevant display — this is the usual reason
a newsroom page appears empty after install.

## `nodeView()`

```php
if ($display->getComponent('localgov_newsroom_all_view')) {
  $build['localgov_newsroom_all_view'] = $this->getViewEmbed($node, 'all_news');   // localgov_news_list
}
if ($display->getComponent('localgov_news_search'))  { … getSearchBlock(); }
if ($display->getComponent('localgov_news_facets'))  { … getFacetsBlock(); }
if ($node->getType() === 'localgov_news_article' && $view_mode === 'rss') { … }
```

The blocks are built through the **block plugin manager**, not placed blocks, so their visibility
is governed by the display component rather than block layout.

## `formAlter()` — the promote checkbox

Applies to `node_localgov_news_article_form` / `…_edit_form` when the form display has the
`localgov_news_newsroom_promote` component.

Visibility is computed from the moderation setup:

- **Not moderated** → visible when `:input[name='status[value]']` is checked.
- **Moderated** → the workflow's transitions are scanned, and the checkbox is visible when
  `moderation_state[0][state]` equals any state where `isPublishedState()` is TRUE (joined with
  `or`).

So on a moderated site the checkbox appears as soon as the editor selects a publishing state,
without saving first.

A submit handler `NewsExtraFieldDisplay::articleSubmit()` is appended to
`$form['actions']['submit']['#submit']`. It runs only when `status` is truthy and the article has
a `localgov_newsroom` entity, then adds or removes the article from that newsroom's
`localgov_newsroom_featured` list — dropping the oldest entry when the list is already at its
maximum.

Implication for programmatic saves: promoting is a **form-level** behaviour. Creating an article
with `Node::create()` never touches the newsroom's featured list; set
`localgov_newsroom_featured` on the newsroom node yourself.

## `hook_field_widget_complete_form_alter()`

Two behaviours, both in `localgov_news.module`:

1. **`localgov_newsroom` widget** — options are inspected:
   - only `_none` present → a warning message with a link to create a newsroom
     (`localgov_newsroom`, or `group_node:localgov_newsroom` when
     `localgov_microsites_group` is active and a group context exists);
   - exactly one real option → that value is forced and the widget becomes `#type: value`,
     hiding it from the editor.
2. **`localgov_newsroom_featured` widget** — the reference selection query is narrowed to articles
   belonging to the newsroom being edited. The source flags this as a stopgap: *"This is presently
   just restricting the search query and not the field itself"*, and suggests a custom selection
   handler as the durable fix. Do not rely on it for validation.

## `hook_tokens_alter()`

```php
$replacements['[node:localgov_news_categories:0:entity]'] =
  stripslashes(str_replace(',', '', $replacements['[node:localgov_news_categories:0:entity]']));
```

Commas are stripped from the first category token so pathauto does not treat them as path
separators. If you build your own alias pattern with a different token delta, apply the same
treatment.

## Theming

| Theme hook | Template | Library |
|---|---|---|
| `node__localgov_news_article__teaser` | `node--localgov-news-article--teaser` | `localgov-news-teaser.css` |
| `node__localgov_news_article__full` | `node--localgov-news-article--full` | `localgov-news-full.css` |
| `field__localgov_newsroom_featured` | `field--localgov-newsroom-featured` | `localgov-newsroom-featured.css` |

Plus `localgov-news-list.css` for the listing. Override the templates in your theme as usual; the
CSS libraries are declared in `localgov_news.libraries.yml` and can be replaced with
`libraries-override`.

## Page header

`localgov_news.page_header` (`EventSubscriber\PageHeaderSubscriber`) adjusts the LocalGov Core
page header for news pages — subscribe at a higher priority if you need different header content
on those routes.
