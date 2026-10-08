# Configure Lazy-load

Settings form: `/admin/config/content/lazy` (route `lazy.config_form`, permission
`administer filters`). Config object: **`lazy.settings`** (schema in `config/schema/lazy.schema.yml`,
so it exports/deploys with `drush config:export`). Editable config also includes `image.settings`
(only reads `preview_image` for the form's preview).

## Three ways to enable lazy-loading

1. **Text-format filter** — enables lazy-loading for inline `<img>`/`<iframe>` in formatted text.
   Go to **Admin → Config → Content authoring → Text formats and editors**, edit a format
   (e.g. *Full HTML*), enable **Lazy-load images and iframes** (filter id `lazy_filter`). Its two
   checkboxes (`image`, `iframe`, both default TRUE) pick which tags. Enabling the filter with
   both unchecked auto-disables it. Filter weight is 20 (reversible transform).
2. **Image field formatters** — in *Manage display*, either choose the **Image (Lazy-load)**
   (`lazy_image`) or **Responsive image (Lazy-load)** (`lazy_responsive_image`) formatter, or check
   the **Enable lazy-loading** box that Lazy adds (via third-party settings) to supported formatters:
   `image`, `responsive_image`, `colorbox`, `media_thumbnail`. Third-party keys: `lazy_image` (bool),
   `placeholder_style` (image style), `data_uri` (bool). Add more formatters with
   `hook_lazy_field_formatters_alter()`.
3. **Form API** — add `'#item_attributes' => ['data-lazy' => TRUE]` (or `#attributes` `data-lazy`)
   to an image render element; `lazy_process_variables()` converts it.

## Native vs. library mode — `preferNative`

| `preferNative` | Behavior |
|---|---|
| `true` | Adds `loading="lazy"` to the element. No JavaScript / lazysizes loaded. Browser handles it. |
| `false` (default) | Uses the **lazysizes** library for all browsers: adds the `lazyClass` (default `lazyload`) marker class and moves `src` → the `srcAttr` attribute (default `data-src`; falls back to `data-filterlazy-src` if `srcAttr` is left as `src`). |

## Key `lazy.settings` values (defaults)

| Key | Default | Meaning |
|---|---|---|
| `preferNative` | `false` | Use native `loading="lazy"` instead of lazysizes when supported |
| `skipClass` | `no-lazy` | Elements (or their parent) with this class are NOT lazy-loaded |
| `placeholderSrc` | `''` | Placeholder used in `src` while the real image loads (library mode) |
| `cssEffect` | `false` | Apply a default fade-in CSS transition on load |
| `minified` | `true` | Load minified library files |
| `libraryPath` | `/libraries/lazysizes` | Path or URL to lazysizes; must start with `/` or `https://`, no trailing slash |
| `disable_admin` | `true` | Disable lazy-loading on admin routes |
| `visibility` | `request_path`, pages `/rss.xml`, negate `0` | Which paths lazy-loading applies to |

AMP pages (`?amp` in query) are always excluded. Set values with e.g.
`drush cset lazy.settings preferNative 1` or `drush cset lazy.settings skipClass no-lazy`.

### Visibility (path restriction)

Uses the core `request_path` condition. `pages` is a newline list of paths; `negate = 0` means
"everywhere EXCEPT these pages", `negate = 1` means "ONLY these pages". `Lazy::isPathAllowed()`
evaluates it at runtime.

### lazysizes sub-settings (`lazy.settings` → `lazysizes.*`)

Marker classes (`lazyClass` `lazyload`, `loadedClass` `lazyloaded`, `loadingClass`, `preloadClass`,
`errorClass`, `autosizesClass`), source attributes (`srcAttr` `data-src`, `srcsetAttr` `data-srcset`,
`sizesAttr` `data-sizes`), and tuning (`minSize` 40, `init` true, `expFactor` 1.5, `hFac` 0.8,
`loadMode` 2, `loadHidden` true, `ricTimeout` 0, `throttleDelay` 125, `customMedia` {}, `plugins` []).
`plugins` is a checkbox list of ~22 lazysizes plugins (bgset, blur-up, respimg, parent-fit,
unveilhooks, native-loading, object-fit, print, progressive, twitter, video-embed, …).
