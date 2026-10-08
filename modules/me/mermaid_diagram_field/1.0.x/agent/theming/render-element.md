# Render a Mermaid diagram from code (`mermaid_diagram` theme hook)

The module registers a `mermaid_diagram` theme hook (template
`templates/mermaid_diagram.html.twig`). Use it to render a diagram from a custom render array without a
field. Attach the front-end library so it actually renders to SVG.

```php
$build['chart'] = [
  '#theme' => 'mermaid_diagram',
  '#title'   => t('Order flow'),        // rendered as <h2>
  '#mermaid' => "flowchart LR\n A-->B",  // required: the Mermaid source
  '#caption' => t('How an order moves through fulfilment.'), // <figcaption>
  '#key'     => '',                      // optional second Mermaid diagram (legend)
  '#show_code'     => FALSE,             // TRUE → collapsible source pane
  '#allow_download'=> FALSE,             // TRUE → "Download diagram" button
  '#preface' => '',                      // optional markup before the figure
  '#postface'=> '',                      // optional markup after the figure
  // For template suggestions (all optional):
  '#field_name' => 'field_diagram', '#entity_type' => 'node', '#bundle' => 'article',
  '#attached' => ['library' => ['mermaid_diagram_field/diagram']],
];
```

## Theme variables

`preface`, `title` (default `t('Diagram')`), `mermaid`, `caption`, `key`, `show_code`, `allow_download`,
`postface`, `field_name`, `entity_type`, `bundle`. All are printed with Twig autoescaping on; the
`.mermaid` div's escaped text is decoded to `textContent` client-side and passed to `mermaid.render()`.

## Template structure (`mermaid_diagram.html.twig`)

- `<figure class="mermaid-diagram">` with `<h2>{{ title }}</h2>`, `<div class="mermaid">{{ mermaid }}</div>`,
  `<figcaption>{{ caption }}</figcaption>`.
- If `key`: an `<h3>Key</h3>` + second `<div class="mermaid key">{{ key }}</div>`.
- If `show_code`: a `<details>` pane with the raw diagram and key code in `<pre><code>`.
- If `allow_download`: a `<button class="mermaid-download-button" data-mermaid="{{ mermaid|e('html_attr') }}">`
  handled by `Drupal.behaviors.mermaidDiagramDownload`, which builds a `.mermaid` Blob for download.

## Template suggestions

`hook_theme_suggestions_mermaid_diagram()` (in `.module`) sanitises `field_name`/`entity_type`/`bundle`
(lowercase, non-alphanumerics → `_`) and offers, most specific first:

```
mermaid_diagram__<entity_type>__<bundle>__<field_name>
mermaid_diagram__<entity_type>__<field_name>
mermaid_diagram__<field_name>
```

Provide these template files in your theme to customise a specific field/bundle's diagram markup.

## Front-end behaviour (`js/diagram.js`)

`Drupal.behaviors.diagramDisplay` runs `mermaid.initialize(drupalSettings.mermaidDiagramField.extraSettings)`
once, then for each `.mermaid` element renders the SVG and, if svg-pan-zoom is present, wraps it with
zoom/pan controls (min 1, max 24). Render errors are shown inline as `<pre class="mermaid-error">`.
