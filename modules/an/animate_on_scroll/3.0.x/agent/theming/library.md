# Using Animate On Scroll

There is no admin UI. The whole module is: attach the AOS library everywhere, init it, and let you
drive animations with `data-aos` attributes.

## Install the AOS library (required)

The AOS JS/CSS is not shipped with the module. Download it and extract into the Drupal root so these
paths exist:

```
/libraries/aos/dist/aos.js
/libraries/aos/dist/aos.css
```

Source: `https://github.com/michalsnik/aos` (the README points at the `master.zip`). Until the CSS
file exists, `animate_on_scroll_requirements()` reports a `REQUIREMENT_ERROR` on
`/admin/reports/status` and `hook_install` shows a warning.

## How it attaches and initializes

- `animate_on_scroll_page_attachments()` adds library `animate_on_scroll/animate_on_scroll_lib` to
  every page (`hook_page_attachments`).
- That library (`animate_on_scroll.libraries.yml`) loads `/libraries/aos/dist/aos.js`,
  `/libraries/aos/dist/aos.css` and the module's `js/script.js`, depending on `core/jquery`,
  `core/drupal`, `core/drupalSettings`.
- `js/script.js` defines `Drupal.behaviors.aos` whose `attach` calls `AOS.init()` (with no options).

## Animate an element

Add a `data-aos` attribute (and optional modifiers) to any element — in a Twig template, block body,
field template, or CKEditor source view:

```html
<div data-aos="fade-zoom-in"
     data-aos-offset="200"
     data-aos-easing="ease-in-sine"
     data-aos-duration="600"
     data-aos-delay="100"
     data-aos-once="true">
  ...
</div>
```

Common attributes: `data-aos` (animation name — `fade-up`, `zoom-in`, `flip-left`, `slide-right`, …),
`data-aos-duration`, `data-aos-delay`, `data-aos-offset`, `data-aos-easing`, `data-aos-once`,
`data-aos-anchor`, `data-aos-anchor-placement`. Full animation/easing/attribute list is documented by
the upstream AOS project.

## Customizing the init

`AOS.init()` is called with no arguments. To pass global AOS options (e.g. `once`, `duration`,
`disable`), override/extend the behavior in a custom module or theme JS (attach after
`animate_on_scroll/animate_on_scroll_lib`) and call `AOS.init({...})` yourself, or
`AOS.refresh()`/`AOS.refreshHard()` after dynamically adding content.
