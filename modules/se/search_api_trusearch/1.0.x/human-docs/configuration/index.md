# Configuration

Search API TruSearch needs configuration before it does anything — there is
nothing that works on enable alone. Setting it up is a sequence: enter your engine
credentials, connect a Search API server and index, index your content, then wire
up the front-end widgets.

## 1. Enter your engine credentials

Go to **Admin → Configuration → Search and metadata → TruSearch Settings** and
enter:

- **Engine URL** — the address of your running TruSearch engine instance.
- **API key** — the key that authorises your site with the engine. Store this
  securely; the module supports env-backed credentials so the secret does not
  have to live in exported configuration.
- **Tenant ID** — identifies your tenant on the engine.

## 2. Create a Search API server on the TruSearch backend

Go to **Admin → Configuration → Search and metadata → Search API** and create (or
edit) a **server**, choosing the **TruSearch** backend. This is what routes search
requests to the engine rather than to a local database.

## 3. Create an index

Create a Search API **index** attached to that server, and configure which content
types and fields should be indexed — exactly as you would for any Search API
backend.

## 4. Run the indexer

Index your content so the engine has something to search:

```bash
drush search-api:index
```

You can also run indexing from the Search API UI.

## 5. Register the widget library in your theme

The front-end widgets are delivered by files your TruSearch engine provider
supplies. Place them into your theme and register them in your theme's
`*.libraries.yml`, for example:

```yaml
trusearch-widgets:
  js:
    libraries/trusearch/js/trusearch-widgets.iife.js: { minified: true, preprocess: false }
  css:
    theme:
      libraries/trusearch/css/trusearch-widgets.css: {}
```

Then, back on the **TruSearch Settings** form, open the **Advanced** section and
set **Widget vendor library** to `mytheme/trusearch-widgets` (using your theme's
machine name).

## 6. Place the search widgets

You have two ways to surface search on the site:

- **Autocomplete widget block** — place it via the block layout UI
  (**Structure → Block layout**) in whatever region you want.
- **TruSearch Page node** — create a node of type **TruSearch Page** at
  `/admin/content/add/trusearch_page`, enter the **Widget ID**, and save. The
  module renders the engine's search page from that ID.

The TruSearch engine dashboard includes a visual, drag-and-drop, no-code builder
where you arrange result cards, facet panels, the AI answer box, sorting controls,
and pagination, then preview the layout live. When the layout is ready, the engine
gives you a **Widget ID** — bring that ID back to Drupal and drop it into either
the block or a TruSearch Page node.

## A note on data and resilience

Remember that indexing and querying are offloaded to the external TruSearch
engine, so your content and visitors' queries leave your infrastructure. Keep the
API key out of plain configuration, and note that the built-in circuit breaker
lets you configure degraded-mode behaviour so search fails gracefully if the
engine is unreachable rather than showing errors to end users.
