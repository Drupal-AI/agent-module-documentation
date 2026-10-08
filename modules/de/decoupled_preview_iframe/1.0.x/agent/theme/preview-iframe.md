# Theme hook, template, library and JS

## Theme hook `preview_iframe`

Registered in `decoupled_preview_iframe_theme()`:

```php
'preview_iframe' => [
  'variables' => [
    'url' => NULL,               // full iframe src (preview_url + path + optional ?token=)
    'showPublishedToggle' => FALSE, // TRUE when a draft/latest-revision URL is being shown
  ],
],
```

Rendered by `templates/preview-iframe.html.twig`. Override it by copying that template into your
theme and using its variables. The template renders:

- an `.iframe_information` bar with a "Preview URL" link (`#preview_url_anchor`, showing
  `url|split('?')[0]`, i.e. the URL without the token) that opens the preview in a new tab;
- a "Show Published" checkbox (`#show_published_toggle`) shown only when `showPublishedToggle` is
  TRUE (i.e. a draft/forward revision is being previewed);
- the `<iframe id="node_preview" class="decoupled_preview_iframe" src="{{ url }}">` inside
  `.decoupled_preview_iframe-container`. The iframe carries a `sandbox` attribute
  (`allow-scripts allow-forms allow-same-origin allow-pointer-lock allow-presentation allow-top-navigation`).

Twig autoescapes `url` in both the `href` and `src` attributes.

## Library `decoupled_preview_iframe/site`

`decoupled_preview_iframe.libraries.yml` defines `site`:

- CSS `css/decoupled_preview_iframe.site.css` — sizes the container (`height: 75vh`), and shows a
  spinner background until the iframe gets the `ready` class.
- JS `js/decoupled_preview_iframe.site.js`.
- Dependencies: `core/drupal`, `core/drupalSettings`.

It is attached automatically by `hook_entity_view_alter()`; you do not attach it yourself.

## JS behaviors (`js/decoupled_preview_iframe.site.js`)

Reads `drupalSettings.decoupled_preview_iframe` (`selector`, `routeSyncType`, `publishedUrl`,
`draftUrl`). Two behaviors:

- `decoupledPreviewIframeLoad` — binds `#show_published_toggle`: checking it swaps the iframe `src`
  and the anchor between `publishedUrl` and `draftUrl` (`jQuery.fn.toggleShowPublished`). Also adds
  the `ready` class to the iframe on `load` (removes the loading spinner).
- `decoupledPreviewIframeLoadSyncRoute` — listens for `window` `message` events; when a message
  arrives with `data.type === routeSyncType` and a `data.path`, and that path differs from the
  current Drupal path, it navigates Drupal to `data.path`. This keeps the Drupal admin URL in sync
  when the user clicks around inside the framed front end. The front end must `postMessage` an object
  `{ type: '<route_sync>', path: '<drupal-path>' }` to the parent window for this to work; the
  `route_sync` config value is that agreed `type` string (default `DECOUPLED_PREVIEW_IFRAME_ROUTE_SYNC`,
  or `NEXT_DRUPAL_ROUTE_SYNC` for the Next.js module).
