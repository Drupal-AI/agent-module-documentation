Current Year adds a text-format input filter that replaces the literal token `&year;` with the current four-digit year at render time.

---

Current Year is a tiny display helper for keeping year references (most often a footer copyright line) up to date without editing content every January. It ships a single filter plugin, `filter_current_year` ("Current Year"), that you enable on a text format. Anywhere that format is applied, the sequence `&year;` (or `&amp;year;`) is replaced with the server's current year, wrapped in a `<span class="js-current-year">` element. A small `Drupal.behaviors` script (`js/current_year.js`) then refreshes that span client-side, so even a fully page-cached copy served on January 1 shows the right year. The year value comes solely from PHP's `date('Y')` / the browser clock — no user input is involved. There is no admin form, no route, no permission, and no dependency beyond Drupal core's Filter module.

---

- Keep a footer copyright line ("© &year; Acme Ltd") current without annual edits.
- Insert the current year into node body text on any filtered field.
- Show the current year inside a custom block that uses a filtered text format.
- Add a dynamic year to a "Basic page" legal or about section.
- Render "&year;" in a Views text/global custom field that runs through a text format.
- Display the year in a site slogan or tagline block.
- Avoid stale years across many pages that would otherwise need manual updating each January.
- Use in email/newsletter body content rendered through a filtered format.
- Combine with other filters (place after "Convert line breaks", before/after HTML restriction as needed) on a text format.
- Enable the filter on a restricted "Full HTML" format used only by trusted editors.
- Provide a copyright-year token to content editors who cannot edit templates.
- Keep terms-of-service or privacy pages showing the current year.
- Show the year in a CTA banner or promotional block.
- Ensure cached/BigPipe-delivered content still shows the correct year via the JS fallback.
- Add a live year to a "Powered by" or attribution line.
- Use the token in a menu link description or field that supports formatted text.
- Insert the year into event or seasonal copy ("&year; Winter Sale").
- Standardize the year format (four digits) across a multi-editor site.
- Replace hardcoded year digits during a content migration cleanup.
- Provide a designer-friendly token that survives content re-saves.
- Enable only on the specific text format(s) that need it, leaving others untouched.
