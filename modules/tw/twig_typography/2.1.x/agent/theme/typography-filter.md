# The `typography` Twig filter

The module's whole public surface is one Twig filter. Class
`Drupal\twig_typography\TwigExtension\Typography` (service `twig_typography.twig_extension`, tag
`twig.extension`, extension name `typography.twig_extension`) registers it in `getFilters()`:

```php
new TwigFilter('typography', $this->applyTypography(...), ['is_safe' => ['html']]);
```

No Twig functions are defined — only this filter.

## Use it

```twig
{{ title|typography }}
```

Runs the value through `mundschenk-at/php-typography` and returns the processed string. Typical
placement is the theme layer, e.g. `page-title.html.twig`:

```twig
<h1{{ title_attributes.addClass('page-title') }}>{{ title|typography }}</h1>
```

The input may be a **string** or a **render array**. If an array is passed,
`applyTypography()` renders it first: it tries `renderer->render($string)` (bubbleable metadata) and
falls back to `renderer->renderPlain($string)` on exception, then processes the resulting string.

## Signature

```php
Typography::applyTypography($string, array $arguments = [], $use_defaults = TRUE)
```

- `$string` — string or render array to process.
- `$arguments` — Twig hash of inline overrides (see below). Merged over the per-theme defaults.
- `$use_defaults` — passed to `new PHP_Typography\Settings($use_defaults)`. `TRUE` seeds the
  library's sane defaults; `FALSE` starts from an empty settings object, so every wanted feature
  must be passed explicitly.

Internally it does: build `Settings($use_defaults)` → `array_merge(getDefaults(), $arguments)` →
for each `$key => $value`, call `$settings->{$key}($value)` → `(new PHP_Typography())->process($string, $settings)`.

## Inline overrides (Twig hash)

Each key in the hash is called as a **method on `PHP_Typography\Settings`** with the value as its
argument, so keys are exactly the library's `Settings` method names. Examples verified in the
module's tests/templates:

| Override (Settings method) | Effect |
| --- | --- |
| `set_dewidow` | Toggle widow prevention (bool). `{'set_dewidow': FALSE}` disables it. |
| `set_dewidow_word_number` / `set_max_dewidow_length` / `set_max_dewidow_pull` | Tune de-widow limits (ints). |
| `set_classes_to_ignore` | List of HTML classes to skip (e.g. `['page-title']`). |
| `set_tags_to_ignore` | List of HTML tags to skip (e.g. `code`, `pre`, `script`). |
| `set_style_hanging_punctuation` | Wrap quotes in hanging-punctuation spans (bool). |

Any method on `PHP_Typography\Settings` is valid as a key (hyphenation language, smart quotes,
dashes, fractions, ordinals, etc.); see the library's `Settings` class for the full list. Multiple
overrides in one hash:

```twig
{{ title|typography({'set_dewidow': FALSE, 'set_style_hanging_punctuation': false}) }}
```

## Per-theme defaults

Before merging inline overrides, `applyTypography()` calls `getDefaults()`, which looks for
`typography_defaults.yml` in the **active theme's root directory**
(`extension.list.theme->getPath($active_theme) . '/typography_defaults.yml'`). If present it is
parsed with `Symfony\Component\Yaml\Yaml::parse()` and its keys become default overrides (same
key = `Settings` method name convention). There is no admin form and no config entity — this file
is the only persistent configuration.

The module ships `typography_defaults.example.yml` (copy it into your theme root and rename to
`typography_defaults.yml`). Its keys:

```yaml
set_tags_to_ignore: [orange, code, head, kbd, object, option, pre, samp, script, noscript, noembed, select, style, textarea, title, var, math]
set_classes_to_ignore: [vcard, noTypo]
set_dewidow: TRUE
```

Precedence: library defaults (`$use_defaults`) → per-theme `typography_defaults.yml` → inline Twig
hash (highest). Note `getThemeName()`/`getFilePath()` are `public static` and overridden by the
`TestTypography` subclass purely so unit tests can stub the theme path.

## Output

The filter is registered `is_safe => html`, so Twig emits its return value as markup without an
additional autoescape pass. The library preserves the input's existing HTML and inserts typographic
characters plus `<span>` CSS hooks — e.g. `<span class="pull-double">` / `push-single` for hanging
quotes and a `&nbsp;` for de-widowing — which is what those CSS hooks are meant to be styled
against. It is a presentation-layer typesetting pass over already-rendered markup, so apply it at
the point of output (headings, titles, body render output).
