<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
AI Simple PDF to Text extracts plain text from PDF files locally, using the pure-PHP smalot/pdfparser library, for use by Drupal AI automators and AI agent function calls.

---

AI Simple PDF to Text is a small AI Tools add-on for the `drupal/ai` framework. It ships two things: AI Automator type plugins that fill a `string_long` or `text_long` field with the text of a PDF held in a file field on the same entity, and an AI function-call tool (`simple_pdf_to_text`) that AI agents/assistants can invoke to read the text of a PDF given a Drupal file ID or a file location. All parsing is done on the server with `smalot/pdfparser` (`Smalot\PdfParser\Parser::parseFile()`), so there is no dependency on external command-line tools such as `pdftotext` or Ghostscript and no shelling out. The module itself does not call any AI provider or send the PDF anywhere — it only turns a PDF into a string; whatever consumes that string (an automator chain, an agent) decides what happens next. It is deliberately basic; for higher-quality extraction the maintainers point to the Unstructured module.

---

- Extract the text of an uploaded PDF into a text field via AI Automators.
- Populate a `text_long` field from a PDF file field with the `simple_pdf_to_text_text_long` automator.
- Populate a `string_long` field from a PDF file field with the `simple_pdf_to_text_string_long` automator.
- Give an AI agent the `simple_pdf_to_text` tool to read a PDF by Drupal file ID.
- Give an AI agent a tool to read a PDF by file URI/location.
- Index PDF contents so they can be summarised or embedded later in an AI workflow.
- Convert scanned-but-text-layer PDFs into editable body text on nodes.
- Prepare PDF text for chunking and vector storage in a RAG pipeline.
- Feed PDF text into a chat prompt built by another module.
- Avoid installing pdftotext/Ghostscript on the server (pure-PHP parsing).
- Keep PDF processing fully on-server (no external service call by this module).
- Run PDF-to-text as one step of a larger AI Automator chain.
- Auto-fill a document summary field after a content editor uploads a PDF.
- Migrate legacy PDF attachments into searchable text content.
- Build agent tools that answer questions about an uploaded document.
- Extract text from contracts, reports, or manuals attached to entities.
- Use the extracted text with any AI provider the site has configured elsewhere.
- Combine with taxonomy/entity automators to classify a document from its text.
- Provide a portable, dependency-light PDF reader for custom AI code.
- Fall back to a simpler tool when full OCR/layout parsing is not required.
