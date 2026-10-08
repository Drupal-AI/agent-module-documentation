# Configuration

Markdown Sitemap is configured on one settings page. Before you enable content there, keep
the policy in mind: everything you include becomes easy for AI crawlers — and any other
scraper — to read, so include only **public content you intend AI systems to ingest**.

## Open the settings form

1. Log in as a user who can administer site configuration.
2. Go to **Configuration → Search and metadata → MD Sitemap**, or navigate directly to
   `/admin/config/search/md-sitemap`.

## URL suffix

Choose the **suffix** appended to each URL in the generated sitemap — for example `.md`,
`.txt` or `.ai`. Pick the suffix that matches how you serve machine‑readable versions of
your pages. If you use a module like Markdownify to render Markdown versions, set the suffix
to whatever path form those versions use so the sitemap points crawlers at them.

## Entity types and bundles to include

The form lets you select which **entity types** and **bundles** appear in the sitemap. The
module automatically detects any entity type that has a canonical URL — nodes, taxonomy
terms, media, commerce products, and so on — and you tick the ones you want exposed.

- Include only the content you genuinely want AI systems to read.
- Leave out anything that is not meant for public ingestion, even if it is technically
  published.

## Save

Save the form. The sitemap regenerates and is served at **`/sitemap-llm`**. You do not have
to rebuild it manually as content changes: the module invalidates its cache automatically
whenever entities are inserted, updated or deleted, and whenever you change this
configuration.

## Point crawlers at it

To advertise the sitemap under the `llms.txt` convention, add a link to `/sitemap-llm` from
your `llms.txt` file so LLM crawlers can discover it.
