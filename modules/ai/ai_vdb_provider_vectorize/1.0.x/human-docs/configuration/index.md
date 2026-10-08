# Configuration

Setting up Cloudflare Vectorize is three steps: **connect Cloudflare**, **enter
the Vectorize index details**, then **select the provider for an AI Search
index**.

## 1. Connect your Cloudflare account

Credentials for Cloudflare are handled by the underlying `cloudflare_*` SDK
modules, **not** by this module directly. Configure your Cloudflare account and
API access through those modules first (account ID and API token). Keep the API
token out of plain configuration — store it via an environment variable / Key as
those modules support.

## 2. Configure the Vectorize provider

1. Log in as a user with the **Administer AI providers**
   (`administer ai providers`) permission.
2. Go to **Configuration → AI → Vector DB Providers → Vectorize**, or navigate
   directly to `/admin/config/ai/vdb_providers/vectorize`.
3. Set the **Vectorize index / namespace** details for this environment. Using a
   distinct namespace or index name per environment (dev / staging / production)
   keeps their vectors from colliding.
4. Save, and validate connectivity to Cloudflare from the form.

## 3. Use it for an AI Search index

1. Create a **Search API** server/index (or open an existing one).
2. Choose the **Cloudflare Vectorize** vector‑database provider as its backend.
3. Add your content to the index. The `VectorizeMapper` maps Search API fields to
   Vectorize metadata, and document embeddings are stored in Vectorize.
4. Run semantic / similarity queries through AI Search; point RAG or chat
   pipelines at the Vectorize‑backed retrieval.

When source entities are removed, their vectors are deleted from Vectorize; re‑
index after content changes to keep the index current.

> **Data egress:** your content's embeddings live in Cloudflare Vectorize at the
> edge — confirm that sending them to Cloudflare is acceptable for your content.
