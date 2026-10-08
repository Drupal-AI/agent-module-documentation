Adds a CKEditor 5 toolbar dropdown that inserts one or more paragraphs of Lorem Ipsum placeholder text into the editor.

---

CKEditor5 Lorem Ipsum Plugin registers a client-side CKEditor 5 plugin (`loremIpsum`) that appears as a toolbar dropdown. Choosing an item runs the `loremIpsum` command, which builds placeholder text from a fixed word list bundled in the plugin's JavaScript and inserts it as plain paragraph elements at the cursor. There is no server component beyond the module wiring: no routes, permissions, config forms, config schema, or Drush commands, and text is generated entirely in the browser (no external service is contacted). It depends only on core's `ckeditor5` module and is enabled per text format by adding the "Lorem Ipsum" button to that format's CKEditor 5 toolbar under Text formats and editors.

---

- Quickly fill a body/rich-text field with placeholder paragraphs while building a page layout.
- Insert dummy copy so a theme or component can be previewed with realistic text length.
- Give content editors a one-click way to add Lorem Ipsum without pasting from an external site.
- Populate a new content type's demo nodes for design review.
- Generate placeholder text for teaser/summary areas during content modeling.
- Fill card, hero, or callout components in a page builder to test spacing and wrapping.
- Produce filler paragraphs for print/PDF export mockups generated from CKEditor content.
- Stress-test responsive typography by inserting multiple paragraphs at once.
- Seed example content in a training or documentation environment.
- Add placeholder text to email-template body fields edited with CKEditor 5.
- Let designers evaluate line-height and measure without waiting for real copy.
- Insert filler around embedded media to check float/wrap behavior.
- Create quick before/after content for accessibility or contrast testing.
- Fill multilingual placeholder slots during translation workflow setup.
- Demonstrate CKEditor 5 plugin integration in a proof-of-concept or tutorial.
- Provide throwaway text for QA when reproducing editor bugs.
- Populate a landing page draft so stakeholders can react to structure, not wording.
- Add placeholder paragraphs to a knowledge-base article template.
- Generate filler for comment or discussion body fields that use CKEditor 5.
- Insert varying paragraph counts (via the dropdown options) to match a target content length.
