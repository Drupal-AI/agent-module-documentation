# Partial Page Print Element — manual setup guide

**Partial Page Print Element** (`partial_page_print`) lets visitors print just one
part of a page instead of the whole thing. It provides a **print button render
element** that, when clicked, prints only a designated region of the current page —
an article body, a summary, a single section — using the same theme but without the
site's regions, blocks, headers, footers, or other page furniture you would not
want on paper. The result is a clean printout of exactly the content that matters.

This is a developer/site‑builder tool rather than a point‑and‑click feature: you
add the print button to a page by placing a small render element in a render array,
either from a custom module or (more commonly) from a preprocess hook in your
theme. You tell the element the **HTML ID** of the thing you want printed, and the
button handles the rest. There is no admin settings form — everything is done in
code or Twig.

It requires **PHP 8.1** and needs no modules beyond Drupal core.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable it.

There is **no configuration page** — you add the print button in your theme or a
custom module, as shown under "How to use it" below.

## How to use it

The module gives you a render element of type `partial_page_print_button`. Set its
`#element_id` to the HTML ID of the element you want printed, and its `#value` to
the button label. For example, add it directly to a render array in custom code:

```php
$build['print_link'] = [
  '#value' => $this->t('Print the Content'),
  '#type' => 'partial_page_print_button',
  '#element_id' => 'my_div_id',
];
```

More often you will add it from your theme. In your theme's `.theme` file, attach a
button to node output via a preprocess hook:

```php
function MYTHEME_preprocess_node(&$variables) {
  $variables['nodeSummaryPrintButton'] = [
    '#value' => t('Print Summary'),
    '#type' => 'partial_page_print_button',
    '#element_id' => 'node-summary',
  ];
}
```

Then print the button where you want it in the node template, next to the element
whose ID you referenced:

```twig
{# ... #}
{{ nodeSummaryPrintButton }}

<div id="node-summary">
  {# Node summary here #}
</div>
{# ... #}
```

The key detail: `#element_id` must match the HTML `id` of the container you want
printed. Clicking the button prints only that container's content, themed but
stripped of the surrounding page.
