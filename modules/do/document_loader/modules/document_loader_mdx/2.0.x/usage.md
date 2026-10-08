Adds a "Load Document" button to the AI module's MDXEditor toolbar that imports a document (converted to markdown) straight into the editor.

---

Document Loader: MDXEditor extends the AI module's MDXEditor with a document-import button. A page-attachments hook injects a small library on every page that inserts the button whenever an MDXEditor textarea is present; clicking it opens a modal dialog (`document_loader_mdx.dialog`). The dialog uses `DocumentLoaderManager::discoverSourceCategories()` to show only source categories whose loaders can produce markdown or text, renders the category's fields (files via the Drupal media library, other categories via schema-driven fields), and on submit runs `DocumentLoaderManager::loadFromData()` with `caller: 'mdx_editor'`. The returned content is passed through `MdxContentSanitizer` (which strips HTML tags/comments and normalizes code-fence languages MDXEditor cannot handle) and inserted into the editor's underlying textarea via a custom AJAX command. It requires the AI module at 1.4+ (an install-time requirement check verifies the `drupal:mdx-fill` hook is present) plus the Document Loader media-library opener.

---

- Add a "Load Document" button to every MDXEditor instance on the site.
- Import a PDF selected from the media library directly into a markdown editor.
- Load a web page's content as markdown into the editor without leaving the page.
- Pull an API response into the editor as text/markdown.
- Give content authors one-click document ingestion inside the AI markdown editor.
- Reuse the Drupal media library (documents) as the file picker for editor imports.
- Automatically convert imported documents to markdown (editor content is always markdown).
- Sanitize imported markdown so MDXEditor's import visitors don't choke on unsupported constructs.
- Switch source category (file / website / api / …) within the dialog based on installed loaders.
- Redirect a typed file URL (e.g. https://…/report.pdf) to file download+extract instead of page scraping.
- Configure per-loader extraction options in the dialog for the active category's loaders.
- Restrict the offered sources to those whose loaders actually support markdown/text output.
- Provide a provider-free document-to-editor path (extraction is native to Document Loader).
- Insert extracted content at the editor's textarea and have it saved on the next form submit.
