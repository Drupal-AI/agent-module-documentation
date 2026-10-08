# Configuration

Getting REST OAI-PMH working is three steps: open the endpoint with a permission,
tell it which Views to expose (and how to render them), and build the index. There
is a settings form plus a rebuild form.

## Step 1 — open the endpoint (grant the REST permission)

Enabling the module installs the `oai_pmh` REST resource, but it returns **403**
until a role is allowed to use it. OAI harvesters connect anonymously, so grant the
permission to the anonymous role:

```bash
drush role:perm:add anonymous 'restful get oai_pmh'
# only if you also need POST harvesting:
drush role:perm:add anonymous 'restful post oai_pmh'
```

(You can also do this at **People → Permissions**, under the "restful get oai_pmh"
permission.)

## Step 2 — configure the endpoint

1. Log in as a user with the **Administer REST resources** permission.
2. Go to **Configuration → Web services → REST → OAI‑PMH**
   (`/admin/config/services/rest/oai-pmh`).

The form's fields:

- **What to expose** — checkboxes listing every View that has an *Entity
  Reference* display. Tick each one you want in the repository. Each becomes an OAI
  set (see *Support sets*). Newly ticked Views are indexed right away.
- **Support Sets** — when on (the default), each View is a separate, selectable OAI
  set. Turn it off to treat everything as one flat repository; then `ListSets`
  reports that there is no set hierarchy.
- **Metadata Mappings** — map each metadata prefix (such as `oai_dc` or `mods`) to
  the plugin that renders it (for example `dublin_core_rdf`, `dublin_core_metatag`,
  or `mods`). A prefix with no plugin selected is disabled.
- **MODS View** — if you serve MODS, choose the View and display the MODS mapping
  pulls from.
- **Repository Name** — the repository name returned by the `Identify` verb
  (defaults to your site name).
- **Repository Admin E‑Mail** — the admin contact returned by `Identify` (defaults
  to the site email).
- **Repository Path** — the public endpoint path, default `/oai/request`. Changing
  it rewrites the route; the form checks that the new path doesn't collide with an
  existing one. Handy when migrating an existing OAI provider and you want to keep
  the same URL.
- **Resumption token expiry** — how many seconds a paging `resumptionToken` stays
  valid (default 3600). Large harvests are paged with these tokens.
- **Caching Technique** — how the index is kept fresh:
  - **Liberal** *(default)* — rebuild the relevant index entries automatically
    whenever a relevant entity is saved, so edits appear without manual work. Good
    for lower‑write sites.
  - **Conservative** — only remove deleted entities automatically; rebuild the rest
    via cron or the manual Rebuild form. Better for high‑write sites.

Save the form.

## Step 3 — build (or rebuild) the index

Records are **materialized**, not live — the module walks your selected Views and
stores the results in its own tables. Build the index:

- Use the **Rebuild** form at `/admin/config/services/rest/oai-pmh/queue`, or
- Let cron process the rebuild queue on its next run, or
- Rebuild synchronously from the CLI:

```bash
drush php:eval 'rest_oai_pmh_rebuild_entries();'
```

As a safety net, the very first harvest request auto‑rebuilds the index if it is
empty. Rebuild manually after bulk imports so new content is picked up promptly.

## Test the endpoint

Point a browser or `curl` at the endpoint with a `verb`:

```bash
curl 'https://YOUR-SITE/oai/request?verb=Identify'
curl 'https://YOUR-SITE/oai/request?verb=ListMetadataFormats'
curl 'https://YOUR-SITE/oai/request?verb=ListSets'
curl 'https://YOUR-SITE/oai/request?verb=ListRecords&metadataPrefix=oai_dc'
curl 'https://YOUR-SITE/oai/request?verb=GetRecord&metadataPrefix=oai_dc&identifier=oai:YOUR-SITE:node-1'
```

Harvesters can request a single set with `&set=<view_id>:<display_id>`, and do
incremental harvests with `from`/`until` datestamp parameters (which filter on each
record's changed time). Responses are XML and are deliberately uncacheable, because
access is evaluated fresh on every request.

## A note on what gets exposed

Only content the requesting (anonymous) user is allowed to view is ever returned.
Even if an indexed View contains unpublished or restricted entities, each response
re‑checks entity and field view access as the requester, so protected content is
filtered out at harvest time rather than leaked.
