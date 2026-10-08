# Theming FAQ Field output

Four of the five formatters render through overridable Twig templates registered in
`faqfield_theme()` (`faqfield.module`). Copy a template into your theme's `templates/` directory
to override it, then rebuild caches. The **accordion** formatter is deliberately excluded from
safe overriding — its markup must stay intact for the jQuery UI behavior.

## Theme hooks and templates

| Theme hook | Template | Variables |
|---|---|---|
| `faqfield_simple_text_formatter` | `faqfield-simple-text-formatter.html.twig` | `question`, `answer`, `answer_format`, `delta`, `question_tag` (default `h3`) |
| `faqfield_definition_list_formatter` | `faqfield-definition-list-formatter.html.twig` | `items` (each `question`, `answer`, `answer_format`) |
| `faqfield_anchor_list_formatter` | `faqfield-anchor-list-formatter.html.twig` | `items` (each `question`, `answer`, `answer_format`, `name` anchor), `list_type` (`ul`/`ol`), `question_tag` |
| `faqfield_jquery_accordion_formatter` | `faqfield-jquery-accordion-formatter.html.twig` | `items`, `id`, `question_tag` (do not restructure) |
| `faqfield_details_formatter` | `faqfield-details-formatter.html.twig` | `question`, `answer`, `answer_format`, `delta` |

## Preprocessing (already applied)

`template_preprocess_faqfield_*` functions in `faqfield.module` prepare the variables before the
template runs:

- `question` = `Markup::create(trim(strip_tags($question)))` — tags stripped, safe markup.
- `answer` = `check_markup($answer, $answer_format)` — filtered through the chosen text format.
- Anchor list additionally builds `item.name` = `faq-<question-with-spaces-as-dashes>` for the
  jump links.

So in a template override you can print `{{ question }}` / `{{ answer }}` directly; they are
already sanitized/filtered.

## Markup produced (default templates)

- Simple text: `<{{tag}} class="faqfield-question">` + `<div class="faqfield-answer">`.
- Definition list: `<dl class="faqfield-definition-list">` of `<dt class="faqfield-question">` /
  `<dd class="faqfield-answer">`.
- Anchor list: `<div class="faqfield-anchor-list">` with a `<ul>`/`<ol>` of `#anchor` links,
  followed by each question (heading with named anchor) and `<div class="faqfield-answer">`.
- Details: `<details class="faqfield-details"><summary class="faqfield-question">` +
  `<div class="faqfield-answer">`.
- Accordion: `<div id="{{id}}">` of heading + `<div class="faqfield-answer">`, bound client-side
  by `js/faqfield.accordion.js` (`Drupal.behaviors.faqfieldAccordion`) using
  `drupalSettings.faqfield[selector]` as the jQuery UI accordion options.

CSS/JS for the accordion come from the `faqfield/faqfield.accordion` library
(`faqfield.libraries.yml`), which depends on `jquery_ui_accordion/accordion`.
