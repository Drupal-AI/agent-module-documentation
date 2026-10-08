# Theme hook & template override

## Theme hook

Registered in `src/Hook/DarkModeToggleHooks.php` (`#[Hook('theme')]`):

```php
'dark_mode_toggle' => ['variables' => ['attributes' => []]]
```

The block's `build()` returns `['content' => ['#theme' => 'dark_mode_toggle']]`, so the
rendered output is entirely the template below.

## Default template

`templates/dark-mode-toggle.html.twig`:

```twig
{{ attach_library('dark_mode_toggle/dark-mode-toggle') }}
<div{{ attributes.setAttribute('data-dmt-container', '') }}>
  <ul>
    <li><button data-dmt-preference="light">{% trans %}Light{% endtrans %}</button></li>
    <li><button data-dmt-preference="dark">{% trans %}Dark{% endtrans %}</button></li>
    <li><button data-dmt-preference="system">{% trans %}System{% endtrans %}</button></li>
  </ul>
</div>
```

Contract the JS depends on (keep these when overriding):

- The clickable wrapper must have **`data-dmt-container`** — the JS delegates clicks from it.
- Each control must carry **`data-dmt-preference="light|dark|system"`** — the value drives the
  mode. Any element type works (the handler uses `event.target.closest('[data-dmt-preference]')`).
- Keep `attach_library('dark_mode_toggle/dark-mode-toggle')` so the behaviour and the header
  init script load.

## Overriding

Copy the template into your theme (e.g. `themes/custom/mytheme/templates/dark-mode-toggle.html.twig`)
and clear caches. Typical overrides: swap the words for icons, render a single toggle button,
or restructure the markup — as long as the two data-attributes above are preserved. `attributes`
is the only variable passed to the template.
