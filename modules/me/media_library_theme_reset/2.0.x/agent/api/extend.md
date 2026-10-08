# Extending & the theme-chain helper

The module exposes **no service and no plugin type**. There are two supported ways to extend
it, plus one helper function it defines.

## 1. Override templates
Copy any of its `templates/*.html.twig` into your theme's `templates/` and edit. See
[../theming/templates.md](../theming/templates.md).

## 2. Add a theme-specific fixes CSS (the Olivero pattern)

Olivero support is the built-in example of theme-specific fixes. If your front-end theme
still has display issues after the base fixes, add your own:

1. Create `css/{theme}-fixes.css` in the module (or a fork/patch) with your overrides.
2. Register a library for it in `media_library_theme_reset.libraries.yml`.
3. Attach it conditionally in
   `media_library_theme_reset_form_media_library_add_form_alter()`, guarded by the active
   theme chain — exactly how Olivero is handled:

```php
$theme_chain = media_library_theme_reset_get_active_theme_chain();
if (in_array('olivero', $theme_chain, TRUE)) {
  $form['#attached']['library'][] = 'media_library_theme_reset/olivero_fixes';
}
```

Ideally, fix display problems in the theme itself; a fixes CSS file is the fallback.

## Helper: `media_library_theme_reset_get_active_theme_chain()`

Returns an array of the active theme name followed by its base-theme names (the theme's
inheritance chain). The module uses it to decide whether to load the Olivero fixes. You can
call it from your own `.module`/`.theme` code:

```php
$chain = media_library_theme_reset_get_active_theme_chain();
// e.g. ['olivero'] or ['my_subtheme', 'olivero'] — check in_array('olivero', $chain, TRUE).
```

Because loading of the theme-specific fixes depends on the **active theme chain**, whether
`olivero_fixes` is attached is a function of the site's live theme configuration — see the
`introspection` eval cases.
