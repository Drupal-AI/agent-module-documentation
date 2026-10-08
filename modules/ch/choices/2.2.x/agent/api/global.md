# Global mode internals & drupalSettings

Global mode enhances `<select>` elements matched by CSS selectors without any field configuration.

## How it attaches

- `choices_element_info_alter()` — only when `choices.settings.enable_globally` is TRUE — appends
  `\Drupal\choices\ChoicesCallbacks::preRender` to the `select` element's `#pre_render`.
- `ChoicesCallbacks::preRender()` (implements `TrustedCallbackInterface`) runs `isGloballyApplicable()`
  which checks the `include` setting against `router.admin_context`:
  - `include = 2` (CHOICES_INCLUDE_EVERYWHERE) → always applies.
  - `include = 0` (…_ADMIN) → only on admin routes.
  - `include = 1` (…_NO_ADMIN) → only on non-admin routes.
- When applicable it attaches the `choices/global` library and emits `drupalSettings`.

## drupalSettings shape (global)

```js
drupalSettings.choices.global = {
  configurationOptions: { /* parsed choices.settings.configuration_options, {} if empty */ },
  cssSelector: "select[multiple],select#edit-type"  // css_selector, whitespace collapsed to commas
};
```

`js/choices_global.js` reads these and calls `new Choices(el, options)` for each element matching
`cssSelector`.

## drupalSettings shape (widget)

```js
drupalSettings.choices.widget.fields["<field_machine_name>"].configurationOptions = { /* merged */ };
```

## Reusing from custom code

There is no PHP service API. To Choices-enhance a select in a custom form, either:
- add its selector to the global `css_selector` list (global mode must be enabled), or
- attach `choices/global` (or `choices/widget`) yourself and populate the matching `drupalSettings`
  structure above.

The base library key is `choices/library` (local assets or CDN depending on `use_cdn`); `choices/global`
and `choices/widget` both depend on it.
