# Configuration

LocalGov News has no settings form — you set it up by creating content and arranging the
newsroom's display components. This page walks through that.

## Step 1 — Create a newsroom first

Articles require a newsroom to belong to, and the article form will warn you (with a link to
create one) if none exists. Create the newsroom before writing any articles:

- In the UI: **Content → Add content → Newsroom**, give it a title (for example "News"), and
  publish it.
- Or with Drush:

  ```bash
  drush php:eval '\Drupal\node\Entity\Node::create([
    "type" => "localgov_newsroom",
    "title" => "News",
    "status" => 1,
  ])->save();'
  ```

When exactly **one** newsroom exists, the article form hides the newsroom selector and picks
it automatically. Create a second newsroom (say, per service area) and the selector
reappears.

## Step 2 — Know the two content types

**News article** (`localgov_news_article`) fields:

| Field | Purpose |
|-------|---------|
| Publication date | The article's publish date, independent of the node's created time. |
| Categories | Taxonomy reference used by the category facet. |
| Media image | The hero image. |
| Related articles | References to other articles. |
| Newsroom | Required — which newsroom the article belongs to. |
| Body | The article text. |

**Newsroom** (`localgov_newsroom`) has a **Featured** field holding up to three hand-picked
articles; any empty slots are filled automatically with the latest promoted articles.

## Step 3 — Place the newsroom components

The newsroom's listing, search box, and facets are **pseudo-fields on the newsroom's view
display**, not blocks you place in Block layout. Enable and position them under **Structure →
Content types → Newsroom → Manage display**:

| Component | Renders |
|-----------|---------|
| Newsroom listing (`localgov_newsroom_all_view`) | The article listing (10 per page, excluding featured). |
| News search (`localgov_news_search`) | The news search block. |
| News facets (`localgov_news_facets`) | The date and category facet block. |

On a site using the `localgov_base` theme, the search and facet blocks are *also* placed on
all `news/*` paths through block layout. On a custom theme, place them yourself at
**Structure → Block layout** if you want them outside the newsroom page.

## Step 4 — Promote and feature articles

The article form includes a **Promote on newsroom** checkbox (a pseudo-field that must be
enabled in the article's *form* display). It appears when the article is going to be
published — with content moderation, on any transition to a published state; without it, keyed
off the Published checkbox.

- Ticking it adds the article to its newsroom's featured list. If the featured list is
  already full (three items), the oldest entry is dropped to make room.
- The newsroom's own featured-article picker is restricted to articles in that newsroom.
  (Note: this restricts the search in the picker, not the stored field, so a value set
  programmatically outside the newsroom is not rejected.)

## Step 5 — Search, facets, RSS, and sitemap

- On install, the module grants anonymous users the "use search_api_autocomplete for
  localgov_news_search" permission. If your site does not use Search API autocomplete, that
  permission is simply inert.
- Facets cover date and category by default, rendered through the facets component above.
- Articles support an **RSS** view mode, so you get a news feed out of the box.
- Both content types are registered with **Simple XML Sitemap** automatically (indexed,
  priority 0.5) when that module is present.

## Reusing the listing elsewhere

To show a "latest news" list somewhere other than the newsroom page, add a new display to
the existing `localgov_news_list` view rather than building a fresh view — the logic that
excludes already-featured articles lives in that view.
