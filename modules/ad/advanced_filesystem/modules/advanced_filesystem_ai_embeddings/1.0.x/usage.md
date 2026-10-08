Generates pixel-based visual embeddings for managed images to power similarity search, near-duplicate detection, clustering and an optional AI description/tagging layer.

---

Advanced Filesystem: AI Visual Embeddings analyses every managed raster image with PHP-GD and stores a compact 127-dimension feature vector (structure, colour, regional colour and texture) plus perceptual (pHash) and difference (dHash) fingerprints and a heuristic quality score — all computed locally, with no external service. From those vectors it builds "visually similar" galleries (cosine similarity, with an optional cron precompute of top-K neighbours for speed), reverse-image search from an in-memory upload, by-colour search, perceptual-hash duplicate grouping, a 2D PCA "embedding map" and deterministic k-means clusters. A strictly opt-in AI layer (off by default, requires the drupal/ai module and a configured provider) asks a vision chat model for a short description, keyword tags and an optional safety label, then embeds the description as a semantic vector so you can search by meaning or by a hybrid visual+semantic blend. Everything is surfaced through an admin UI, a permission-gated JSON API for headless front-ends, Views integration, a Media source plugin and Drush commands.

---

- Find visually similar images to a given file directly on its per-file "AI Embeddings" page (colour/structure/texture cosine ranking).
- Run reverse-image search: upload a photo (analysed in memory, never stored) and get the closest matches from the existing library.
- Search the library by a picked colour to surface images dominated by that hue.
- Detect near-duplicate images across the site by perceptual-hash Hamming distance and review them grouped together.
- Bulk-generate embeddings for a whole existing image library via the "Analyze Existing Images" batch.
- Auto-analyse new images on upload (optional) so similarity/duplicate data is ready immediately.
- Flag low-quality images automatically (too dark, overexposed, low detail, flat colour, low resolution) using the stored quality score and flags.
- Build a custom Views listing of low-quality images to triage or clean up.
- Cluster the whole image collection into visually coherent groups with k-means for browsing or curation.
- Visualise the collection as a 2D PCA scatter "map" where similar images sit close together.
- Precompute top-K nearest neighbours during cron so the per-file "similar" gallery loads instantly on large libraries.
- Power a headless/Next.js/mobile front-end via the JSON API (stats, per-file embedding, similar, clusters).
- Retrieve raw embedding vectors over the API (`?vector=1`) to feed an external vector database or ML pipeline.
- Offer three similarity modes over the API — visual, semantic (AI) or hybrid — with a tunable blend weight.
- Generate an AI caption and keyword tags for images (opt-in) to seed alt text, metadata or search keywords.
- Add an optional AI safety/NSFW label and confidence score to moderate uploaded imagery.
- Search by meaning (semantic embedding of the AI description) so "feline" finds "cat" images even when pixels differ.
- Blend visual and semantic similarity (hybrid mode) to balance "looks alike" with "means the same".
- Expose embedding metadata (quality, model, pHash, AI description, safety label) as a Media source for building media types and displays.
- Prune the analysis log automatically after a configurable retention window via cron.
- Regenerate a single image's embedding on demand (e.g. after replacing the file) from its per-file page.
- Delete a redundant near-duplicate file from the duplicates screen behind a double-confirmation guard.
- Drive analysis, enrichment and neighbour precomputation from the command line with the module's Drush commands for scheduled or CI workflows.
- Keep the whole feature set free of external cost by using only the local visual embedding and leaving the AI layer disabled.
