# Theming CKEditor Accordion

## Saved markup

Inserting an accordion writes a description list to the field (the CKEditor 5 model
`<accordion>` → `<accordionRow>` → `<accordionTitle>`/`<accordionContent>` downcasts to):

```html
<dl class="ckeditor-accordion">
  <dt>First title</dt>
  <dd>First content…</dd>
  <dt>Second title</dt>
  <dd>Second content…</dd>
</dl>
```

`<dl class="ckeditor-accordion">` is the hook the frontend behavior looks for; `<dt>` are
titles and `<dd>` are the collapsible content panes.

## Frontend behavior & runtime classes

`ckeditor_accordion_page_attachments_alter()` attaches the `ckeditor_accordion/accordion.frontend`
library **globally** on every page (deps: `core/drupal`, `core/drupalSettings`, `core/once`).
On attach (`js/accordion.frontend.js`) each `.ckeditor-accordion`:

- is wrapped in a `<div class="ckeditor-accordion-container">` (gets `no-animations` when
  animation is disabled);
- swaps its class from `ckeditor-accordion` to `styled`;
- opens the first `<dt>`/`<dd>` unless `collapse_all` is set (adds class `active`);
- rewrites each `<dt>` into
  `<a class="ckeditor-accordion-toggler"><span class="ckeditor-accordion-toggle"></span>…</a>`;
- toggles the `active` class on title + content on click (respecting `keep_rows_open`).

A **`ckeditorAccordionAttached`** DOM `Event` is dispatched on each accordion element once
initialized — listen for it to run custom JS after render.

## Styling / overrides

- Frontend CSS: `css/accordion.frontend.css` (minimal blue theme — intentionally easy to
  override). Editor CSS: `css/accordion.admin.css`.
- Override by targeting `.ckeditor-accordion-container`, `dl.styled`, `dt.active`,
  `.ckeditor-accordion-toggler`, and `.ckeditor-accordion-toggle` in your theme.
- The `open_tabs_with_hash` setting makes togglers into `#TitleSlug` anchor links, and
  `hashchange` / in-page `#` link clicks open the matching row.

There are no Twig templates or theme hooks — output is a plain `<dl>` transformed entirely
in JavaScript, so theming is CSS-only.
