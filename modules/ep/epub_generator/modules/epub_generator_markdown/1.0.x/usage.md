<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Converts uploaded Markdown (.md) files to ePub ebooks, with a file-field formatter and YAML front matter support.

---

ePub Generator: Markdown converts uploaded Markdown files into ePub ebooks. It adds a **Markdown with ePub download** field formatter for core file fields: alongside the normal file link, any `.md` or `.markdown` file gets a **Download as ePub** button that converts the file on demand. Conversion uses the `league/commonmark` library (CommonMark core plus GitHub-Flavored Markdown). A Markdown document may begin with a YAML front-matter block (delimited by `---`) supplying book metadata — title, author(s), publisher, ISBN, edition, description, rights/copyright, language, date, and subjects/tags — and the body is split into chapters on `#` headings, with `##` headings becoming nested sub-chapters. Content before the first heading becomes a "Preface". Per-field-instance layout settings (reflowable or fixed-layout with viewport, spread and orientation) are passed through to the generator. Requires the base module and the `league/commonmark` Composer package.

---

- Offer a **Download as ePub** button next to uploaded `.md`/`.markdown` files.
- Convert a Markdown file to a complete ePub ebook on demand.
- Read book metadata from a YAML front-matter block at the top of the file.
- Set the ebook title from front matter, the first `#` heading, or the filename.
- Provide one or more authors via `author`/`authors` (string, comma list, or YAML list).
- Populate publisher, ISBN, edition, subtitle, rights/copyright and description from front matter.
- Tag the ebook with subjects from `subjects` or `tags`.
- Set the publication date and language from front matter.
- Split a long Markdown document into chapters on `#` (H1) headings.
- Nest sub-chapters under a chapter using `##` (H2) headings.
- Turn content before the first heading into a "Preface" chapter.
- Keep `#`-prefixed lines inside fenced code blocks from being treated as headings.
- Enforce a fixed-layout ePub per field instance (viewport, spread, orientation).
- Enable the "Markdown with ePub download" formatter on any file field via Manage display.
- Publish documentation or manuals authored in Markdown as portable ebooks.
- Let content teams keep writing in Markdown while readers get ePub downloads.
- Convert Markdown programmatically via the `epub_generator_markdown.converter` service.
- Preserve GitHub-Flavored Markdown features (tables, task lists, strikethrough) in output.
