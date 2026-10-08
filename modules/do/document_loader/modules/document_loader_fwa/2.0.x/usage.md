Adds a "Load Document" Field Widget Actions button that extracts a source field's document and AJAX-fills a destination field via Document Loader.

---

Document Loader: Field Widget Actions integrates Document Loader with the Field Widget Actions module. On *Manage form display*, a site builder attaches the "Load Document" action to a source field widget (text, file, image, media reference, or link) and picks a destination field plus an output format. On the entity edit form, clicking the button reads the source value, resolves it to a Document Loader input (`['file_input' => …]` or `['url' => …]`) via the shared `InputResolverTrait`, runs `DocumentLoaderManager::loadFromData()` as the current user, and injects the extracted content into the destination field — a rich-text editor (`FillEditorCommand`) or a plain field (`FillSimpleFieldCommand`) — without saving or rebuilding the form. Destination fields must be `text_long`, `text_with_summary`, or a JSON type on the same form display; JSON destinations force JSON output. Per-loader options are stored in the action config using the `dl__{loader_id}__{option_key}` convention.

---

- Add a button beside a file-upload widget that pulls the uploaded PDF's text into the body field.
- Extract an uploaded Word/spreadsheet document into a formatted-text field on click.
- Let editors paste a URL into a text field and load the page's content into another field.
- Load a document referenced through a media-library widget into a destination field.
- Extract content from a link field's URL into a body field.
- Populate a JSON field with `{"content": "..."}` from an extracted document (auto-forced JSON output).
- Give content editors one-click document import without leaving the node form.
- Choose text / HTML / markdown / JSON output per action configuration.
- Configure per-loader extraction options (e.g. strategy) directly in the action settings.
- Keep the source file widget's own upload AJAX intact (the action uses a static, no-rebuild callback).
- Attach the action to string, string_long, text, text_long, text_with_summary, file, image, entity_reference, or link widgets.
- Restrict destination options to eligible fields actually present on the current form display.
- Import a stream-wrapper URI (public://…) typed into a text field as a file load.
- Provide a provider-free, on-demand alternative to the cron-based AI Automator extraction.
- Fill a WYSIWYG editor instance directly with extracted markdown/HTML.
