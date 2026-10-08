<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# How it works (mechanism)

The entire module is `animate_css.module` (two hooks) plus `animate_css.libraries.yml` and an
`.install` file. No services, plugins, config or permissions.

## Library definition

`animate_css.libraries.yml`:

```yaml
animate:
  remote: https://animate.style/
  license: { name: MIT, url: http://opensource.org/licenses/MIT, gpl-compatible: true }
  css:
    theme:
      /libraries/animate.css/animate.css: {}
```

- Library id (for `#attached`) is **`animate_css/animate`**.
- The CSS path is **root-relative**: the file must exist at `web/libraries/animate.css/animate.css`.
- Supplied by the Composer library package **`drupal-shimmy/animate.css` 4.1.1** (declared in the
  module's `composer.json`), which installs to `web/libraries/animate.css/` via the
  `drupal-library` installer type.

## Global attachment

```php
function animate_css_page_attachments(array &$attachments) {
  $attachments['#attached']['library'][] = 'animate_css/animate';
}
```

This runs on **every** page, so the animate.css classes are available everywhere with no further
configuration. There is no per-page or per-element opt-in in the module — you add the classes.

## Using the classes (animate.css v4)

Add the base class plus an effect class to any element:

```html
<h1 class="animate__animated animate__fadeInUp">Hello</h1>
```

- Base: `animate__animated` (required).
- Effect (examples): `animate__bounce`, `animate__fadeIn`, `animate__fadeInUp`, `animate__zoomIn`,
  `animate__flipInX`, `animate__shakeX`, `animate__pulse`, `animate__tada`.
- Utilities: `animate__delay-1s`…`animate__delay-5s`, `animate__slow`/`animate__slower`,
  `animate__fast`/`animate__faster`, `animate__infinite`, `animate__repeat-2`.

From JavaScript: `el.classList.add('animate__animated', 'animate__bounce');`

> v4 uses the `animate__` prefix. The pre-v3 unprefixed names (`animated bounce`) do **not** work
> with the 4.1.1 library this module ships.

## Requirements / status report

`hook_requirements()` (`animate_css.install`) looks up `animate_css/animate` via
`library.discovery` and checks `file_exists(DRUPAL_ROOT . '/' . <css path>)`. If the file is
absent it reports severity `REQUIREMENT_ERROR` ("Animate library — Not installed") on
`/admin/reports/status`, otherwise "Installed". `hook_install()` prints the same warning as a
message when the library is missing at install time.
