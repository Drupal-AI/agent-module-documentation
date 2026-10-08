# Setup — CKEditor 5 Bootstrap Accordion

No settings form (`configure` is null). Configuration is entirely per text format at
`admin/config/content/formats`.

## Steps

1. Enable the module (`drush en ckeditor5_bootstrap_accordion -y`). Requires core `ckeditor5`.
2. Edit a text format/editor that uses **CKEditor 5**.
3. Drag the **Accordion** button from *Available buttons* into the *Active toolbar*.
4. Under **Enabled filters**, check **Accordion enabler**
   (`filter_bootstrap_accordion`). Without it, stored accordion markup will not get the
   Bootstrap runtime attributes and will not expand/collapse on the page.
5. Ensure the front-end **theme loads Bootstrap 5 CSS + JS**. The module adds no front-end
   assets; the editor UI works without Bootstrap, but the rendered accordion needs it.

## Allowed markup (from `*.ckeditor5.yml` `drupal.elements`)

```
<div>
<div data-accordion-id class="accordion accordion-item accordion-header accordion-body
  accordion-flush accordion-items-stay-open accordion-collapse collapse show">
<a>
<a href="#" class="accordion-button collapsed">
```

The editor plugin depends on CKEditor 5 General HTML Support (GHS) + a clipboard pipeline
(both listed under `ckeditor5.plugins`). Stored markup holds only these structural classes
plus a `data-accordion-id`.

## Render-time filter (`src/Plugin/Filter/BootstrapAccordion.php`)

`TYPE_TRANSFORM_IRREVERSIBLE`, weight 10. On render it parses the HTML (`Html::load` +
DOMXPath) and, for every `div[data-accordion-id]` with the `accordion` class:

- sets the accordion `id` to `accordion-<data-accordion-id>`;
- for each `.accordion-item` → `.accordion-header` button, adds `role="button"`,
  `data-bs-toggle="collapse"`, `data-bs-target="#accordion-<id>-<n>"`, `aria-expanded`
  (from the `collapsed` class), `aria-controls`, and rewrites `href` to the pane id;
- for each `.accordion-collapse` pane, sets its `id` and (unless the accordion has
  `accordion-items-stay-open`) `data-bs-parent="#accordion-<id>"`.

All attribute writes go through the DOM API (`setAttribute`), which encodes values, and the
filter only adds fixed Bootstrap attributes — it does not emit unescaped user markup.

## Extending the toolbar (developers)

Add items by altering the CKEditor 5 config key `bootstrapAccordion.toolbarItems`
(default `bootstrapAccordionItem`, `bootstrapAccordionOpenCollapse`) from your own CKEditor 5
plugin. Accordion-in-accordion nesting is supported.
