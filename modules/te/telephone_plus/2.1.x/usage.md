<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Telephone Plus is a field type for a phone number with the things that surround one — a label, an extension, and supplementary text — rendered as plain text or a `tel:` link.

---

A phone number is rarely just a number, and modelling it as one is why contact details on Drupal sites read badly. A department has a main line and an extension. A helpline has opening hours attached. An office has a number and a note saying "ask for the duty officer". A mobile is labelled "out of hours". Sites express those as a plain telephone field plus a separate text field, or as free text in a body field, and the first cannot be rendered consistently while the second cannot be linked, searched or exported. Keeping the parts together as one field means the display is configured once and every number on the site looks the same. Version **2.1.3** on `^9 || ^10 || ^11`, depending on core `field` and `telephone`. Three things worth attaching. **A `tel:` link is the point on mobile** — it is the difference between a number a visitor taps and one they memorise and retype — so the formatter's link behaviour matters more than its text, and the number in `href` must be in a dialable form (digits and `+`, no spaces or brackets) even when the visible text is formatted for reading. **An extension does not belong in the `tel:` href** without the pause syntax (`,` or `;ext=`), and getting that wrong produces a link that dials the switchboard and stops. And **numbers are personal data when they belong to a person**, so a staff directory publishing direct lines is a disclosure decision — which is exactly the sort of thing a supplementary-information field makes easy to get right, by carrying "reception will transfer you" instead of the individual's number.

---

- Store a number with an extension.
- Add a label to a phone number.
- Show opening hours beside a helpline.
- Add a note to a contact number.
- Render a tel: link on mobile.
- Build a staff directory's contact details.
- Show a department's main line.
- Add out-of-hours labelling to a number.
- Store several numbers with context.
- Display contact details consistently.
- Add a switchboard note to a number.
- Show an international dialling format.
- Build an office locations listing.
- Add a "ask for" note to a number.
- Render a clickable helpline number.
- Store a mobile with a label.
- Show a fax number distinctly.
- Publish contact details for a service.
