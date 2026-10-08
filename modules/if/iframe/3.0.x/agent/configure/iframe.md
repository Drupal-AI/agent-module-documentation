# Configure an iframe field

There is **no module settings page** — `configure` is `null`. All configuration is per-field
through Field UI (Structure → Content types → Manage fields / Manage form display / Manage display).

## 1. Add the field

Add a field, choose type **Iframe** (`iframe`). Stored columns (from the field schema):

| Property | Type | Default | Notes |
|---|---|---|---|
| `url` | varchar(2048) | `''` | main property; stored as `internal:`/`entity:`/absolute URI |
| `title` | varchar(255) | `''` | title text shown as a heading |
| `headerlevel` | int | `3` | heading level h1–h4 |
| `width` | varchar(7) | `600` | px number, `%`, or em/rem/vw |
| `height` | varchar(7) | `800` | px number, `%`, or em/rem/vh |
| `class` | varchar(255) | `''` | CSS classes, space-separated |
| `frameborder` | int | `0` | 0 = none, 1 = show |
| `scrolling` | varchar(4) | `auto` | `auto` / `no` / `yes` |
| `transparency` | int | `0` | 0 = off, 1 = allow |
| `allowfullscreen` | int | `1` | 0 = false, 1 = true |
| `tokensupport` | int | `0` | 0 = none, 1 = title only, 2 = title + URL |

`isEmpty()` is true when `url` is empty. URLs are validated with core `LinkWidget`.

## 2. Field settings (Manage fields → Edit → Field settings)

`fieldSettingsForm()` exposes defaults for: `class`, `headerlevel` (h1–h4), `frameborder`
(radios), `scrolling` (Automatic/Disabled/Enabled), `transparency`, `allowfullscreen`
(true/false), and `tokensupport` (No tokens / Tokens in title / Tokens in title + URL — needs
the Token module).

## 3. Widget (Manage form display) — the three widgets

| Widget id | Label | Shows to editor |
|---|---|---|
| `iframe_url` | URL only | URL (width/height saved as field default) |
| `iframe_urlheight` | URL with height | URL + height |
| `iframe_urlwidthheight` | URL with width and height | URL + width + height (**default**) |

Editor-facing fields (widget `allowedAttributes`): `title`, `url`, `headerlevel`, `width`,
`height`, `tokensupport`, plus `class` **only if `expose_class` is on**. The narrower widgets
force width/height to a hidden `value` element.

Widget settings form sets defaults for `width`, `height`, `headerlevel`, `class`,
`expose_class` (checkbox — let authors add their own class), `frameborder`, `scrolling`,
`transparency`, `allowfullscreen`, `tokensupport`. Widget settings win over field settings when
non-empty. `class` non-exposed is force-prepended to every value; when exposed the editor's
class wins.

**Width/height values:** a plain number = pixels (`500`); a number + `%` = percent (`50%`);
also `em`/`rem`/`vw` (width) and `em`/`rem`/`vh` (height). Special classes: `iframe-responsive`
(width/height become an aspect ratio, e.g. 4:3), `autoresize` (fit same-origin height).

## 4. Formatter (Manage display) — the four formatters

| Formatter id | Label | Renders |
|---|---|---|
| `iframe_default` | Title, over iframe (**default**) | `<iframe>` with title heading above |
| `iframe_only` | Iframe without title | `<iframe>` only |
| `iframe_asurl` | A link with the given title | a plain `<a>` using the title text |
| `iframe_asurlwithuri` | A link with the URI as the title | a plain `<a>` showing the URI |

## Config schema / deployment

Schema `config/schema/iframe.schema.yml` covers field settings, widget settings
(`field.widget.settings.iframe_urlwidthheight` + the two that inherit it, adding `expose_class`
and `tokensupport`), and the four formatter settings. All of it exports with
`drush config:export`.

## Token support

With `drupal/token` enabled, `tokensupport` = 1 allows tokens in the title, = 2 also in the URL
(replaced at validation via the `token` service, `['user' => currentUser]`).
