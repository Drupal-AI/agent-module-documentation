<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Block: WhatsApp block

Single core Block plugin. Class `Drupal\whatsapp\Plugin\Block\WhatsappBlock`
(`src/Plugin/Block/WhatsappBlock.php`), extends `Drupal\Core\Block\BlockBase`, implements
`ContainerFactoryPluginInterface`.

Annotation:

```
@Block(
  id = "whatsapp_block",
  admin_label = @Translation("WhatsApp block"),
)
```

No `category` is declared, so it appears under the default "custom" grouping in the block library.

## What it renders

The block has **no `blockForm()`/`blockSubmit()`** — there are no per-instance settings. `build()`
reads the site-wide config and emits exactly one script tag:

```php
$widget_key = $this->configFactory->get('whatsapp.settings')->get('widget_key');
$key = $this->keyRepository->getKey($widget_key)->getKeyValue();
return [
  '#type' => 'inline_template',
  '#template' => '<script defer src="{{ url }}"></script>',
  '#context' => [
    'url' => $this->javascriptService->fetchWhatsappJavascript($key),
  ],
];
```

- `widget_key` is a **Key entity id**; `keyRepository->getKey(...)->getKeyValue()` resolves it to the
  actual ChatWith.io widget key string.
- `url` is produced by the `whatsapp.javascript_cache` service:
  - local caching **off** → `//widget.tochat.be/bundle.js?key=<key value>` (protocol-relative; the
    vendor CDN serves the widget).
  - local caching **on** → a site-local path such as `/sites/default/files/whatsapp/bundle.js` from
    `FileUrlGeneratorInterface::generateString()`.
- Rendered through `inline_template`, so the `url` is Twig-autoescaped in the `src="..."` attribute
  context.

## Placement and behaviour

- Place it like any block (Block layout, or a Layout Builder section). It only injects the loader on
  pages/regions where it is placed; the floating chat button itself is drawn by the vendor's
  JavaScript in the browser.
- **Prerequisite:** `whatsapp.settings.widget_key` must reference an existing Key. If it is unset or
  points at a missing Key, `getKey()` returns `NULL` and `build()` fatals on `->getKeyValue()`.
  Configure the widget key first (see [../config/settings.md](../config/settings.md)).

## Cacheability

`getCacheTags()` adds `config:whatsapp.settings`, so editing the module settings invalidates the
block's render cache. There are no per-instance settings to cache.

## Constructor services

Injected via `create()`: `config.factory`, `key.repository`, and `whatsapp.javascript_cache`.
