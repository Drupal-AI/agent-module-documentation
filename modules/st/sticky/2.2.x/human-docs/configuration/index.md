# Configuration

Sticky is driven by one global settings form. Every option is stored in the
`sticky.settings` config object and pushed to the browser on every page, where the
garand/sticky library applies it to your chosen element.

## Open the settings form

1. Log in as a user with the **Administer sticky** permission.
2. Go to **Configuration → System → Sticky**, or navigate directly to
   `/admin/config/system/sticky`.

## The settings, field by field

| Field | Default | What it does |
|---|---|---|
| **DOM Selector** | `.menu--main` | The CSS selector of the element to make sticky. This is **global — one selector for the whole site**; there is no per-page or per-block option. Examples: `.menu--main`, `.header-wrapper`, `#footer`. |
| **Top spacing** | `0` | Pixels of gap between the top of the viewport and the stuck element. Increase it to clear a fixed admin toolbar or another pinned bar. |
| **Bottom spacing** | `0` | Pixels of gap before the element "unsticks" near the bottom of the page. |
| **Class name** | `is-sticky` | The CSS class added to the element's wrapper while it is stuck — use it to style the stuck state in your theme. |
| **Wrapper class name** | `sticky-wrapper` | The CSS class on the placeholder wrapper the library generates around the element. |
| **Center** | off | When on, horizontally centers the sticky element. |
| **Get width from** | *(empty)* | A selector of another element to copy a fixed width from, if you don't want the wrapper's width. |
| **Width from wrapper** | on | Match the sticky element's width to its wrapper. Only applies when **Get width from** is empty. |
| **Responsive width** | off | Recalculate widths when the window is resized (works with **Get width from**), for responsive layouts. |
| **Z-index** | `auto` | The stacking order of the stuck element, so it sits above (or below) other page elements. Set a number like `1000` if the element is being covered. |

Click **Save configuration** to apply. Changes take effect on the next page load.

> **Note on defaults:** the module ships **no default configuration and no config
> schema**. The values above are the form's built-in fallbacks — until you save the
> form at least once, the stored settings may be unset. Saving once writes them all
> to `sticky.settings`.

## Setting values without the form (drush)

```bash
drush cget sticky.settings                     # show the whole config
drush cset sticky.settings selector '.header-wrapper' -y
drush cset sticky.settings top_spacing 20 -y
drush cset sticky.settings z_index '1000' -y
```

## Two things must be true for it to work

Because the behavior comes from the JavaScript library, configuring the form is
only half the job:

1. The **target element must exist** in the rendered markup for your **DOM
   Selector**.
2. The **garand/sticky library must be installed** at
   `/libraries/sticky/jquery.sticky.js` (see
   [Installation](../installation/index.md)).

## Permission

**Administer sticky** is the only permission the module defines; it gates access to
this settings form.
