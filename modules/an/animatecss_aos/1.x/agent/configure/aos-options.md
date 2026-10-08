<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configure AOS on an animation

There is **no settings page** for animatecss_aos. All configuration happens per selector inside the
AnimateCSS UI. Go to the AnimateCSS *Add animation* form (route `animatecss.add`, path
`/admin/config/user-interface/animatecss/add`, provided by `animatecss_ui`), or edit an existing
animate record. animatecss_aos injects an **"AOS"** option group into that form; toggling its `aos`
checkbox on a record makes that selector animate on scroll instead of (only) on page load.

The AOS option fields are registered by `animatecss_aos_animatecss_scroll_library_options()`
(`animatecss_aos.module:115`), which AnimateCSS collects through
`animatecss_scroll_options()` / `invokeAll('animatecss_scroll_library_options')`. Fields (Form API):

- `aos_offset` (`number`, default `120`) — px offset from the trigger point. Stored as `aos.offset`.
- `easing` (`select`, default `ease`, options from `aosjs_easing_functions()`). Stored as `aos.easing`.
- `anchor_placement` (`select`, default `top-bottom`, options from `aosjs_anchor_placements()`).
  Stored as `aos.anchorPlacement`.
- `once` (`checkbox`) — animate only once while scrolling down. Stored as `aos.once`.
- `mirror` (`checkbox`) — animate out again while scrolling past. Stored as `aos.mirror`.

The `aos` enable checkbox itself is part of the AnimateCSS form; when it is set,
`animatecss_aos_form_animatecss_form_submit()` (prepended to the form's submit handlers,
`animatecss_aos.module:252`) writes the full `aos` sub-array into the record's serialized `options`:
`enable`, `offset`, `delay`, `duration`, `easing`, `anchorPlacement`, `once`, `mirror`.

## Delay / duration mapping (AnimateCSS ⇄ AOS)

AnimateCSS expresses timing as named classes; AOS wants milliseconds. The submit handler translates
one to the other (`animatecss_aos.module:260`–`322`), and the alter callback maps them back for the
edit form (`:176`–`239`):

- Delay: `delay-1s…delay-5s` → `1000…5000` ms; `delay = custom` uses the `time` value; otherwise `0`.
- Duration (from the `speed` select): `slower`→`3000`, `slow`→`2000`, `fast`→`800`, `faster`→`500`;
  `speed = custom` uses the `duration` value; otherwise `1000`. Reverse mapping sets the AnimateCSS
  `speed`/`delay` selects when you re-open the form.

## What gets emitted to the page

On every front-end request `animatecss_aos_page_attachments_alter()` (`animatecss_aos.module:13`)
runs **only if** `animatecss.settings:load` is true and `_animatecss_ui_check_url()` passes (the
AnimateCSS path-visibility rules). It loads all animate records via
`\Drupal::service('animatecss.animate_manager')->loadAnimate()`, keeps those whose
`options['aos']['enable']` is set, and — when `aosjs_ui` is enabled — also merges AOS JS's own
selectors (and, if `aosjs_animatecss` is on and `aosjs.settings:options.library == 'animate'`, the
AnimateCSS-flavoured AOS selectors). Serialized options are read with
`unserialize(..., ['allowed_classes' => FALSE])`.

It then exports `drupalSettings`:
`aosjs.version = 'v3'`, `aosjs.library`, `aosjs.additional` (AOS advanced config from
`aosjs.settings:advanced`, or `[]` when AOS UI is absent), `animateCssAOS.compat`
(`animatecss.settings:compat`, controls the `animate__` class prefix), and `animateCssAOS.elements`
(the merged record list). Libraries attached: `animatecss_aos/animatecss_aos` and `aosjs/aos-v3.js`.

`js/animatecss_aos.init.js` (`Drupal.behaviors.animateCssAosInit` → `Drupal.animateCssAosPrepare`)
then, per selector, optionally clears old `animate__*` classes, sets `animation-delay`/`-duration`
CSS, and writes the `data-aos*` attributes (`data-aos`, `data-aos-library`, `data-aos-offset`,
`data-aos-delay`, `data-aos-duration`, `data-aos-easing`, `data-aos-anchor-placement`,
`data-aos-once`, `data-aos-mirror`), calling `AOS.init()` once at the end. `css/animatecss_aos.css`
hides `[data-aos-library="animate"]` until it becomes `.animated`/`.animate__animated`.

## Library location

The AOS JavaScript library is **not** bundled in this module and does **not** go under
`web/libraries/`. It is shipped by the required `aosjs` module (`aosjs/lib/v3/aos.js`,
`aosjs/lib/v2/aos.js`) and exposed as the Drupal library `aosjs/aos-v3.js`. animatecss_aos forces the
v3 build: if AOS UI queued `aosjs/aos-v2.js` / `aosjs/aos-v2.cdn`, it is removed and the matching v3
library added; if AOS UI is not installed, `aosjs/aos-v3.js` is attached directly. There is also a
CDN variant (`aosjs/aos-v3.cdn`, unpkg) defined by the `aosjs` module, but animatecss_aos always
attaches the local `aosjs/aos-v3.js`.

## Uninstall behaviour

`animatecss_aos_uninstall()` re-saves every animate record with the `aos` key removed from its
serialized options (via `animatecss.animate_manager::addAnimate()`), so removing this module cleans
its data out of the shared AnimateCSS store rather than leaving orphaned `aos` options behind.
