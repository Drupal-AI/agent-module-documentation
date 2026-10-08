Submodule of USWDS Paragraph Components that installs a USWDS **summary box** paragraph type — a highlighted callout of key information rendered as `usa-summary-box` markup.

---

Enabling this submodule imports a single `uswds_summary_box` paragraph bundle with two fields: `field_header` (the box heading) and `field_text` (formatted body). The template `paragraph--uswds-summary-box.html.twig` renders `<div class="usa-summary-box" role="complementary">` with a `usa-summary-box__heading` and a `usa-summary-box__text` region containing the rendered body (`{{ content.field_text }}`, formatter-rendered). No CSS library is shipped — the styling comes from the theme's USWDS assets. Expose `uswds_summary_box` on your Paragraphs field. This is the simplest component in the suite (a single flat bundle, no nested paragraphs).

---

- Highlight key takeaways or important information in a bordered USWDS summary box.
- Add a "what you need to know" callout to a service or program page.
- Summarize eligibility or requirements above the main content.
- Provide an accessible complementary region (role="complementary") for supporting info.
- Give the box a clear heading plus formatted body text.
- Embed a summary box inside body content via a Paragraphs field.
- Nest a summary box inside a columns layout.
- Reuse a standardized callout component across a federal site.
- Render body text through its text formatter for safe formatted output.
- Override `paragraph--uswds-summary-box.html.twig` to adjust heading level or markup.
- Combine a summary box with alerts or process lists on the same page.
- Draw attention to deadlines, contact info or next steps.
- Build a consistent key-info callout without hand-building the bundle.
- Place a summary box at the top of a long article as an at-a-glance summary.
- Call out contact information or office hours in a bordered box.
