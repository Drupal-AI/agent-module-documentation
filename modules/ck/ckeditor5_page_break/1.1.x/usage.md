<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
CKEditor5 page break lets an editor insert an explicit page break, controlling where a printed or exported document divides.

---

Content that is going to be read on paper has structural requirements a web page does not. A report's chapters should start on a new page. A form should not have its signature block split across a page boundary. A contract's clause should not be orphaned with its heading on the previous sheet. A certificate is one page and must stay one page. Browsers decide page breaks by flowing content, and the result is arbitrary — so a document generated from a Drupal page divides wherever the flow lands, which is a problem the moment the output is a formal artefact rather than a printout of a web page. An explicit break gives the editor the control the content needs. Version **1.1.1** on `^9 || ^10 || ^11`, depending on core `ckeditor5`. Three things worth attaching. **The break is `page-break-after: always` in print CSS**, so it does nothing on screen and everything on paper — which means an editor cannot see its effect without previewing print, and a page break inserted and forgotten is invisible until someone prints. **PDF generation has to respect it**, and whether it does depends entirely on the generator: a headless browser honours print CSS, while some library-based generators ignore it, so this is a feature to test against the site's actual export path rather than assume. And **the element must survive the text format** — a page break is markup, and a filter that strips unknown elements removes it silently, which is the commonest reason it "does not work".

---

- Start a report chapter on a new page.
- Keep a signature block on one page.
- Control where a PDF divides.
- Prevent a clause splitting across pages.
- Keep a certificate to one page.
- Format a printed document properly.
- Control page breaks in an export.
- Start an appendix on a new page.
- Keep a table with its heading.
- Format a printable form.
- Control division in a Word export.
- Keep a summary on its own page.
- Format an annual report for print.
- Prevent an orphaned heading.
- Control pagination in a policy document.
- Format a printable agenda.
- Keep an invoice on one page.
- Divide a long document deliberately.
