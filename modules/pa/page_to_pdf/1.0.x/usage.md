<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Soapbox PDF (page_to_pdf) is a PDF generator that produces PDF versions of page content.

---

Soapbox PDF (project `page_to_pdf`) is a PDF generator — producing PDF versions of page/content, so
visitors or editors can download content as a PDF (reports, articles, printable pages). It is in the
Soapbox package.

Use it to offer PDF downloads of content. PDF generation typically relies on a server-side rendering
library (headless browser or a PDF toolkit); note that generating PDFs from arbitrary content/URLs can be a
resource and security consideration (if the content/URL to render is user-influenced, ensure it can't be
pointed at internal resources — SSRF — and keep the rendering tooling patched). For rendering the site's own
content it is a display/utility feature. It has no access-control role beyond what content it renders (a PDF
of content the requester can already see). Configure the PDF generation.

---

- Generate PDFs from page content.
- Offer PDF downloads.
- Produce printable content.
- Render content as PDF.
- Handle reports/articles as PDF.
- Use a server-side PDF renderer.
- Keep the rendering tooling patched.
- Avoid SSRF if the URL is user-influenced.
- Render the site's own content.
- Mind resource use of PDF generation.
- Have no access role beyond rendered content.
- Download content as PDF.
- Configure PDF generation.
- Produce PDF versions.
- Generate printable PDFs.
- Render pages to PDF.
- Offer downloadable PDFs.
- Create PDFs.
- Handle PDF output.
- Generate document PDFs.
