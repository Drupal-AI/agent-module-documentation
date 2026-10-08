# Block plugin — `fractionslider_configurable_text`

The "ready-made" slider. A core Block plugin
(`src/Plugin/Block/FractionsliderConfigurableTextBlock.php`, `admin_label` "Fractionslider Block")
that renders an admin-entered HTML blob through the `fractionslider_block` theme hook and boots the
jQuery FractionSlider on it. Place it at **Structure → Block layout** (`/admin/structure/block`);
edit its options in the block's configuration form. Requires the "administer blocks" permission like
any block.

## How it renders

`build()` returns:

```php
return [
  '#theme'    => 'fractionslider_block',
  '#data'     => $this->configuration,           // full config incl. the HTML string
  '#attached' => ['drupalSettings' => ['fractionslider' => $settings]], // $settings = config MINUS fractionslider_string
];
```

`templates/fractionslider-block.html.twig` attaches the library and prints the HTML **raw**:

```twig
{{ attach_library('fractionslider/global-styles-and-scripts') }}
<div class="fractionslider-wrapper">
  {{ data.fractionslider_string|raw }}
</div>
```

`js/fractionslider.js` then matches `.fractionslider-wrapper .slider-wrapper .slider` and calls
`.fractionSlider()` with the options mapped from `drupalSettings.fractionslider`.

## Config keys (defaults from `defaultConfiguration()`)

| Key | Default | Form field (`blockForm`) | Meaning |
|---|---|---|---|
| `fractionslider_string` | large demo slider markup | `fractionslider_string_text` (textarea, 25 rows) | The full slider HTML — one `<div class="slide">…</div>` per slide, each with `data-*` layer attributes. |
| `fractionslider_dimensions` | `'1000, 400'` | `fractionslider_dimensions` (textfield) | Base `width, height`. |
| `fractionslider_controls` | `'true'` | select true/false | Prev/next arrows on/off. |
| `fractionslider_pager` | `'true'` | select true/false | Pager dots on/off. |
| `fractionslider_fullwidth` | `'true'` | select true/false | Transition across full window width. |
| `fractionslider_responsive` | `'true'` | select true/false | Responsive scaling. |
| `fractionslider_pausehover` | `'true'` | select false/true | Pause on hover. |
| `fractionslider_increase` | `'true'` | select true/false | Allow the slider to grow past base dimensions. |

All values are the **strings** `'true'`/`'false'` (not booleans); the JS treats anything other than
the literal string `'false'` as true (e.g. `settings.fractionslider_fullwidth !== 'false'`).

## Behaviour gotchas (accurate to source, not security issues)

- The textarea in `blockForm()` is keyed **`fractionslider_string_text`**, but the template renders
  **`data.fractionslider_string`** and `blockSubmit()` saves the whole `$values['settings']` via
  `setConfiguration()`. The edited HTML lands in `fractionslider_string_text` while
  `fractionslider_string` keeps its default — so edits to the markup may not take effect unless the
  default key is overwritten. Treat the shipped default markup as the effective content.
- The block passes `fractionslider_pausehover` in `drupalSettings`, but `js/fractionslider.js` reads
  `settings.pausehover` (a key that does not exist), so pause-on-hover is effectively always on for
  the block.
- Only `fractionslider_string` is declared in config schema
  (`block.settings.fractionslider_configurable_text`); the other keys have no schema mapping.

## Security note

The rendered `fractionslider_string` is **admin-authored** HTML output with `|raw`. Editing block
configuration requires the "administer blocks" permission — a restricted, trusted permission — so
this matches Drupal's standard admin-supplied-markup model rather than being an untrusted-input sink.
No end-user / anonymous input reaches the raw output.
