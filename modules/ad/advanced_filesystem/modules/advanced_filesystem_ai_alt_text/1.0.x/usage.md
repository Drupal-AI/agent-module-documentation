Generate WCAG-friendly alt text for image files with an AI vision model and write it back into every image field that references the file.

---

Advanced Filesystem: AI Alt Text is a submodule of Advanced Filesystem that adds AI-assisted alt-text authoring to Drupal. It reuses the drupal/ai module's default "Chat with Image Vision" provider — so the provider, model and API credentials live in AI's own settings, not here — and this submodule only holds a prompt, a maximum length and an overwrite flag. When you generate alt text for a file, the service base64-normalises the image (resizing to at most 1024px via GD to keep the payload small), sends it with the configured prompt, trims the reply to the length limit, and sets the `alt` sub-field on every image field across all entity types that reference that file. The feature is exposed as an inline "Generate ALT with AI" button on image widgets, a per-file form, a site-wide batch runner, a JSON endpoint, and a Drush command. Administration is gated by the restricted `administer advanced_filesystem_ai_alt_text` permission; running generation is gated by `generate advanced_filesystem_ai_alt_text`.

---

- Add a "Generate ALT with AI" button directly inside the image field widget on any content form so editors can fill alt text in one click.
- Let content editors accept, tweak or reject AI-suggested alt text before saving the entity (the button only populates the input; it does not auto-save).
- Backfill missing alt text across an existing media library using the batch generator at Config → Media → Advanced Filesystem → AI Alt Text → Batch Processing.
- Generate alt text for a single file from the file admin listing (`/admin/content/files`) via the per-file "AI Generate Alt Text" operation link.
- Automate alt-text generation from the command line / CI with the module's Drush command over selected or all image files.
- Enforce a house style for descriptions by editing the prompt (e.g. tone, language, "do not start with 'Image of'").
- Cap alt text to a WCAG-recommended length (default 125 characters, truncated on a word boundary) or remove the limit entirely.
- Choose whether to overwrite alt text that is already set, or only fill in fields that are currently empty.
- Improve accessibility (screen-reader support) of image-heavy pages without hand-writing every description.
- Improve image SEO by giving search engines meaningful alt attributes at scale.
- Keep provider choice centralised: switch the underlying vision model (OpenAI, Anthropic, etc.) once in AI settings and every alt-text run follows.
- Restrict who can trigger (potentially paid) AI calls by granting only the `generate advanced_filesystem_ai_alt_text` permission to trusted editors.
- Separate configuration duties (prompt, limits) behind the restricted `administer` permission from day-to-day generation.
- Process JPEG, PNG, GIF, WebP and BMP images (the supported MIME allowlist); non-image files are skipped with a clear message.
- Populate alt text for the same shared image everywhere it is reused, since the service writes to all referencing image fields at once.
- Preview the target image and see its name, MIME type and size on the per-file form before running generation.
- Fall back gracefully when no AI Vision provider is configured — the UI shows a status banner and the button is hidden rather than erroring.
- Integrate into an editorial QA pass: generate suggestions in batch, then have editors review the highlighted fields.
- Reduce onboarding cost for accessibility compliance programs by giving editors a starting draft for every image.
- Localise alt text by writing a prompt that instructs the model to respond in the site's content language.
