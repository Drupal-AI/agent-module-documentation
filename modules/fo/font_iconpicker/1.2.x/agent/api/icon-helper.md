# Integration API: icon-list service, dynamic library, theme hook

## Service `font_iconpicker.icon_helper`
Class `Drupal\font_iconpicker\IconHelper` implements
`Drupal\font_iconpicker\IconHelperInterface`. Constructor args: `@config.factory`,
`@library.discovery.parser`.

```php
$icons = \Drupal::service('font_iconpicker.icon_helper')->getIconsAvailable();
// string[] — icon CSS classes parsed from the configured font stylesheet.
```

- `getIconsAvailable(): array` — statically cached per request. It resolves the CSS file(s)
  attached to the dynamic `font-custom` library, then `parseCssFile()` runs a regex
  (`#\.(<class_prefix>[\w_-]+)#`, where `<class_prefix>` is the configured `class_prefix`)
  over each file's contents via `file_get_contents()`, returning the unique matched class
  names.
- Throws `\LogicException` when the font library or its CSS is not configured/discovered
  (the render element and other callers catch this).
- Interface constant `IconHelperInterface::FONT_LIBRARY_NAME = 'font-custom'` — the machine
  name of the dynamically declared font library.

## Dynamic libraries — `hook_library_info_alter`
`FontIconpickerHooks::libraryInfoAlter()` (legacy wrapper
`font_iconpicker_library_info_alter()`), for extension `font_iconpicker`:
- Adds a `theme` CSS entry to the `fonticonpicker` library resolved from the configured
  `theme`:
  `/libraries/fonticonpicker/css/themes/{theme}-theme/jquery.fonticonpicker.{theme-no-dash}.min.css`.
- When `css_font_path` is set, declares a new library `font_iconpicker/font-custom` whose
  `component` CSS is the configured font stylesheet (`/` + trimmed `css_font_path`), and
  appends it as a dependency of `font_iconpicker/form-element`.

Because these libraries are computed at library-discovery time, changing settings requires a
cache flush (the settings form does this automatically).

### Declared libraries (`font_iconpicker.libraries.yml`)
- `form-element` — `js/form-element.js`; deps `core/drupal`, `core/drupalSettings`,
  `core/once`, `font_iconpicker/fonticonpicker`.
- `fonticonpicker` — the jQuery fontIconPicker library at `/libraries/fonticonpicker`
  (v3.1.1); dep `core/jquery`.

## Theme hook
`FontIconpickerHooks::theme()` defines `font_icon` (variable `icon`; template
`templates/font-icon.html.twig`). Render an icon anywhere with
`['#theme' => 'font_icon', '#icon' => 'icon-star']`. See
[../fields/field.md](../fields/field.md) for the preprocess details.

## hook_help
`FontIconpickerHooks::help()` returns a short "About" blurb on route
`help.page.font_iconpicker`.

## Hook wiring
Hooks are implemented as OOP `#[Hook(...)]` methods on
`Drupal\font_iconpicker\Hook\FontIconpickerHooks` (registered as an autowired service in
`font_iconpicker.services.yml`); the procedural functions in `font_iconpicker.module` are
thin `#[LegacyHook]` delegates. `template_preprocess_font_icon()` remains a plain function
in the `.module` file.
