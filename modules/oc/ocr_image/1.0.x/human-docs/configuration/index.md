# Configuration

OCR image, document parser has no central settings page. You turn it on **per
field**, by switching that field's widget to the OCR widget on the entity's
**Manage form display** tab. When a file is uploaded through that widget, the
module extracts the text and writes it into the field(s) you've told it to fill.

## Set up an image field for OCR

1. Add (or reuse) an **image field** on your content type or entity.
2. On that bundle's **Manage form display** tab, change the field's widget to
   **OCR image**.
3. In the widget's settings, turn on the destinations you want the extracted text
   to fill:
   - **Enable Alt field** — puts extracted text into the image's *alt* text.
   - **Enable Title field** — puts extracted text into the image's *title*.

   (For an image, the extraction splits naturally — the first line can serve as a
   title and the remainder as alt text.)

## Set up a file field for documents

1. Add (or reuse) a **file field** that accepts documents (PDF, `doc`, `docx`,
   `xls`, `xlsx`, `ppt`, `pptx`).
2. On **Manage form display**, change the field's widget to **OCR / parser file**.
3. Turn on **Enable Description field** so the parsed document text is written into
   the file's *description*.

## Widget options

Whichever widget you use, configure:

- **Language** — the OCR/parse language (for example `eng`). Make sure the matching
  Tesseract language pack is installed on the server.
- **Limit text** — the maximum length of extracted text to store. Set **0** for the
  full text.

You can also **map the extracted text into a separate text field** (and hide that
field on the form if you like), which is handy when you want the OCR output in a
dedicated, searchable field rather than in alt/title/description. Save the form
display when you're done.

## Backfilling existing files in bulk

To OCR files that were uploaded before you enabled the widget, use **Views Bulk
Operations**:

1. Optionally add a text field to the entity to receive the extracted text.
2. On the entity's **Manage form display**, set the image field's widget to **OCR
   image** and configure it as above.
3. Create a View listing those entities and add the **Bulk operations** field, then
   save.
4. Select the entities and run **"Update empty image text (Image OCR)."**

## A note on processing

OCR runs **server‑side** on the uploaded files and can be resource‑intensive on
large images or documents. Because this is local processing (Tesseract and PHP
libraries), there are no external service credentials to store — but do make sure
the tooling is adequately resourced and that only trusted roles can upload the
files you process.
