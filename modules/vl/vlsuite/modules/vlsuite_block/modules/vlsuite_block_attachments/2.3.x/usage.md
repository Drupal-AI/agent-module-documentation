<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
VLSuite Block Attachments places a set of downloadable files as a component.

---

Documents are a recurring landing-page need — a brochure, a specification, a set of forms, an annual report — and the usual implementations are a list of links pasted into body text, which loses file size, type and any consistent presentation.

This component makes attachments structured: files as media entities, rendered with whatever the design specifies, placed where the page needs them.

Two things worth stating. **File type and size belong in the link text.** A visitor about to download something should know it is a 12MB PDF before they tap it on mobile data; that is a usability requirement and, in many public-sector accessibility standards, an explicit one. Check whether the component renders it.

And **private files behave differently.** A file in `private://` is served through Drupal with access checks, which works but means downloads are not cacheable at the edge — relevant if a document is popular. A file in `public://` is directly served and directly guessable, which is fine for a brochure and not for anything restricted.

---

- Offer a brochure for download.
- Attach a specification to a landing page.
- Present a set of forms for download.
- Show an annual report as a download.
- Structure attachments as media entities.
- Show file type and size to visitors.
- Style a download list consistently.
- Replace pasted links in body text.
- Serve a restricted document privately.
- Understand private file caching implications.
- Translate attachment labels.
- Reuse an attachment set across pages.
- Audit documents offered for download.
- Check accessibility of download links.
- Track which documents are downloaded.
