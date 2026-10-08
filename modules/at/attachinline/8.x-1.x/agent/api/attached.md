# Inline JS/CSS attach API (`#attached['js']` / `#attached['css']`)

Attach Inline adds two render-array attachment keys that core does not support: `js` and `css`. Put
them alongside the normal `library` / `drupalSettings` on any render array's `#attached`.

```php
$render['element'] = [
  '#markup' => '<div id="widget"></div>',
  '#attached' => [
    // Normal core functionality still works:
    'library' => ['core/drupalSettings'],
    'drupalSettings' => ['mymodule' => $data],

    // Added by attachinline:
    'js' => [
      [
        'data'         => 'alert("Hi!");',      // required
        'scope'        => 'header',              // 'header' | 'footer' (default 'footer')
        'group'        => JS_DEFAULT,            // default JS_DEFAULT
        'weight'       => -30,                   // default 0
        'attributes'   => ['defer' => TRUE],     // merged onto the <script> tag
        'dependencies' => ['core/jquery'],       // real library names, loaded first
      ],
    ],
    'css' => [
      [
        'data'       => '.highlight { background: yellow; }',  // required
        'group'      => CSS_THEME,                             // default CSS_COMPONENT
        'weight'     => 0,
        'attributes' => ['media' => 'all'],                    // merged onto the <style> tag
      ],
    ],
  ],
];
```

A snippet may also be given as a **plain string** instead of an array; it is normalised to
`['data' => $string]` (`AssetResolverDecorator::getCssAssets`/`getJsAssets`).

## Option keys and defaults

Defaults are applied in `src/Asset/AssetResolverDecorator.php`:

- **JS** (`getJsAssets`): `type => inline`, `scope => footer`, `group => JS_DEFAULT`, `weight => 0`.
- **CSS** (`getCssAssets`): `type => inline`, `group => CSS_COMPONENT`, `weight => 0` (CSS has no
  `scope`).
- `weight` gets a tiny `count/1000` increment per snippet so insertion order is preserved on ties;
  snippets are then `uasort`-ed with the decorated resolver's `::sort` (falls back to
  `AssetResolver::sort`), i.e. sorted by `group` then `weight` exactly like file assets.
- `attributes` is merged onto the emitted `<script>`/`<style>` tag (`#attributes`).
- `dependencies` — see below.

## Dependencies and the header-proxy mechanism

When a snippet lists `dependencies`, those **real library names** are merged into the response's
library list in `AttachedAssets::createFromRenderArray()` (`src/Asset/AttachedAssets.php`), so the
libraries load normally on the page.

For a **header-scoped JS** snippet only, `AssetResolverDecorator::getJsAssets()` additionally adds a
**virtual proxy library** `attachinline/<library>` for each dependency. `LibraryDiscoveryDecorator`
(`src/Asset/LibraryDiscoveryDecorator.php`) intercepts `getLibraryByName('attachinline', $name)` and
synthesises `['header' => TRUE, 'dependencies' => [$name], 'js' => []]`, which forces that dependency
into the header so it is present before the header snippet runs. There is **no `attachinline.libraries.yml`
file** — this namespace is entirely synthetic.

## Rendering (output tags)

`JsCollectionRendererDecorator` / `CssCollectionRendererDecorator` (`src/Asset/*CollectionRendererDecorator.php`)
build each inline asset as an `html_tag` render element (`<script>` / `<style>`) whose `#value` is
`AttachInlineMarkup::create($data)`, then **append the inline tags after** the normal file-based
assets in that collection (`array_merge($this->decorated->render(...), $elements)`). So inline
snippets always come last within their header/footer collection.

`Drupal\attachinline\Render\AttachInlineMarkup` (`src/Render/AttachInlineMarkup.php`) is a
`MarkupInterface` passthrough (uses `MarkupTrait`) that emits its string **unescaped**, like core's
`Markup::create()`. Its docblock is explicit: it must only ever be constructed with **known-safe
strings** — any dynamic value placed into `data` must be sanitised by the calling code before it is
attached (this is the same contract as `#markup` / `Markup::create`; the module performs no escaping
of snippet `data`).

## Calling from PHP / the classes

- `Drupal\attachinline\Asset\AttachedAssets` (extends core `AttachedAssets`, implements local
  `AttachedAssetsInterface`) — adds `getJs()/setJs(array)`, `getCss()/setCss(array)`, and overrides
  `createFromRenderArray()` to pull `#attached['js']` / `#attached['css']` and merge their
  `dependencies` into the library list. You normally never construct this yourself; you just populate
  `#attached` and let the replaced attachments processor build it.
- `Drupal\attachinline\Render\HtmlResponseAttachmentsProcessor` (replaces the core
  `html_response.attachments_processor` service) drives the whole flow in `processAttachments()`.

## Important behavioural caveat — the `#attached` allowlist

`HtmlResponseAttachmentsProcessor::processAttachments()` enforces an allowlist of `#attached` keys:
`html_head`, `feed`, `html_head_link`, `http_header`, `library`, `html_response_attachment_placeholders`,
`placeholders`, `drupalSettings`, `css`, `js`. Any **other** `#attached` key throws
`\LogicException("You are not allowed to use <type> in #attached.")`. This is core's own behaviour
plus `css`/`js`; it means a module that bubbles a non-standard custom `#attached` type will fatally
error while attachinline owns this service. (With BigPipe enabled, its processor wraps this one as its
inner processor, so the same rule applies — runtime-verified on this site.)
