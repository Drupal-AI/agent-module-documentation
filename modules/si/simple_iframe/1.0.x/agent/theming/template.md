# Theming the iframe

## Theme hook
`simple_iframe_theme()` (in `simple_iframe.module`) registers:
```php
'simple_iframe' => [
  'variables' => ['url' => NULL, 'width' => NULL, 'height' => NULL],
]
```

## Default template
`templates/simple-iframe.html.twig`:
```twig
<div class="simple-iframe">
  <iframe src="{{- url -}}" width="{{- width -}}" height="{{- height -}}">{{ 'Your browser does not support iframes'|t }}</iframe>
</div>
```

## Overriding
Copy `simple-iframe.html.twig` into your theme's `templates/` directory and adjust the markup —
e.g. add a `title`, `loading="lazy"`, `allow`/`referrerpolicy`, or a **`sandbox`** attribute, or
wrap for a responsive aspect-ratio container. The three variables `url`, `width`, `height` come
straight from the field item.
