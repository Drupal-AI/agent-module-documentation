<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Views HTML Tags adds one admin settings page that widens the list of HTML elements offered in a Views field's *Style settings*, so a field can be wrapped in the element the markup actually calls for.

---

Every Views field has "Customize field HTML" and "Customize field and label wrapper HTML" options with an **HTML element** dropdown; core populates that dropdown from a single config value, `views.settings:field_rewrite_elements`. This module ships nothing but a form to edit that value: install it, enable the `administer views html tags` permission, and go to **Configuration → User interface → Views HTML tags** (`/admin/config/user-interface/views-html-tags`). The form shows the current elements as a comma-separated list; you type the full set you want — for example `div,span,article,section,time,address,figure,figcaption,mark,abbr,dl,dt,dd` — and submit. Each entry is stored lowercase as the option key and uppercase as its label, and the list is written back to core, so the new elements appear in the dropdowns of **every** view site-wide (the submitted list **replaces** the previous one, so keep the elements you still need). Input is validated to letters, digits, and commas only, so tag names carry no attributes or markup. There is no Views plugin, service, or field handler involved — just the config value core already reads. The reason to care is not tidiness: **semantic elements are what assistive technology and search engines read** — a `time` element with a `datetime` attribute is a machine-parsable date where a `div` is only a string, and an `article` marks a self-contained item where a `div` marks nothing. The caveat is that **an element used wrongly is worse than a neutral one**: a screen reader announcing a heading that is not a heading, or a list whose items are not list items, actively misleads, so widening the palette needs someone who knows what the elements mean.

---

- Add an `article` element to a Views field's wrapper dropdown, then wrap card items in it.
- Offer a `time` element so a date field can be wrapped in `<time>`.
- Add `address` for a contact-details field in a directory listing.
- Add `figure` and `figcaption` for an image-with-caption field.
- Add `section` for grouping in a structured listing.
- Add `mark` to highlight a matched term in search results.
- Add `abbr` for an acronym or abbreviation field.
- Add `dl`/`dt`/`dd` to build a definition-list style output.
- Widen the wrapper options once and reuse them across all views site-wide.
- Improve a listing's semantic structure without a Twig template override.
- Meet an accessibility audit requirement for semantic markup.
- Support structured-data / microformat extraction from view output.
- Improve search-engine understanding of listed content.
- Restore or trim the element list back to a known set via the same form.
- Standardize the allowed wrapper elements editors may pick in Views.
- Produce cleaner, more meaningful markup from Views blocks and pages.
- Support a semantic design system's element conventions.
- Prepare view output for schema.org / rich-result markup.
- Give a card component a real `article` root instead of a bare `div`.
- Configure the element palette programmatically via `views.settings:field_rewrite_elements`.
