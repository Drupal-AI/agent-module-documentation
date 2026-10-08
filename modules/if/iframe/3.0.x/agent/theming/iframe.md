# Theming the iframe output

## Theme hook

`hook_theme()` (in `src/Hook/IframeHooks.php`) registers one hook:

```
'iframe' => [
  'variables' => [
    'src' => 'src',
    'attributes' => [],   // HTML attributes for the <iframe> tag (incl. class)
    'text' => '',         // title text
    'style' => '',        // inline CSS block (width/height etc.)
    'headerlevel' => '',  // 1–4
  ],
  'template' => 'iframe',
]
```

Template: `templates/iframe.html.twig`. Override it by copying into your theme
(`iframe.html.twig`) or add a suggestion.

## Template markup

```twig
<div{% if attributes.class is not empty %} class="{{ attributes.class }}"{% endif %}>
  {% if text is not empty %}
    <h{{ headerlevel ?? 3 }} class="iframe_title">{{ text }}</h{{ headerlevel ?? 3 }}>
  {% endif %}
  <style type="text/css">{{ style|raw }}</style>
  <iframe {{ attributes }}>
    {{ 'Your browser does not support iframes, but you can visit <a href=":url">@text</a>'|t(...) }}
  </iframe>
</div>
```

- The title renders as an `h1`–`h4` (from `headerlevel`, default `h3`) with class `iframe_title`
  — set the header level per field for accessible heading order.
- `style` is printed raw as an inline `<style>` block (width/height/responsive rules).
- `attributes` carries `src`, `width`/`height`, `frameborder`, `scrolling`, `allowfullscreen`,
  `class`, etc., assembled by the formatter.
- The `<iframe>` body is fallback text (with a link) for browsers without iframe support.

## Assets

Library `iframe/iframe` (`iframe.libraries.yml`) attaches `css/iframe.css` and `js/iframe.js`
(depends on `core/jquery`) — the JS backs the `autoresize` (same-origin height fit) and
`iframe-responsive` (ratio) class behaviors.
