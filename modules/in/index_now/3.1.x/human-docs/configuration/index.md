# Configuration

## Open the settings form

1. Log in as a user with the **Configure index now** permission (an administrator by
   default).
2. Go to **Configuration → Web services → Index Now**, or navigate directly to
   `/admin/config/services/index_now`.

## The settings, field by field

- **Search engine** (`default_engine`) — the IndexNow endpoint to submit to. Choose
  from **Amazon**, **Bing**, **IndexNow.org**, **Naver**, **Seznam**, **Yandex**, or
  **Yep**. Because the engines share submissions, picking any one effectively
  notifies all participating engines. (Bing is the code default.)
- **Verbose mode** (`verbose_mode`, off by default) — when on, successful
  submissions are logged as well. Warnings and errors are always logged regardless.
- **CLI mode** (`cli_mode`, off by default) — when on, content changes made in a CLI
  context (Drush, queue workers) also ping. When off, CLI operations never ping —
  handy so a bulk Drush import doesn't flood the search engine.
- **Async mode** (`async_mode`, off by default) — when on, submissions are queued
  (the `index_now_submissions` queue) and sent on cron instead of inline. Recommended
  for high‑traffic sites; make sure cron runs regularly.
- **Per‑type exclusions** — the form shows a tab for each registered entity type
  (Content, Taxonomy, and — with the Commerce submodule — Products and Stores). On
  each you can:
  - **Exclude bundles** — e.g. leave internal or unlisted content types out of
    submissions.
  - **Exclude events** — e.g. ping on *update* but not on *delete*.

Click **Save configuration** to apply.

## The API key

Index Now proves you own your domain with an **API key** (a UUID). It is generated
automatically when you install the module and stored in configuration.

- The key is served to search engines as a plain text file at
  `/index_now_api_key_{key}.txt`. This URL is intentionally open to anonymous users
  because the search engine must fetch it to verify your site.
- **The key is not a secret.** By protocol design it is meant to be world‑readable,
  so you don't need to store it in a Key entity or secrets manager. The worst anyone
  could do with it is request reindexing of your own public URLs.
- If the settings form shows a **Generate the API key** button (because no key is
  set), click it — or run `drush index_now:keygenerate` — to create or rotate the
  key. If you ever see the placeholder value `whatever` as the live key (possible
  after importing default config without running install), rotate it the same way.

## What gets submitted

For each qualifying change, the module builds the entity's absolute canonical URL
(in the entity's own language, so multilingual sites submit the right URL) and sends
it to the chosen engine. A few built‑in safeguards apply: on **insert** it skips
content anonymous users can't view (so unpublished or private content isn't
advertised), it skips excluded bundles and events, and it de‑duplicates URLs within
a single request (for example when a node save and its path‑alias save fire
together).

## Permissions

Two permissions govern the module (set at **People → Permissions**):

- **Configure index now** — access to the settings form. A restricted, trusted
  permission.
- **View index now submission results** — whether the user sees on‑screen messages
  confirming a URL was submitted (or reporting an engine error). This is purely
  informational and does not affect whether pings are actually sent.
