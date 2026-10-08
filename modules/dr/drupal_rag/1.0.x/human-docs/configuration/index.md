# Configuration

All of Drupal RAG's behavior is controlled from one settings form at
**Configuration → Search and metadata → Drupal RAG**
(`/admin/config/search/drupal-rag`). The options below map directly to the
indexing and query pipelines described on the [overview](../index.md) page.

## Enabled entity types

Select which content types (and other entity types) should be indexed. Only the
types you tick here are queued for embedding, and **unpublished entities are
skipped**. Keep this list focused on the content you actually want the AI to be
able to retrieve — indexing everything increases embedding work and storage for
little benefit.

## Chunk size

The maximum number of characters per chunk (allowed range **100–10000**). Text
extracted from each entity is split into chunks of roughly this size, respecting
sentence boundaries so logical units stay intact. Larger chunks give the model
more context per result but coarser matching; smaller chunks give finer‑grained
retrieval but more rows to search.

## Chunk overlap

The number of characters shared between consecutive chunks (allowed range
**0–5000**). A little overlap keeps ideas that straddle a chunk boundary from
being lost. Keep it well below your chunk size — a common practice is a small
fraction of the chunk size.

## Ollama base URL

The address of your Ollama server (for example a local or on‑network URL). This
is where the module sends text to be embedded and, for `/api/rag/augment`, where
it sends the assembled prompt for generation. It must be reachable from the
Drupal web container.

## Embedding model

The Ollama model used to generate embeddings (for example `nomic-embed-text`).
The form fetches the available models live from your Ollama server, so pull the
model in Ollama first and then select it here. The same model is used both when
indexing content and when embedding an incoming query, which is what makes the
similarity search meaningful.

## Chat model

*(Optional.)* The Ollama model used to generate answers for the
`POST /api/rag/augment` endpoint. If you leave it unset, the module falls back to
the embedding model. Set a dedicated chat/instruct model here if you want better
generated responses.

## View mode

How entities are rendered when the module extracts their text for indexing.
Choose a view mode that exposes the fields you want the AI to "read" — for
example a full or a purpose‑built view mode — and hides boilerplate you would
rather not embed.

## RAG prompt template

The template used to assemble the final prompt for `/api/rag/prompt` and
`/api/rag/augment`. It supports two placeholders — `{{context}}`, which is
replaced with the retrieved chunks (each formatted with its source document
label), and `{{query}}`, which is replaced with the user's question. Edit this to
set the instructions and tone you want the model to follow when answering from
your content.

## Save

Save the form. New and updated content is queued and embedded through Drupal's
queue system; when a query comes in, the module embeds it with the same model,
runs a cosine‑similarity search against the vector store, and returns (or, for
`augment`, answers from) the most relevant chunks.
