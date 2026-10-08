<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configure iFrame Resizer

Single config object `iframe_resizer.settings` (config UI at `/admin/config/user-interface/iframe_resizer`, route `iframe_resizer.settings`, permission `administer iframe resizer`). Form class `src/Form/IframeResizerSettingsForm.php`. At least one of the two usage checkboxes must be on or the module does nothing.

## Library prerequisite

The iframe-resizer JS library is NOT bundled. Install v4.x:
`composer require bower-asset/iframe-resizer:^4` → `libraries/iframe-resizer/`.
v5.x is commercial and unsupported. `hook_requirements()` shows an Error on the status report until `libraries/iframe-resizer/js/iframeResizer.min.js` exists.

## Config structure (defaults from `config/install/iframe_resizer.settings.yml`)

```yaml
iframe_resizer_usage:
  host: false            # this site EMBEDS resizable iframes
  hosted: false          # this site is SHOWN inside another site's resizable iframe
iframe_resizer_advanced:            # host-mode options
  target_type: all_iframes          # or 'specific'
  target_selectors: ''              # newline-separated jQuery selectors, used when target_type=specific
  override_defaults: false          # when false, library defaults are used and the options below are ignored
  options:
    log: false
    heightCalculationMethod: bodyOffset   # bodyOffset|bodyScroll|documentElementOffset|documentElementScroll|max|min|grow|lowestElement|taggedElement
    widthCalculationMethod: scroll        # scroll|bodyOffset|bodyScroll|documentElement*|max|min|rightMostElement|taggedElement
    autoResize: true
    bodyBackground: ''      # CSS
    bodyMargin: ''          # CSS
    bodyPadding: ''         # CSS
    inPageLinks: false
    interval: 32            # ms; negative forces interval over MutationObserver; 0 disables
    maxHeight: -1           # -1 stored = Infinity (blank field in form)
    maxWidth: -1
    minHeight: 0
    minWidth: 0
    resizeFrom: parent      # parent|child
    scrolling: false
    sizeHeight: true
    sizeWidth: false
    tolerance: 0
    checkOrigin: true       # only accept postMessages from the iframe src domain
iframe_resizer_advanced_hosted_options:   # hosted-mode options
  targetOrigin: '*'         # restrict which parent domain may embed; '*' = any
  heightCalculationMethod: parent
  widthCalculationMethod: parent
```

## Behavior

- `host` on → attaches `iframe_resizer/init`; `targetSelectors` = `iframe` for `all_iframes`, or the exploded `target_selectors` lines for `specific`; emits `override_defaults` + `options` to `drupalSettings.iframeResizer.advanced`.
- `hosted` on → attaches `iframe_resizer/hosted`; emits `iframe_resizer_advanced_hosted_options` to `drupalSettings.iframeResizer.advancedHosted`.
- The form's "override defaults" fieldset, and the two advanced fieldsets, are shown/required via `#states` tied to the checkboxes. `maxHeight`/`maxWidth` left blank are stored as `-1` and interpreted as Infinity in JS.

## Set config with Drush (example)

```bash
ddev drush cset iframe_resizer.settings iframe_resizer_usage.host true -y
ddev drush cset iframe_resizer.settings iframe_resizer_advanced.target_type specific -y
ddev drush cset iframe_resizer.settings iframe_resizer_advanced.target_selectors '#report-frame' -y
```

Notes on the origin-related options (library-level, not vulnerabilities): `checkOrigin` (host, default true) restricts inbound postMessages to the iframe's src domain — the library docs say to disable it only if the frame navigates across domains. `targetOrigin` (hosted, default `'*'`) can be set to your parent site's origin to stop other parents mimicking it. Both are the iframe-resizer library's own defaults, surfaced here as admin config.
