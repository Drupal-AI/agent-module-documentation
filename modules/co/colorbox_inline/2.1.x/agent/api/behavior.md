# colorbox_inline — runtime behavior & attachment

This module has no PHP API you call and no config. It works by attaching a JS library on
every page and running one Drupal behavior. This doc explains the moving parts so you can
predict/debug its behavior or reuse the pattern.

## Server side

`hook_page_attachments()` (in `src/Hook/ColorboxInlineHooks.php`, class
`ColorboxInlineHooks`, invoked via the `#[Hook('page_attachments')]` attribute) does two
things on **every** page:

1. Calls the parent Colorbox service `colorbox.attachment` (`Drupal\colorbox\ColorboxAttachment`,
   aliased in `colorbox_inline.services.yml`) to attach the Colorbox library + `drupalSettings.colorbox`.
2. Appends this module's own library: `$page['#attached']['library'][] = 'colorbox_inline/colorbox_inline';`.

The module also implements `hook_help()` for its `help.page.colorbox_inline` route. There is
no `.routing.yml`, `.permissions.yml`, config schema, or Drush service.

The `colorbox_inline.module` file still defines legacy procedural wrappers
(`colorbox_inline_page_attachments`, `colorbox_inline_help`) marked `#[LegacyHook]`; the real
implementations are the OOP hooks above (Drupal 11 hook-attribute style).

## Library

`colorbox_inline.libraries.yml`:

```yaml
colorbox_inline:
  js:
    js/colorbox_inline.js: {}
  dependencies:
    - colorbox/colorbox
    - core/once
```

## Client side (`js/colorbox_inline.js`)

`Drupal.behaviors.colorboxInline.attach()`:

- Selects `[data-colorbox-inline]` elements, wrapped in `once('colorbox-inline-processed', …)`.
- Reads the element's `.data()`; skips it if `data-colorbox-inline` is not a string or contains `<`.
- Builds Colorbox settings by extending `drupalSettings.colorbox` with `{ href: false, inline: true }`,
  then overlaying `className` (`data-class`), `href` (the selector), `width`, `height`, `rel`,
  and `open: false`.
- If the target element is not currently `:visible`, registers `onCleanup` to re-hide it.
- Calls `$link.colorbox(settings)` and, on click, shows the target element and reopens Colorbox.

Because it depends on `colorbox/colorbox`, the external jQuery Colorbox JS library must be
installed for the parent module (see the colorbox module docs / `drush colorbox:plugin`).
