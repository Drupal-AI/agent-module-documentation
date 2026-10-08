# AI Index Health — manual setup guide

**AI Index Health** (`ai_index_health`) is a monitoring tool for the AI vector
indexes you build on **Search API**. Vector search and RAG features depend on
"embeddings" — numeric representations of your content — but nothing in the
standard tooling tells you whether the embeddings you already have still match
your content. This module answers three practical questions for every Search API
index:

- **Stale embeddings** — items whose content changed *after* they were last
  embedded, so their vectors are out of date.
- **Coverage gaps** — indexable items that were never tracked, and therefore never
  embedded at all.
- **Dimension / model mismatch** — cases where the index was built with a
  different model or vector size than the one configured today (with an optional
  end-of-life warning if you also run AI Model Registry).

Crucially, when it finds problems it does not force a slow, expensive full
reindex. Instead it can queue **only the affected items** for re-embedding through
the Search API tracker, so you re-embed just what changed. It works from real
Search API structures (the tracker table, each datasource's item list, and each
entity's change time), and optional integrations with the AI modules are all
guarded so the module degrades gracefully when they are absent.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable the
   module, and grant the monitoring permission.

## Where it lives in the admin menu

- **Health dashboard:** **Configuration → Search and metadata → AI Index Health**
  (`/admin/config/search/ai-index-health`).
- **Requeue a single index:** `/admin/config/search/ai-index-health/{index}/reindex`
  (a CSRF-protected action reached from the dashboard).

Both require the restricted **Administer AI index health** permission, and there
are no anonymous or public endpoints.

## How to use it

**From the dashboard.** Open the dashboard to see, for each Search API index, its
stale-embedding count, coverage gaps and any dimension/model-mismatch warnings.
When an index needs attention, use its requeue action to queue only the affected
items for re-embedding — you are not forced into a full reindex.

**From the command line.** The module also provides a Drush command for the same
report, handy for scheduling or CI:

```bash
drush ai_index_health:report [index_id] [--requeue] [--show-items]
```

- `index_id` *(optional)* — limit the report to one Search API index; omit it to
  cover all indexes.
- `--requeue` — queue the affected (stale / gap) items for re-embedding instead of
  only reporting them.
- `--show-items` — list the affected item ids in the output.

A common pattern is to run the report on a schedule (via cron) to catch stale
vectors before they degrade search or RAG results.
