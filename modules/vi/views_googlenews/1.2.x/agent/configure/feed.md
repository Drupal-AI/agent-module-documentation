<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Build a Google News feed view

There is no admin settings page. You configure everything inside a View.

## Steps (UI)

1. Add a View of your articles (`/admin/structure/views/add`), showing **fields**.
2. Add a **Feed** display ("+ Add" → Feed) and give it a **Path** (e.g. `news.xml`).
3. Under **Format**, set the style to **"Google News Feed"** (plugin `google_news`).
4. Set the row style to **"Google News fields"** (plugin `google_news_fields`).
5. Add the view fields you need (URL/link, title, authored-on date, keywords, …), then in the
   row settings map each Google News tag to one of those fields (selects below).
6. Google recommends limiting to the last two days: add a filter **Content: Authored on**,
   operator "is greater than or equal to", value type offset `now -2 days`.

## Plugin ids

| Kind | id | Title | Restriction |
|---|---|---|---|
| Views style | `google_news` | Google News Feed | `display_types: {feed}` (feed displays only) |
| Views row | `google_news_fields` | Google News fields | used with the style above |

## Row option keys → Google News XML tag

Config path: view `display.<feed>.display_options.row` → `type: google_news_fields`,
`options:` with these keys (each holds a **view field id**, or `''` for none):

| Option key | XML tag | Required | Notes |
|---|---|---|---|
| `loc_field` | `<loc>` | yes | Article URL; passed through `UrlHelper::filterBadProtocol()`. |
| `news_title_field` | `<news:title>` | yes | Tags stripped. |
| `news_publication_date_field` | `<news:publication_date>` | yes | W3C date (YYYY-MM-DD or full datetime+TZ). |
| `news_publication_name_field` | `<news:name>` | no | Defaults to the **site name** if empty. |
| `news_publication_language_field` | `<news:language>` | no | Defaults to the **site default language** if empty. |
| `news_access_field` | `<news:access>` | no | Must be `Subscription`, `Registration`, or empty. |
| `news_genres_field` | `<news:genres>` | no | e.g. `PressRelease`, `UserGenerated`. |
| `news_keywords_field` | `<news:keywords>` | no | Comma-separated. |
| `news_stock_tickers_field` | `<news:stock_tickers>` | no | Up to 5, comma-separated. |

Empty item values are removed (`array_filter`) before rendering.

## Example (config shape of the feed display)

```yaml
display:
  feed_1:
    display_plugin: feed
    display_options:
      path: news.xml
      style:
        type: google_news
      row:
        type: google_news_fields
        options:
          loc_field: view_node          # a "Content: Link to Content" / rendered URL field
          news_title_field: title
          news_publication_date_field: created
          news_keywords_field: field_tags
```

Read back a live view's plugins:

```bash
drush php:eval '$v=\Drupal\views\Views::getView("my_view"); $v->setDisplay("feed_1");
print $v->getStyle()->getPluginId()."\n"; print $v->rowPlugin->getPluginId()."\n";'
```

## Output

The feed is served as `text/xml; charset=utf-8` with a `<urlset>`/`news:` document (see
theming/templates.md). During Views live preview the XML content-type header is not set.
