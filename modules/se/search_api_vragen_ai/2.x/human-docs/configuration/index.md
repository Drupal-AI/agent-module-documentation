# Configuration

Search API Vragen.ai needs configuration before it does anything. There are two
parts: authenticate with the Vragen.ai service, then set up a Search API server
and index that synchronise your content to it.

## 1. Authenticate

For the module to talk to the Vragen.ai API it needs two things:

- **The correct endpoint** created specifically for your organisation.
- **The bearer token** used to authorise requests.

Enter both on the form at **Configuration → Search and metadata → Vragen.ai**
(`/admin/config/search/vragen-ai`).

> Treat the bearer token as a secret and keep it out of plain, exported
> configuration.

## 2. Create a Search API server

Create a new Search API **server** using the **Vragen.ai** backend.

## 3. Create and configure an index

Create a new Search API **index** and adjust these settings:

- **Datasources** — Content.
- **Bundles** — the content bundles you want to index.
- **Language** — the languages to include.
- **Index items immediately** — turn this **off** to synchronise through cron
  rather than sending a request to the backend on every content update. You *can*
  leave immediate indexing on, but be aware it sends requests directly to
  Vragen.ai during content updates instead of batching them via cron.

If you have attached files or media (for example PDFs) that should be indexed
along with the content, add those fields as **Vragen.ai attachments**.

Then configure and add all the fields that should be part of the index. Rendering
content to HTML is recommended, so the backend can recognise structure and
semantics more reliably.

## What Vragen.ai adds

On top of the indexed content, the Vragen.ai platform provides question answering
that combines retrieval with generative AI, so answers are grounded in your source
material rather than only in model knowledge. According to its documentation this
includes retrieval from your own content sources, answer generation from the
retrieved context, source references in the answers, configuration of tone, role
and answer behaviour, testing and validation before going live, and analysis of
incoming questions to reveal content gaps.

## A note on data governance

Remember that indexed content and search queries are sent to the external
Vragen.ai service to be embedded and searched. For public content this is
straightforward; for confidential content, weigh the external processing and index
only what is appropriate to share.
