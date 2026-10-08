# Configure Sidr

## Install the JS library first
The module integrates but does not bundle jQuery Sidr. Install it so
`libraries/jquery.sidr/dist/jquery.sidr.min.js` exists — the module ships `composer.libraries.json`
(package `jquery/sidr` 2.2.1 from Asset Packagist); include it via the Composer Merge Plugin and add a
`type:drupal-library` installer path. The Status report shows whether it's found.

## Global settings — config `sidr.settings`
Route `sidr.settings` at `/admin/config/user-interface/sidr` (permission `administer site
configuration`). Install defaults in `config/install/sidr.settings.yml`.

| Key | Default | Meaning |
|---|---|---|
| `sidr_theme` | `dark` | Which theme CSS library to attach: `bare` / `light` / `dark`. `bare` = style it yourself. |
| `close_on_escape` | `true` | Close panels on Escape key (passed to JS via drupalSettings). |
| `close_on_blur` | `true` | Close panels when interacting outside them. |

## Trigger block config (`sidr_trigger` → schema `block.settings.sidr_trigger`)
Placed at `/admin/structure/block`. Basic + Advanced form groups; stored on the block config entity.

| Key | Form group | Meaning |
|---|---|---|
| `trigger_text` | Basic | Label on the trigger button. Either this OR `trigger_icon` is required (block validate). |
| `sidr_source` | Basic (required) | jQuery selector, URL, or callback that provides the panel content. |
| `sidr_side` | Basic | `left` or `right`. |
| `trigger_icon` | Advanced | Raw HTML markup for an icon (e.g. `<span class="icon-hamburger"></span>`). |
| `sidr_name` | Advanced | Unique DOM id for the Sidr instance. |
| `sidr_method` | Advanced | `toggle` / `open` / `close`. |
| `sidr_speed` | Advanced | Animation speed: `slow`, `fast`, or ms. |
| `sidr_timing` | Advanced | CSS timing function (numeric coerced to int). |
| `sidr_nocopy` | Advanced | Use original source elements instead of copying inner HTML (mutually exclusive with renaming). |
| `sidr_renaming` | Advanced | Rename source element classes/IDs when copying (mutually exclusive with nocopy). |
| `sidr_displace` | Advanced | Displace page content during animation. |
| `sidr_body` | Advanced | Element to displace (shown only when displace is on); defaults to BODY. |

`getSidrJsOptions()` maps these into the `source/name/side/method/speed/timing/renaming/displace/nocopy/body`
options object (empty values filtered out) that becomes `data-sidr-options` on the button. Note the
per-block "Theme" field is display-only/disabled — theme is controlled globally via `sidr_theme`.
