<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The Twig extension and its functions

## Install & enable

```bash
# dev-checkout in this project (no packaged release / no composer.json)
drush en dsfr_twig_components -y
```

Core deps only: **media**, **media_library**, **text**. Usually pulled in as a dependency of
DSFR Core. Nothing to configure — enabling it registers the Twig functions.

## How functions are registered

`src/Twig/TwigExtension.php` (service `dsfr_twig_components.twig.twig_extension`,
tag `twig.extension`):

- `twigFunctionsList()` returns `name => ['class' => ..., 'method' => ...]`. Method names are
  derived from the function name by `rename()` (snake_case → CamelCase) and, for `m_*`, a `m`
  prefix, for `c_*`, a `c` prefix; `ExternalTools` methods use `lcfirst()`.
- `getFunctions()` wraps each entry in `new TwigFunction($name, [$class, $method], ['is_safe' => ['html']])`.
  Every function returns a rendered DSFR HTML component, so call them from your templates with your
  own template-controlled DSFR content (labels, classes, component options), the same way you would
  use any component-builder helper.

The other `src/Twig/*` services (`.markup`, `.components`, `.pseudoComponents`, `.externalTools`,
`.internalTools`, `.resources` in `.services.yml`) are declared but the functions are invoked as
**static** methods via the `[class, method]` callables, not through the container. Note the
`.components` service points at a class `Twig\Components` that does not exist (the class is
`DsfrComponents`); it is effectively unused.

## `dsfr_*` — DSFR components (`DsfrComponents`)

Signature for singles: `dsfr_x(array $data_config = [], array $attributes = [])`.
Groups take `dsfr_x(array $group_data, array $attributes = [])` with a `group` key.

| Twig function | Method | Notes |
|---|---|---|
| `dsfr_highlight` | `highlight` | mise-en-exergue; always translated text |
| `dsfr_image` | `image` | `src` mandatory; optional `text` legend, `ratio` |
| `dsfr_link` | `link` | link/button/text/real_button; tooltip, arrow, external detection |
| `dsfr_quote` | `quote` | author, cite, details (list of links) |
| `dsfr_title` | `title` | `type`=1..6 → `h1..h6` (default h2); via `Markup::item` |
| `dsfr_accordion` / `dsfr_accordions` | `accordion` / `accordions` | single / group |
| `dsfr_tab` / `dsfr_tabs` | `tab` / `tabs` | tab returns array; tabs group builds tablist HTML |
| `dsfr_card` / `dsfr_tile` | `card` / `tile` | `title` mandatory; optional `url` → enlarge-link |
| `dsfr_button` / `dsfr_buttons` | `button` / `buttons` | btn + `fr-btns-group` variants |
| `dsfr_franceconnect` | `franceconnect` | optional `plus` |
| `dsfr_search` | `search` | search bar, auto id |
| `dsfr_tooltip` | `tooltip` | auto id, `aria-describedby` |
| `dsfr_alert` | `alert` | `type` default `warning`; title/text/`sm` rules |
| `dsfr_badge` / `dsfr_badges` | `badge` / `badges` | single / `li` group |
| `dsfr_callout` | `callout` | title/text + optional embedded button |
| `dsfr_notice` | `notice` | time-boxed via `start`/`end` (unix time vs `time()`) |
| `dsfr_tag` / `dsfr_tags` | `tag` / `tags` | link / button / pressed / dismissible |

Pipeline (all in `DsfrComponents`):

- `configComponent(key, check, params)` sets the component key, mandatory-field list and defaults.
- `dsfrComponent()` validates mandatory fields (special-cased for `alert`), merges the default
  variables from `InternalTools::recurringVariables()` with `$data_config` via `extract()`, builds
  per-component `$content`/`$config`/`$pattern`, then calls `render()`. On missing data it returns
  `PseudoComponents::cIncorrect($msg)` (a small `fr-alert--error` block). Unknown key → an "object
  doesn't exist" error alert.
- `dsfrComponentGroup()` handles the `*s` group variants (and the bespoke tabs tablist markup).
- `render(key, content, attr, attr_str, config, render)` returns, by mode:
  `twig` (default) → `\Drupal::service('twig')->render('dsfr-comp-'.$key.'.html.twig', $vars)`;
  `array` → the raw `[content, attr, attr_str, config]`; else a render array `#theme` build.

## `m_*` / `markup` — generic tags (`Markup`)

`Markup::item($content, $attributes = [], $tag = 'div', $tra = false)` concatenates
`<$tag $attr>$content</$tag>` (self-closing for `hr`/`img`). Attributes are stringified by
`InternalTools::convertAttributes()`. Registered functions: `markup` (→ `item`), `m_a` (→ `mA`,
default `href="#"`), `m_button` (→ `mButton`), `m_div` (→ `mDiv`), `m_hr` (→ `mHr`), `m_img`
(→ `mImg`), `m_p` (→ `mP`). (`m_btn` is registered but maps to a non-existent `mBtn` — use
`m_button`.)

## `c_*` and code helpers (`PseudoComponents`)

- `c_code` → `cCode(text, attr, language='twig')` — escapes `<`/`>` in `text`, wraps in an
  `fr-code` block via `DsfrComponents::render('code', ...)` (needs the `code` library).
- `c_error` / `c_info` / `c_hl` / `c_warning` → small alert/highlight wrappers around
  `DsfrComponents::alert()` / `highlight()`.
- `braces`, `chevron`, `chevrons`, `code_twig`, `comment_twig`, `var_twig` — emit escaped
  documentation snippets (`{{ }}`, `<tag>`, `{% %}`, `{# #}`).
- `cIncorrect($msg)` — the internal "Error: ..." fallback block (not a Twig function).
  (`c_copy_code` is registered but maps to a non-existent `cCopyCode`.)

## Plain helpers (`ExternalTools`)

| Twig function | Method | Returns |
|---|---|---|
| `ati` / `atix` / `atx` | `ati`/`atix`/`atx` | array shortcuts `{title}` / `{title,text}` / `{text}` |
| `not_empty_merge` | `notEmptyMerge` | conditionally merge a field into a data array |
| `convert_bytes` | `convertBytes(int)` | human-readable size (octet/ko/mo/go) |
| `get_media_info` | `getMediaInfo(int $mid)` | `{name,url,size,mime,ext}` from a Media id (loads `Media`/`File`, uses `MimeTypes`) |
| `limit_string` | `limitString(str, limit=60, after='[...]')` | truncated string |
| `uniq_id` | `uniqId()` | PHP `uniqid()` |
| `calc_image_ratio` | `calcImageRatio(w, h)` | nearest DSFR ratio string (`16x9`,`4x3`,`1x1`,...) |

`get_media_info` takes an integer media id and resolves it through the entity API + a local file;
it does **not** fetch remote URLs.

## `InternalTools` (not exposed to Twig)

Support methods used by the components: `recurringVariables()` (default variable set),
`buildHref()` / `typeUrl()` (link/URL handling, external-link detection via `Url` +
`$_SERVER['HTTP_HOST']`), `checkClasses()` / `mergeClass()` / `convertAttributes()`
(attribute/class assembly), `handleTra()` / `tra()` (translation), and `set*` pattern helpers
(size/type/color/icon/disabled/external).
