A field formatter for core email fields that shows a clickable link instead of the address and reveals the real email in place via AJAX only when a visitor clicks it.

---

Email Hidden Formatter provides one field formatter, "Email Hidden" (plugin id `email_hidden`), selectable on Manage display for any field of type `email`. Rather than printing the address, it renders a configurable text link (default label "Show email"). When the visitor clicks the link, an AJAX request goes to the module's route, which re-renders that same email field with its normal formatter and swaps it into the page, so the address appears on demand. Because the address is not present in the initial page markup, casual scrapers that read the served HTML do not see it, while real visitors get the address with a single click. The formatter honors the field's label-visibility choice (hidden, inline, above) from Manage display, requires no external JavaScript libraries or dependencies beyond Drupal core, and is configured entirely per view-display — there is no site-wide settings page. It targets Drupal 10 and 11 and depends only on core `field`.

---

- Hide staff email addresses on a "Team" or "About us" page behind a "Show email" link.
- Protect the contact email on node-based contact or business-listing pages from HTML scraping.
- Reveal a member's email on a user profile only after a deliberate click.
- Show a "Reveal email" link on a directory of vendors, partners or suppliers.
- Keep support or sales addresses out of the raw page source on a landing page.
- Display author contact emails on article or blog nodes without exposing them inline.
- Offer an on-demand email on event organizer or speaker profiles.
- Present agent or realtor emails on property-listing entities behind a click.
- Hide practitioner emails on a clinic or practice staff-listing page.
- Gate the email on job-posting entities so applicants click to reveal the recruiter address.
- Reduce email harvesting on public committee or board-member pages.
- Provide a click-to-show email for course instructors in an education catalog.
- Keep department contact emails hidden on an organizational directory until requested.
- Customize the reveal link text per display (e.g. "Contact by email", "Reveal address").
- Use different reveal-link labels across view modes (teaser vs. full) for the same email field.
- Combine with the field label-visibility settings (hidden/inline/above) to control how the revealed address is captioned.
- Apply selectively per content type and per view display without touching other formatters.
- Swap in the formatter through configuration (view-display config) as part of a deployment.
- Offer a lightweight, dependency-free alternative to JavaScript email-obfuscation libraries.
- Keep the address out of the initial render for pages that are cached and served widely.
- Let editors add an email field and get click-to-reveal behavior with no extra setup.
- Display membership or association contact emails behind a reveal link on public rosters.
- Show press or media-contact emails on a newsroom page only after interaction.
- Use on multilingual sites where the reveal link text can be translated per configuration.
