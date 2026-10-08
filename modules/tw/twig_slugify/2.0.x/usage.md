Twig Slugify adds a single `slugify` Twig filter that turns any string into a URL-safe slug using the `cocur/slugify` PHP library, usable directly in theme templates.

---

The module registers one Twig extension (`SlugifyTwigExtension`, tagged `twig.extension`) exposing the filter `slugify`. In a template you write `{{ 'Some Title'|slugify }}` to get `some-title`. The filter is a static callback that instantiates `Cocur\Slugify\Slugify` and calls `->slugify($string, $options)`, so it accepts an optional options array (second argument) to control separator, lowercase, ruleset, regex, etc., per the cocur/slugify API. There is no configuration UI, no permissions, no services beyond the Twig extension, and no config schema — install it and the filter is available everywhere Twig runs. It requires the `cocur/slugify` `^4.0` Composer library (pulled in automatically via the module's `composer.json`).

---

- Generate a URL-safe slug from a node title in a template: `{{ node.label|slugify }}`.
- Build anchor IDs from heading text for in-page navigation.
- Create clean CSS class or id fragments from arbitrary field values.
- Slugify a taxonomy term name for use in a custom link.
- Produce filename-safe strings for download links in templates.
- Transliterate accented characters to ASCII in rendered markup.
- Change the separator (e.g. underscore) via the options argument: `{{ title|slugify({'separator': '_'}) }}`.
- Keep original case with the `lowercase: false` option when needed.
- Apply a language-specific ruleset for correct transliteration.
- Slugify concatenated strings to build composite keys in Twig.
- Generate consistent `data-*` attribute values from labels.
- Create predictable fragment identifiers for accordion/tab components.
- Normalize user-facing strings into machine-friendly tokens at render time.
- Build slug-based routes or query params inside a template link.
- Slugify menu link titles for custom menu templates.
- Derive image alt/id helpers from captions.
- Produce SEO-friendly anchor slugs without writing PHP.
- Sanitize strings for use in JavaScript hooks embedded in templates.
