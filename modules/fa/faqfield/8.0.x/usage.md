FAQ Field adds a `faqfield` field type that stores a list of question/answer/format triples, so you can attach frequently-asked-question lists to any fielded entity and render them as an accordion, definition list, anchor list, details block, or plain text.

---

FAQ Field defines a single multi-value field type (`faqfield`) whose each item holds a **question** (varchar 255), an **answer** (medium text), and an **answer text format**. When a field storage of this type is created the module forces its cardinality to unlimited, so a field is effectively an ordered, draggable list of Q&A pairs. Editing is done with one widget (`faqfield_default`): a question textfield (optionally a textarea) plus an answer input whose type is selectable — plain Textarea, Formattable textarea (`text_format`, for WYSIWYG/filtered HTML), or a single-line Textfield — with configurable titles, required flags, max length, size and row counts. The answer format defaults to the field-level **Default text format** setting but each item can override it. Display is handled by five formatters: **jQuery Accordion** (default, animated show/hide driven by jQuery UI and configurable active panel, height style, collapsibility, trigger event and animation), **HTML definition list** (`<dl>`), **HTML anchor list** (a jump-link list plus anchored answers), **HTML details** (native `<details>`/`<summary>`), and **Simple text** (bare markup for custom theming). Question output is always stripped of tags; answers are passed through `check_markup()` with the chosen format. Every formatter is themeable via its own Twig template except the accordion, whose markup must stay intact for the jQuery behavior. The module has no admin settings page, no permissions, and no routes — all configuration lives on the entity's Manage fields / Manage form display / Manage display screens.

---

- Add a "Frequently Asked Questions" field to a content type (page, product, service) to hold Q&A pairs.
- Attach an FAQ list to a taxonomy term, user, or any other fielded entity.
- Store each answer with its own text format so some answers can use full HTML and others plain text.
- Enter an unlimited, drag-to-reorder list of questions and answers on the edit form.
- Render the FAQ as an animated jQuery UI accordion (the default display).
- Open a specific accordion panel by default, or start with all panels closed (fully collapsible).
- Tune accordion height style (auto / fill / content), trigger event, and animation easing/duration.
- Display the FAQ as a semantic `<dl>` definition list for accessible, script-free markup.
- Display the FAQ as native HTML `<details>`/`<summary>` disclosure widgets (no JavaScript).
- Display an anchor-link list at the top that jumps to each answer further down the page.
- Output bare Simple text markup and style it entirely in your own theme.
- Choose the HTML heading tag (h2–h6) that wraps each question in most formatters.
- Pick a bullet (`<ul>`) or numbered (`<ol>`) list style for the anchor-list formatter.
- Use a Formattable textarea answer widget to give editors a WYSIWYG/CKEditor answer box.
- Switch the answer widget to a plain Textarea or a single-line Textfield when rich text isn't wanted.
- Rename the "Question" and "Answer" input labels to fit a specific content model.
- Make the question and/or answer inputs required per field instance.
- Limit question length and control the width/rows of the question and answer inputs.
- Set a field-wide default text format for answers and let individual answers override it.
- Override any non-accordion formatter's markup by providing a custom Twig template in your theme.
- Build a product support / help section as structured, reorderable content instead of a WYSIWYG blob.
- Reuse one FAQ field across many bundles with per-display formatter choices (accordion on the node, list in a view).
