# Configure (via the `wowjs_ui` submodule)

The **base `wowjs` module has no settings page** — it just auto-attaches WOW.js and inits every
Animate.css-classed element. Configuration exists only when the **`wowjs_ui`** submodule is enabled
(it depends on `animatecss:animatecss_ui` and `wowjs:wowjs`). Enable it with
`drush en wowjs_ui -y`.

There is no standalone WOW route. `Drupal\wowjs_ui\Routing\RouteSubscriber::alterRoutes()`
(`src/Routing/RouteSubscriber.php`) overrides the **existing `animatecss.settings` route** and swaps
its `_form` to `Drupal\wowjs_ui\Form\WowJsSettings`. That form extends `animatecss_ui`'s
`AnimateCssSettings` and appends two detail groups — "WOW settings" and "WOW default options" — so
the WOW options live on the AnimateCSS settings page (access is whatever `animatecss_ui` grants for
that route; `wowjs`/`wowjs_ui` define **no permissions of their own**). The `configure` link in
`wowjs_ui.info.yml` points at `animatecss.admin`.

## Config object: `wowjs.settings`

Install defaults: `wowjs_ui/config/install/wowjs.settings.yml`. Schema:
`wowjs_ui/config/schema/wowjs.schema.yml`.

| Key | Type | Default | Meaning (form field) |
|---|---|---|---|
| `hide` | boolean | `false` | Suppress the "library missing / using CDN" warning. Field appears only when the local library is absent. |
| `method` | string | `local` | `local` or `cdn`. Forced to `cdn` and locked when `wowjs_check_installed()` is false. |
| `minimized.options` | integer | `1` | `0` = non-minified/source (Development), `1` = minified (Production). Applies to both local and CDN. |
| `options.boxClass` | string | `wow` | CSS class marking animated elements. **Note:** the form reads/writes `options.classBox` (see caveat below), validated to letters only (no dot, no `#`, no spaces/digits). |
| `options.animateClass` | string | `animate__animated` | Animate.css base class. |
| `options.offset` | integer | `0` | Distance (px) from the element before the animation triggers. |
| `options.mobile` | boolean | `true` | Trigger animations on mobile. |
| `options.live` | boolean | `true` | Act on asynchronously loaded content. |
| `options.once` | boolean | `true` | Run the animation only once when scrolled into view (flagged New/Experimental). |
| `options.mirror` | boolean | `false` | Re-mirror the animation when re-entering from top/bottom (New/Experimental). |
| `options.optionalContainer` | boolean | `false` | Use a custom scroll container instead of `window`. |
| `options.scrollContainer` | string | `window` | Selector for the scroll container (only when `optionalContainer` is on). |
| `options.resetAnimation` | boolean | `true` | Restart the animation after it finishes. (Schema mislabels this key `type: string`.) |

These map to the WOW.js constructor options in `wowjs_ui/js/wowjs.init.js` (`Drupal.behaviors.wowJS`
+ `Drupal.WOW`), exported via `drupalSettings.wowjs.settings`.

### Caveat — `boxClass` vs `classBox`

`config/install` seeds `options.boxClass` and `wowjs_ui_update_8004()` renamed `classBox` →
`boxClass`, but `WowJsSettings::buildForm()`/`submitForm()` still read and write `options.classBox`
(`src/Form/WowJsSettings.php:106,222`). The runtime JS also reads `settings.classBox` in one place
and `settings.boxClass` in another. In practice the default `wow` class is what works; a changed
class name may not propagate consistently. Treat `wow` as the reliable box class.

## Per-animation WOW control

With `wowjs_ui` enabled, the AnimateCSS **add-animation** form (route `animatecss.add`, form
`animatecss_form`) gains WOW fields:

- `hook_animatecss_scroll_library_options` (`wowjs_ui_animatecss_scroll_library_options()`) adds a
  `wow` library block with `once` and `mirror` checkboxes.
- `hook_form_animatecss_form_alter` + `wowjs_ui_form_animatecss_form_submit()` store the per-record
  values into the animate record's serialized `options['wow']` (`enable`, `once`, `mirror`).

On page render, `wowjs_ui_page_attachments()` (`wowjs_ui.module`) loads all animate records via the
`animatecss.animate_manager` service, keeps only those with `options['wow']['enable']` true, and
exports them as `drupalSettings.wowjs.elements` alongside `drupalSettings.wowjs.settings`; then it
attaches the matching library variant:

| `method` | `minimized.options` | Library attached |
|---|---|---|
| `local` | `1` (minified) | `wowjs_ui/wow.js` |
| `local` | `0` (source) | `wowjs_ui/wow.dev` |
| `cdn` | `1` (minified) | `wowjs_ui/wow.cdn` |
| `cdn` | `0` (source) | `wowjs_ui/wow.cdn.dev` |

plus `wowjs_ui/wow-init`. Attachment is skipped entirely unless `animatecss.settings:load` is on and
`_animatecss_ui_check_url()` allows the current path.

## Install the WOW.js library (both modules)

Download `https://github.com/matthieua/WOW/archive/master.zip`, extract, and place so that
`/libraries/wow/dist/wow.min.js` (and `/libraries/wow/dist/wow.js` for the source variant) exist.
Without it, both modules automatically fall back to the jsDelivr CDN and the status report shows a
warning (dismissible with `hide`).
