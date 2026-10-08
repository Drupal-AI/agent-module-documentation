<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Views vCards adds a Views **display**, **style**, and **row** plugin that export the results of any View (typically users or a contact entity) as downloadable vCard (`.vcf`) files, mapping Views fields onto standard vCard properties.

---

The module ships three cooperating Views plugins — display `views_vcard` (a path display extending core `PathPluginBase`, `returns_response = TRUE`), style `views_vcard_style`, and row `views_vcard_fields`. You add a *vCard* display to a View, set its Format and Show to "vCards", give it a path, and in the row settings map each vCard property (first/middle/last/full name, title, up to three emails, photo, and home/work address, phone, cellphone, fax, website, company) to a field added to the View. Visiting the path streams a single `.vcf` when the View returns one row, or a ZIP of many `.vcf` files (built with the `maennchen/zipstream-php` library) when it returns more than one. The optional *Attach to* setting adds a downloadable vCard icon/link onto another display of the same View (e.g. a user list page), passing through the list's exposed-filter input so the export matches the current filters. Output is themed via the `views_vcards_view_row_vcard` template; `hook_preprocess` runs each field value through `Xss::filter` + `strip_tags` (keeping only `<a>`) before it is written into the card, and the photo field is passed through as an image. Access control is inherited from the View's own access plugin (permission/role/none) exactly like any other Views path display — the module adds no access logic of its own, so restrict the display via the View if it exposes user PII. Twig debug mode must be off (a runtime requirement warns otherwise), since debug markup would corrupt the exported cards.

---

- Export site users as vCards for import into Outlook, Apple Contacts, or a phone address book.
- Publish a downloadable "download my contact card" link on a user profile view.
- Export a filtered list of users (by role, department, etc.) as a single ZIP of vCards.
- Map a full-name field or separate first/middle/last name fields to a vCard.
- Include up to three email addresses per contact in the exported card.
- Add a contact photo (image field) to the vCard, optionally via an image style.
- Include home address, city, state, zip, country, phone, cellphone, and website.
- Include work title, company, address, phone, fax, and website.
- Provide a `user/%/vcard.vcf` path using a contextual filter so each user has a personal vCard URL.
- Attach a vCard download icon to an existing user-list page display.
- Have the export automatically respect exposed filters selected on the attached list.
- Build an organisation-wide staff directory that visitors can save to their contacts.
- Export a custom "contact" or "person" content type to vCard, not just core users.
- Stream large exports efficiently as a ZIP via ZipStream rather than buffering in memory.
- Generate uniquely named `.vcf` files (transliterated names, de-duplicated with numeric suffixes).
- Offer members a self-service export of their own contact details.
- Deliver contact data to external CRM/mail clients without a custom export script.
- Restrict who can download the vCards by setting the View display's access (permission/role).
- Give event attendees a scannable/downloadable organiser contact card.
- Turn a taxonomy of locations/offices into downloadable contact cards.
- Provide sales teams a filtered lead list as importable contacts.
