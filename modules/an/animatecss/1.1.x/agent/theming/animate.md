<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Applying Animate.css animations

## Basic usage (markup)

Add the base class `animate__animated` plus an animation name class (with the `animate__` prefix) to any element:

```html
<h1 class="animate__animated animate__bounce">An animated element</h1>
```

From JavaScript:

```js
const el = document.querySelector('.my-element');
el.classList.add('animate__animated', 'animate__bounceOutLeft');
```

Modifier classes from Animate.css also work: `animate__delay-1s`…`animate__delay-5s`, `animate__slow`/`animate__slower`/`animate__fast`/`animate__faster`, `animate__infinite`, `animate__repeat-1`…`animate__repeat-3`.

## How the library is loaded

The base module defines two asset libraries (`animatecss.libraries.yml`):

| Library | Source |
|---|---|
| `animatecss/animate.css` | Local: `/libraries/animate.css/animate.min.css` |
| `animatecss/animate.cdn` | External: `//cdnjs.cloudflare.com/ajax/libs/animate.css/4.1.1/animate.min.css` |

`hook_page_attachments()` attaches one of them to **every page — but only when the `animatecss_ui` submodule is NOT enabled.** Selection: if `animatecss_check_installed()` finds `/libraries/animate.css/animate.min.css`, the local `animate.css` library is used; otherwise it falls back to the CDN `animate.cdn` library. (When `animatecss_ui` IS enabled, that submodule takes over attachment with its richer method/variant/compat logic — see the submodule docs.)

## Self-hosting the library

Download `https://github.com/animate-css/animate.css/archive/main.zip`, extract to `/libraries/animate.css/` so `/libraries/animate.css/animate.min.css` exists. `hook_requirements()` (runtime) reports **Installed** (local) or **Not installed** (CDN) on the status report; the CDN warning can be silenced with the `silent` config flag (exposed by `animatecss_ui`).

## Attaching only where needed (custom code)

To attach the library to a specific render array instead of site-wide, add it yourself:

```php
$build['#attached']['library'][] = 'animatecss/animate.css'; // or 'animatecss/animate.cdn'
```
