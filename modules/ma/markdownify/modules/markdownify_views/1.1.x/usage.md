Markdownify Views Pages extends Markdownify so that Views **page** displays (listing pages), not just entities, can be served as Markdown using the same `.md` / `/markdownify/` access patterns.

---

The submodule registers a route subscriber, `MarkdownifyViewsRoutes` (service
`markdownify_views.route_subscriber`), which scans the route collection and, for every
non-admin Views route whose display plugin is `page` and whose `_format` is `html`, clones the
route into a Markdown variant: the path is rewritten to the Markdownify form, the controller
is swapped to `MarkdownifyViewPageController::handle`, `_format`/`_content_type_format` are set
to `markdown`, and a `Vary: Accept` flag is added. At request time that controller renders the
view through core's `ViewPageController`, converts the resulting HTML to Markdown with the
parent's `markdownify.html_converter` service, and prepends the view title as an `# H1`. It
requires the parent `markdownify` and core `views`, and has no configuration, schema, or
permissions of its own.

> **Known issue on Drupal 11 (markdownify_views 1.1.x):**
> `MarkdownifyViewPageController` overrides core `ViewPageController::create()` but injects only
> the renderer and converter, so the parent's typed `$contextualLinks` (and other) properties
> are never initialised; calling `parent::handle()` then throws
> *"Typed property Drupal\\views\\Routing\\ViewPageController::$contextualLinks must not be
> accessed before initialization"* and the Markdown view route returns HTTP 500. On this D11
> site the feature is effectively broken until the upstream controller is fixed to initialise
> the core controller's dependencies. Track it via the project issue queue.

---

- Serve a Markdown version of a Views listing page (e.g. a blog index) at `/blog.md`.
- Give AI crawlers Markdown of category/archive listing pages, not just single entities.
- Reuse the same six access methods (`.md`, `/markdownify/` prefix, `_format`, headers) on Views pages.
- Prepend the view's page title as an H1 in the Markdown output automatically.
- Expose a curated Views page as an LLM-friendly Markdown feed.
- Provide Markdown for a "recent articles" Views page for ingestion pipelines.
- Extend Markdown coverage to structured listing content beyond nodes/terms.
- Keep admin Views pages excluded (only non-admin `page` displays are Markdownified).
- Offer Markdown of a search-results or glossary Views page.
- Let a headless front end request Markdown of a listing for server rendering.
- Serve Markdown of a taxonomy-driven Views page for topical crawling.
- Cache-separate Markdown and HTML variants of a Views page via `Vary: Accept`.
- Turn any existing public `page`-display view into a Markdown endpoint with no config.
- Produce Markdown of paginated Views results (pager arguments carry through the cloned route).
- Add Markdown listing endpoints for an `llms.txt`-style content index.
