Embed Calendly stores a Calendly API key, lists your Calendly event types in the Drupal admin, and one-click generates a custom block holding the Calendly inline-widget embed for a chosen scheduling page.

---

The module (machine name `calendly`, package "Calendly", human name "Embed Calendly") is a thin admin-only integration with Calendly's scheduling SaaS. On its settings form (`/admin/config/calendly/api`) you paste a Calendly personal API key (a bearer token) and your Calendly organization id; both are saved into the `calendly.settings` config object. An "Event Sync" action calls Calendly's `GET /event_types` REST endpoint over HTTPS with that bearer token, stores the raw JSON response back into config, and an events list page renders it as a table. Each row has a "Generate Block" link that creates a `block_content` "basic" custom block whose full_html body is the standard Calendly inline-widget snippet (`<div class="calendly-inline-widget" data-url="…">` plus `assets.calendly.com/external/widget.js`) pointed at that event's scheduling URL. You then place that block through the normal Block Layout UI. There are no fields, no formatters, no plugins, no Drush commands, and no public-facing routes — everything lives under `/admin/config/calendly` and is intended for a site administrator. The generated embed is plain client-side Calendly JavaScript, so all scheduling happens on Calendly's own widget; Drupal only holds the API key and the generated block markup.

---

- Embed a Calendly scheduling page ("book a meeting" widget) anywhere on a Drupal site via a generated block.
- Let site visitors book appointments/consultations without leaving your Drupal pages.
- Centralize a Calendly API key and organization id in one Drupal config form instead of hand-coding embeds.
- Pull the list of your Calendly event types into Drupal so editors can pick which one to embed.
- One-click turn a Calendly event type into a reusable Drupal custom block (no manual copy/paste of embed HTML).
- Add a "Schedule a demo" widget to a landing page by placing the generated block in a region.
- Add a "Book a consultation" block to a services page or sidebar.
- Offer office-hours / support-call scheduling on a contact or help page.
- Provide event-registration or interview-scheduling widgets on campaign pages.
- Give a sales team a self-service meeting-booking embed on product pages.
- Maintain several Calendly event types (intro call, demo, onboarding) each as its own Drupal block.
- Re-sync event types after adding/renaming events in Calendly using the "Event Sync" action.
- Reuse a generated block across multiple pages, layouts, or content types via Block Layout.
- Keep the Calendly widget's look/behaviour managed entirely by Calendly while Drupal only hosts the placement.
- Stand up a quick scheduling integration on Drupal 9, 10, or 11 without writing custom embed code.
- Prototype a booking flow for a client demo by generating a block in minutes.
- Store the fetched Calendly event catalogue in Drupal config for display without repeated API calls on every page view.
- Give non-technical admins a UI (config form + events list) instead of the Calendly developer docs.
- Add a scheduling call-to-action to a marketing or agency site backed by Calendly.
- Serve appointment booking for coaching, tutoring, or professional-services sites.
- Combine the generated block with core Block visibility conditions to show scheduling only on chosen pages.
