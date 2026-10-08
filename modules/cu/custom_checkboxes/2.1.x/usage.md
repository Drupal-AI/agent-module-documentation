<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Custom Checkboxes replaces the native browser checkbox with a CSS-styled box via an attachable asset library and a small jQuery behavior.

---

Custom Checkboxes is a pure front-end/theming module. It ships one asset library, `custom_checkboxes/custom_checkboxes`, made of a CSS file (`css/custom_checkboxes.css`) and a jQuery behavior (`js/custom_checkboxes.js`, depending on `core/jquery`). When the library is attached to a page, the behavior `Drupal.behaviors.customCheckbox` finds every `input[type="checkbox"]`, sets it transparent (`opacity:0`), inserts a sibling `<span class="checkmark">`, and adds a `checkmark-label` class to the parent; the CSS then draws the visible box, border, hover cursor, checked background (`#15459A`), and the rotated-border checkmark tick. There is no configuration form, route, permission, config schema, service, or PHP hook — you enable the module, attach the library where checkboxes appear (`{{ attach_library('custom_checkboxes/custom_checkboxes') }}`), and edit the CSS to match your design. Styling is applied site-wide to every checkbox on any page/template that attaches the library, including exposed Views filter forms.

---

- Style checkbox form elements consistently across browsers.
- Replace the default OS/browser checkbox rendering with a branded box.
- Attach the library in a Twig template with `{{ attach_library('custom_checkboxes/custom_checkboxes') }}`.
- Attach the library from a theme `*.info.yml` or a preprocess hook via `#attached['library']`.
- Give checkboxes a fixed 30x30px box with a custom border color.
- Change the checked-state background color by editing `input:checked ~ .checkmark`.
- Restyle the checkmark tick shape via the `.checkmark:after` rules.
- Apply a consistent checkbox look to node/entity forms.
- Style exposed filter checkboxes in Views filter forms.
- Style checkboxes inside custom or contrib forms rendered in a themed template.
- Add a pointer cursor on checkbox hover.
- Provide a design-system-consistent checkbox without writing the base CSS from scratch.
- Ship a starting-point CSS you adapt rather than a fixed widget.
- Keep native checkbox semantics/accessibility of the underlying `input` while restyling visually.
- Use jQuery (`core/jquery`) to inject the styling span at runtime, no template overrides required.
- Scope styling to specific pages by attaching the library only on those templates.
- Avoid a settings UI — styling is controlled entirely in CSS.
- Brand form elements for a marketing or campaign theme.
- Give multi-column checkbox lists a uniform appearance.
- Improve visual consistency of checkboxes in admin or front-end themes.
