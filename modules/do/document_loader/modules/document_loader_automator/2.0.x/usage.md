AI Automator plugin types that extract a source field's document content through Document Loader and write it into a destination field — with no AI provider required.

---

Document Loader: AI Automator bridges Document Loader into the AI Automators framework. Each provided automator reads a configured base (source) field, resolves its value to a Document Loader input (file URI, media entity, link, or plain-text URL/URI) via the shared `InputResolverTrait`, runs `DocumentLoaderManager::loadFromData()` with the chosen output format, and stores the extracted content in the destination field the automator is attached to. Because the base class extends the AI Automators `ExternalBase` (not an LLM base), no provider, model, or prompt is needed — it runs deterministically on entity insert/update, cron, VBO, or ECA. Output formats are discovered dynamically from whatever loader plugins are installed, and one plugin is shipped per destination field type. It depends on `document_loader` and the `ai_automators` submodule of the AI module.

---

- Auto-populate a `text_long` body field with the extracted text of an uploaded PDF whenever a node is saved.
- Convert an uploaded Word/spreadsheet file to markdown and store it in a formatted-text field.
- Extract a linked web page's content into a `string_long` field on cron with no AI cost.
- Store extracted document content as JSON in a `json` / `json_native` / `json_native_binary` field.
- Run bulk document extraction across existing content via VBO using the automator action.
- Wire document extraction into an ECA workflow triggered by entity events.
- Populate a text field from a media-reference field whose media is a file-backed document.
- Pull content from an oEmbed/URL-backed media entity into a text field.
- Choose the output format (text, HTML, markdown, JSON, …) per automator configuration.
- Set a specific text format for formatted-text destinations so cron (anonymous) runs render correctly.
- Keep a summary field empty while filling the main value on a `text_with_summary` destination.
- Provide deterministic, provider-free document-to-field automation for compliance/repeatability.
- Chain with other automators (the extracted text feeds a later AI summarization step).
- Migrate legacy file attachments into inline text content on save.
- Normalize many source field types (file, image, media, link, string, text) through one automator.
