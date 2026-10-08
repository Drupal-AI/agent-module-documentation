# How the background CSS is built and attached

The formatter does not render an `<img>` and has no Twig template. In
`BgImageFormatter::viewElements()` it builds a raw CSS rule and attaches it to the page head.

## Rule construction — `getBackgroundImageCss()`

`getBackgroundImageCss($image_path, array $css_settings, $image_style = NULL)` returns an array
`['type' => 'inline', 'style' => <css>, 'media' => <media query>, 'group' => CSS_THEME]`.
The generated rule looks like:

```css
selector {
  background-color: #FFFFFF !important;
  background-image: linear-gradient(...), url('https://.../image.jpg') !important;
  background-repeat: no-repeat !important;
  background-attachment: scroll !important;
  background-position: left top !important;
  z-index: auto;
  background-size: cover !important;   /* + -webkit/-moz/-o prefixes */
}
```

- `!important` is appended when `bg_image_important` is truthy.
- Selector, color, x/y, size, gradient, media query and z-index are passed through
  `Xss::filter()`.
- When `bg_image_background_size` is `cover` and `bg_image_background_size_ie8` is set, IE
  `DXImageTransform.Microsoft.AlphaImageLoader` `filter`/`-ms-filter` lines are added.
- Returns `[]` (no output) unless both a selector and an image path are present.

## Attaching to the page

For each image value the built `style` becomes an `html_tag`/`style` render element with the
`media` attribute, then:

- Normal requests: attached via `#attached['html_head'][]` with a unique key
  `bg_image_formatter_css__s<sha1(uuid, field name, image style, delta)>` to avoid collisions.
- AJAX/XHR requests: rendered and attached under
  `#attached['drupalSettings']['bg_image_formatter_css'][key]`; `hook_ajax_render_alter()` in
  `bg_image_formatter.module` then converts each into an `AddCssCommand` so the style loads in
  the AJAX response.

## Image URL & tokens

- With an image style set, the URL is `$style->buildUrl($file->getFileUri())`; otherwise the
  absolute file URL is generated. `bg_image_path_format = relative` runs it through
  `transformRelative()`.
- Selectors are token-replaced with `\Drupal::token()->replace()` (entity + user data) and
  also support Views `{{ field }}` tokens.
- `viewElements()` emits an empty `$elements[0]` so the Views renderer has something to render
  even though the visible output is CSS-only.
