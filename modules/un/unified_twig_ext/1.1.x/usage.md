Unified Twig Extensions lets a Pattern Lab-style theme share its custom Twig functions, filters and tags with Drupal by auto-loading plain PHP extension files from the active theme's `_twig-components` directories.

---

The module registers a single Twig extension service (`newcity_twig.twig_extension`, class `ExtensionAdapter`, tagged `twig.extension`). When Twig initialises, the adapter's constructor calls `ExtensionLoader::init()`, which looks up the **site's default theme** (`system.theme:default`), resolves its path, and globs one directory level below it for `*/_twig-components/` folders (e.g. `<theme>/source/_twig-components/` or `<theme>/pattern-lab/_twig-components/`). Inside each it scans three subfolders — `functions/`, `filters/`, `tags/` — and `include`s every `*.php` file (skipping files whose name starts with `.`, `_`, or `pl_`). A **function** file must set a `$function` variable to a `\Twig\TwigFunction`; a **filter** file must set `$filter` to a `\Twig\TwigFilter`; a **tag** file `NAME.tag.php` must define a class `Project_NAME_TokenParser` (a `\Twig\TokenParser\AbstractTokenParser`), which is instantiated and registered as a token parser. The loaded objects are exposed to Drupal's Twig via `getFunctions()/getFilters()/getTokenParsers()`. This means the same PHP-defined Twig extensions can power both a stand-alone Pattern Lab build and the Drupal front end without duplication. There is no admin UI, no configuration, no permissions, no Drush, and no plugins; the loader path is currently hard-coded to the default theme (the README notes overriding it is a TODO).

---

- Reuse a design system's Pattern Lab Twig functions directly inside Drupal templates.
- Share a custom `icon()` or `link()` Twig function between Pattern Lab and Drupal.
- Define a Twig filter once (e.g. a currency or slug filter) and use it in both environments.
- Provide a custom `{% grid %}`/`{% cell %}` block tag that emits ITCSS grid markup.
- Keep component markup DRY across a static prototype and the live Drupal site.
- Add project-specific Twig helpers without writing a full Drupal module.
- Let front-end developers drop a `.function.php` file into the theme and have Drupal pick it up.
- Ship reusable Twig tags (token parsers) as part of a theme's component library.
- Migrate an existing Pattern Lab theme to Drupal while preserving its Twig extensions.
- Guard a shared function so it only defines itself outside Drupal (`if (!class_exists('Drupal'))`).
- Namespace-free authoring of Twig extensions for designers unfamiliar with Drupal services.
- Centralise Twig extension code in the theme's `_twig-components` folder for versioning.
- Add a Twig function that wraps a component's BEM markup for consistent output.
- Provide a `svg()`/`sprite()` Twig function usable in both prototype and production templates.
- Prototype new template helpers in Pattern Lab, then expose them to Drupal by enabling this module.
- Organise extensions by type (functions/filters/tags) in a predictable directory structure.
- Skip experimental files from loading by prefixing them with `_` or `pl_`.
- Support a component-driven build where the theme is the single source of truth for Twig logic.
- Avoid clearing and re-registering Twig extensions in a Drupal `.module`/services file for every helper.
- Let a base theme expose Twig helpers to any sub-theme rendered as the default theme.
