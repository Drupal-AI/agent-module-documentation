# How it works & how to author extensions

Two classes only: `ExtensionAdapter` (the `twig.extension` service) and `ExtensionLoader` (a static
singleton that discovers and includes the files).

## Where it scans

`ExtensionLoader::loadAll()` does:

```php
$theme = \Drupal::config('system.theme')->get('default');
$themeLocation = \Drupal::service('extension.list.theme')->getPath($theme);
$extensionPaths = glob(DRUPAL_ROOT . '/' . $themeLocation . '/*/_twig-components/');
```

So it looks **one directory level below the default theme** for a `_twig-components/` folder, then
scans its `functions/`, `filters/`, and `tags/` subfolders. Example valid path:
`web/themes/custom/mytheme/source/_twig-components/functions/foo.function.php`
(the `*` matches `source`, `pattern-lab`, etc.). Only the **default** theme is scanned — there is no
setting to change this (README calls it a TODO).

## Load rules (per file)

For each `*.php` file in a type folder, the base name is skipped if it starts with `.`, `_`, or
`pl_`. Otherwise the file is `include`d and, by type:

| Folder | File must define | Registered as |
|---|---|---|
| `functions/` | `$function` = `\Twig\TwigFunction` | a Twig function |
| `filters/` | `$filter` = `\Twig\TwigFilter` | a Twig filter |
| `tags/` (`NAME.tag.php`) | class `Project_NAME_TokenParser extends \Twig\TokenParser\AbstractTokenParser` | a Twig token parser (tag) |

The loaded objects are returned to Drupal via `ExtensionAdapter::getFunctions()`,
`getFilters()`, `getTokenParsers()`.

### Function file example

```php
<?php
// <default_theme>/source/_twig-components/functions/greeting.function.php
$function = new \Twig\TwigFunction('greeting', function () {
  return 'hello world';
});
```

Then in any Drupal Twig template: `{{ greeting() }}`.

### Filter file example

```php
<?php
$filter = new \Twig\TwigFilter('shout', fn ($s) => strtoupper($s) . '!');
```

### Tag file example (`grid.tag.php`)

Must define class `Project_grid_TokenParser` whose `getTag()` returns `'grid'`. The loader derives
the class name from the file name via regex `^([^.]+)\.tag\.php$` → `Project_{$1}_TokenParser`, so
the file name and the tag/class name must match. See the module's `example/_twig-components/tags/`
for a full `{% grid %}`/`{% cell %}` implementation.

### "Ignore in Drupal" idiom

The shipped `link.function.php` wraps its definition in `if (!class_exists('Drupal')) { $function =
… }`, so it defines the function **only outside Drupal** (Pattern Lab) and lets Drupal's own `link`
win. Use this when a helper would clash with a Drupal-provided function.

## Gotchas an agent should know

- The extension is discovered lazily when Twig first initialises; **run `drush cr`** after adding or
  changing files so the theme path and Twig cache are rebuilt.
- Files are plain `include`s executed in the Drupal request — they run PHP; keep them side-effect
  free apart from setting `$function`/`$filter` or declaring the token-parser class.
- If a type subfolder (`filters/`, `tags/`) does not exist, `scandir()` on it emits a warning; ship
  the folders you use.
- Because only the **default** theme is scanned, a helper placed in a non-default (e.g. admin) theme
  is never loaded.
- The service is declared with `arguments: ['@renderer']` but `ExtensionAdapter::__construct()`
  takes no parameters — the argument is ignored (harmless).
