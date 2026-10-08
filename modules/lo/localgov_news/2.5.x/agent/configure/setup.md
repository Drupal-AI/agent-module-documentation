<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Setting up a newsroom

## Install

```bash
composer require drupal/localgov_news
drush en localgov_news -y
drush cr
```

Pulls in core `content_moderation`, `datetime`, `field`, `link`, `menu_ui`, `node`, `path`,
`taxonomy`, `text`.

## 1. Create a newsroom first

Articles require a newsroom — the article form warns and links to the create form when none
exists.

```bash
drush php:eval '\Drupal\node\Entity\Node::create([
  "type" => "localgov_newsroom",
  "title" => "News",
  "status" => 1,
])->save();'
```

With exactly **one** newsroom, the article form hides the newsroom selector and preselects it
(`#type: value`). Create a second newsroom and the selector reappears.

## 2. The bundles

`localgov_news_article`:

| Field | Purpose |
|---|---|
| `localgov_news_date` | Publication date (independent of node created time) |
| `localgov_news_categories` | Taxonomy reference used by the category facet |
| `field_media_image` | Hero image (media) |
| `localgov_news_related` | Related article references |
| `localgov_newsroom` | Required — which newsroom the article belongs to |
| `body` | Article body |

`localgov_newsroom`:

| Field | Purpose |
|---|---|
| `localgov_newsroom_featured` | Up to 3 featured articles; empty slots are filled by the latest promoted articles |

## 3. Place the newsroom components

They are **pseudo-fields on the newsroom's view display**, not blocks you place in block layout:

```bash
drush cget core.entity_view_display.node.localgov_newsroom.default content --format=yaml
```

Enable/position these components in *Structure → Content types → Newsroom → Manage display*:

| Component | Renders |
|---|---|
| `localgov_newsroom_all_view` | The `all_news` display of the `localgov_news_list` view |
| `localgov_news_search` | The news search block |
| `localgov_news_facets` | The date/category facets block |

The README notes that on a site with the `localgov_base` theme the search and facet blocks are
**also** placed on all `news/*` paths via block layout; on a custom theme place them yourself at
`/admin/structure/block` if you want them outside the newsroom page.

## 4. Views

| View | Purpose |
|---|---|
| `localgov_news_list` | Article listing, 10 per page, excludes the featured articles |
| `localgov_news_search` | Search results for news |

```bash
drush cget views.view.localgov_news_list display --format=yaml | head -40
```

To show "latest news" elsewhere, add a new display to `localgov_news_list` rather than building a
fresh view — the exclusion logic for featured articles lives in that view.

## 5. Promoting articles

The article form gains a **Promote on newsroom** checkbox (pseudo-field
`localgov_news_newsroom_promote`) that must be enabled in the article's **form display**:

```bash
drush cget core.entity_form_display.node.localgov_news_article.default content.localgov_news_newsroom_promote
```

Behaviour:

- Visible only when the article is going to be published — with content moderation it is shown for
  any transition to a published state; without moderation it keys off the `status` checkbox.
- Ticking it adds the article to the newsroom's featured list; **if the list is already full the
  oldest entry is dropped** to make room (as the field description says).
- The featured picker on the newsroom itself is restricted to articles in that newsroom, but note
  the source comment: it restricts the *search query*, not the field, so values set
  programmatically are not validated.

## 6. Search and facets

`hook_install()` grants **anonymous** users
`use search_api_autocomplete for localgov_news_search`. If your site does not use Search API
autocomplete, that permission is simply inert.

Facets by default cover date and category; they come from the LocalGov facets configuration and
render through the `localgov_news_facets` pseudo-field.

## 7. Sitemap and RSS

- `hook_install()` registers both bundles with Simple XML Sitemap (`index: TRUE`,
  `priority: 0.5`) when the module is present — done in PHP because `config/optional` does not
  apply sitemap settings.
- Articles support an `rss` view mode, handled specially in `NewsExtraFieldDisplay::nodeView()`.
