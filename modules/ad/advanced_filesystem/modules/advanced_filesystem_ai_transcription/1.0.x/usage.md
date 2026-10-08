Runs managed audio, video, image, PDF, Office and text files through a pluggable, AI-backed semantic-extraction pipeline (transcription, captioning, OCR, tagging, embeddings) and stores the results in adfs_ai_ fields on the file entity.

---

Advanced Filesystem: AI Transcription is a submodule that adds a semantic-extraction layer on top of Drupal's file storage using the Drupal AI module (drupal/ai). It defines a SemanticExtractor plugin type and ships eleven extractors covering speech-to-text for audio and video, image captioning, object/category/color/brand analysis, face and emotion detection, safety moderation, PDF text extraction and OCR, Office-document and plain-text extraction with AI enrichment, AI taxonomy tagging, and vector embeddings. A per-MIME-group extractor matrix decides which extractors run for each file class, and extraction can be triggered on demand from a per-file form, in batch, from Drush, or automatically on upload via a cron queue worker. All AI calls go through the ai.provider service, so the module supports any configured provider (OpenAI, Azure, Gemini, Ollama, …) and reuses that provider's credentials. Extracted data is written to adfs_ai_ prefixed fields on the file entity, surfaced in Views and Media (through a dedicated media source), and reviewable per file — transcript, summary, tags, JSON entities, an embedding "fingerprint" and a most-similar-files gallery — or across the whole library as a 2D PCA embedding map. Administration is gated behind a single restricted permission.

---

- Auto-transcribe every uploaded podcast or interview audio file to searchable text via OpenAI Whisper or another speech_to_text provider.
- Transcribe the audio track of uploaded videos, reusing an embedded subtitle track (ffmpeg) first to avoid AI cost when one exists.
- Generate alt-text-style captions and descriptive tags for uploaded images through a chat_with_image_vision provider.
- Detect objects, an overall scene category, dominant colors and visible brands in product or catalogue images, mapped to taxonomy terms.
- Run content moderation on uploaded images, scoring nudity, violence, drugs and weapons for a review workflow.
- Detect faces and infer emotions in images for analytics or editorial tooling.
- OCR scanned or image-only PDFs (rasterise with pdftoppm, then AI vision) and extract text from digital PDFs with pdftotext.
- Extract text from DOCX/XLSX/PPTX/ODF documents via a native ZIP reader or a LibreOffice CLI fallback.
- Extract and AI-enrich plain-text files into a short summary plus tags.
- Auto-tag any file into a taxonomy vocabulary from its extracted text using an AI chat provider.
- Generate vector embeddings from extracted text and index them into a vector database provider for semantic search.
- Find the most similar files to a given file by cosine similarity of their embedding vectors.
- Visualise the whole library as a 2D PCA scatter map where semantically similar files cluster together.
- Batch-process an existing library of files retroactively through any subset of extractors.
- Drive extraction from the command line with the module's Drush commands for scripted or scheduled runs.
- Expose AI-extracted full text, summary, tags, confidence and caption as Media entity metadata via the AI Transcription media source.
- Surface adfs_ai_ fields in Views (they are real Drupal fields) to build faceted, content-aware file listings.
- Restrict which entity/bundle/field file uploads trigger transcription, or fall back to a global auto-transcribe on all audio/video.
- Enforce a maximum audio/video file size before an AI call is made, to cap per-file transcription cost.
- Review per-file extraction status, provider used and failure reasons from an admin dashboard and per-file tab.
- Store a BCP-47 language hint and pass it to the transcription provider for better accuracy on known-language media.
- Keep a single provider configuration for the whole site while mixing text, image and audio operations across different AI providers.
- Re-run or overwrite extraction selectively per file or per extraction method without reprocessing the entire library.
