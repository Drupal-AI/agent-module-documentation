<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Microsoft Document Viewer renders a file field as an embedded Office document, using Microsoft's hosted viewer at `view.officeapps.live.com`.

---

Word, Excel and PowerPoint files attached to a site are normally a download link: the visitor saves the file, opens it in whatever they have, and leaves the page. For documents meant to be read rather than kept — a report, a price list, a slide deck — an inline viewer is a better experience and keeps the visitor on the site. Microsoft operates a free hosted viewer for exactly this, and this module wires a file field to it, generating an absolute file URL with `FileUrlGenerator` and embedding `https://view.officeapps.live.com/op/embed.aspx?src=…`.

**Understand what that means before deploying it.** The document is not rendered by your server or by the visitor's browser: Microsoft's servers fetch the file from your site and render it. Two consequences follow, and both are structural rather than bugs in the module.

First, **the file must be publicly reachable from the internet**. A private-filesystem file, an intranet site, or anything behind HTTP authentication will not render, because Microsoft's fetcher cannot get it. If it does render, the file is public — those are the only two outcomes.

Second, **every document displayed this way is sent to a third party**. The URL is handed to Microsoft, whose infrastructure retrieves and processes the content. For a published brochure that is unremarkable; for anything with personal data, commercial confidentiality or an internal audience it is a disclosure that needs a decision and, in the EU, a lawful basis and a mention in the privacy notice. Do not attach this formatter to a field that can hold restricted documents.

---

- Display a Word document inline on a page.
- Embed a spreadsheet without a download.
- Show a slide deck in the browser.
- Let visitors read a report without leaving the site.
- Preview an attached document before downloading it.
- Show a public price list as a spreadsheet.
- Render a document for visitors without Office installed.
- Display a published brochure inline.
- Add a viewer to an existing file field.
- Configure the viewer per field display.
- Keep visitors on the page while reading a document.
- Avoid running a document conversion service.
- Confirm a file is genuinely public before embedding it.
- Decide whether sending documents to Microsoft is acceptable.
- Choose a self-hosted viewer where it is not.