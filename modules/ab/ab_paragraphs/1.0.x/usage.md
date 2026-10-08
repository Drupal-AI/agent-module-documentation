AB Paragraphs adds an "A/B Test" Paragraphs bundle that shows one of two content variants per visitor session and fires analytics events, while keeping the page fully cacheable.

---

The module installs a paragraph type `ab_test` with two entity-reference-revisions fields (`field_variant_a`, `field_variant_b`) that hold nested paragraphs, plus per-variant tracking-code text fields, a unique-ID string, and a distribution list (50/50, 90/10, 10/90, 70/30, 30/70). Both variants are rendered into a cacheable `.ab-test-wrapper` container; a JavaScript behavior (`Drupal.behaviors.abTest`) picks a variant client-side using `sessionStorage` keyed by the unique ID and the distribution threshold, hides the other, and — only if analytics consent is detected — pushes "Show" and link-"Click" events into whichever analytics library is on the page. A settings form chooses the analytics provider (Matomo, Piwik Pro, Google Analytics, or Google Tag Manager) and an editor-side helper suggests tracking snippets from links found in each variant. The module performs no reporting of its own; it depends only on Paragraphs and requires you to manually enable the fields on the ab_test form and view displays after install.

---

- Run a landing-page A/B test by placing two hero variants inside a single A/B Test paragraph.
- Test two different call-to-action buttons (Variant A vs Variant B) and track which gets more clicks.
- Split traffic 90/10 to soft-launch a new content block to a small slice of visitors.
- Keep a page fully cacheable while still doing A/B testing, since variant choice is client-side.
- Show a consistent variant to each visitor for the length of their browser session via sessionStorage.
- Test alternative promotional banners and measure impressions with a "Show" event per variant.
- Compare two versions of a pricing table or feature grid built from nested paragraphs.
- Fire Matomo/Piwik Pro events (`_paq`) for variant impressions and link clicks without custom code.
- Fire Google Analytics (`gtag`) or Google Tag Manager (`dataLayer`) events instead, chosen in settings.
- Respect cookie consent by only tracking after Cookiebot, Klaro, or Osano/CookieConsent grants analytics consent.
- Test two different embedded media items (image vs video variant) inside the same content slot.
- A/B test wording of a newsletter sign-up prompt and track click-through on the sign-up link.
- Give each experiment a stable Unique ID for analytics segmentation and reporting in your analytics tool.
- Weight an experiment toward the safer control (e.g. 70/30) while gathering data on a challenger.
- Let editors build variants with any existing paragraph types (text, cards, CTAs, media) via nested paragraphs.
- Use the in-form tracking-code suggestions to copy ready-made event snippets for links in each variant.
- Point tracking at whichever analytics provider your site already runs, auto-reading its configured URL.
- Test layout variations of a section without duplicating whole pages or nodes.
- Verify variant selection during development with the module's optional JS debug logging flag.
- Cleanly remove an experiment: uninstalling the module deletes all ab_test paragraphs and their nested content.
- Run experiments on both new-node and node-edit forms, where the editor helper library is auto-attached.
- Provide marketing teams a lightweight, self-hosted A/B testing option that needs no external SaaS service.
