<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Attaching and customizing the checkbox styling

## Install / enable
`drush en custom_checkboxes -y`. No configuration step, no permissions, no settings route.
The module does nothing until you attach its library.

## The library
Defined in `custom_checkboxes.libraries.yml` as `custom_checkboxes/custom_checkboxes`:
```
custom_checkboxes:
  css:
    theme:
      css/custom_checkboxes.css: {}
  js:
    js/custom_checkboxes.js: {}
  dependencies:
    - core/jquery
```

## Attach it
Nothing attaches the library automatically. Add it wherever checkboxes should be styled.

- Twig template: `{{ attach_library('custom_checkboxes/custom_checkboxes') }}`
- Render array / preprocess: `$variables['#attached']['library'][] = 'custom_checkboxes/custom_checkboxes';`
- Theme-wide: list `custom_checkboxes/custom_checkboxes` under `libraries:` in your theme's `*.info.yml`.

## Runtime behavior — `js/custom_checkboxes.js`
`Drupal.behaviors.customCheckbox.attach(context, settings)`:
- If the context has a `body` or a `.views-exposed-form`, it selects **all** `input[type="checkbox"]`
  on the page (the selector is not scoped to `context`).
- For each checkbox with no existing `span.checkmark` sibling under its parent, it inserts
  `<span class="checkmark"></span>` after the input and adds class `checkmark-label` to the parent.
- The guard (checking for an existing `span.checkmark`) makes re-runs idempotent, so Ajax/behavior
  re-attach does not duplicate spans.

## Styling — `css/custom_checkboxes.css`
The native input is made invisible and overlaid; the visible control is pure CSS:
- `input[type="checkbox"]` → `opacity:0`, `30x30px`, `z-index:2`, pointer cursor on hover.
- `.checkmark` → absolute 30x30px box, `0.5px solid #333333` border, white background, `z-index:1`.
- `input:checked ~ .checkmark` → background `#15459A` (the "checked" color to change for branding).
- `.checkmark:after` → the tick: a rotated (45deg) bottom+right border, shown only when checked.
- `.checkbox .checkmark-label` → `padding-left:40px` to make room for the box.

To rebrand: override these selectors in your theme CSS (loaded after this library) or edit the file —
typically the border color, the checked background `#15459A`, and the box size.

## Notes / limitations
- The JS restyles every checkbox on the page once the library is attached; you cannot target a subset
  through configuration — scope by only attaching the library on the relevant templates, or add
  more specific CSS.
- The styled box is decorative; keyboard focus/checked state still live on the underlying native input.
- No `.install`, no update hooks, no config to export.
