# JavaScript API, custom element & deep linking

## The custom element

Each accordion renders as a `<vvja-accordion>` custom element (`js/vvja-accordion-element.js`,
`class VvjaAccordionElement extends ElementBase` from `vvj_core`, registered with
`customElements.define('vvja-accordion', …)`). It **lazy-hydrates itself** on scroll via
`IntersectionObserver` in `connectedCallback()`; `Drupal.behaviors.VVJAccordion` is only a `once()`
marker and does no setup. `disconnectedCallback()` aborts every event listener (AbortController), so it
survives AJAX/BigPipe page swaps without leaks.

The element carries all v1 CSS classes and `data-*` config (see [../views/theming.md](../views/theming.md)):
`data-exclusive`, `data-expand-default`, and (in deep-link mode) `data-deeplink-id` /
`data-deeplink-enabled`.

## `Drupal.vvja.*` API

Defined in `js/vvja.js`; every method delegates to the matching public method on the custom element.
The **identifier** argument is resolved by `getElement()` in this order: (1) the accordion whose
`data-deeplink-id` equals the string, (2) as a CSS selector (e.g. `#vvja-12345`), (3) an `Element` you
pass directly (its closest `<vvja-accordion>`).

| Method | Returns | Purpose |
|---|---|---|
| `Drupal.vvja.openPanel(identifier, panelIndex)` | bool | Open panel `panelIndex` (1-based). |
| `Drupal.vvja.closePanel(identifier, panelIndex)` | bool | Close panel `panelIndex`. |
| `Drupal.vvja.togglePanel(identifier, panelIndex)` | bool | Toggle panel `panelIndex`. |
| `Drupal.vvja.getOpenPanels(identifier)` | `number[]` \| `null` | Indices of currently open panels. |
| `Drupal.vvja.getTotalPanels(identifier)` | `number` \| `null` | Panel count. |
| `Drupal.vvja.getInstance(containerOrSelector)` | `Element` \| `null` | The `<vvja-accordion>` element. |

```javascript
// Open every panel of the accordion whose deeplink id is "faqs".
Drupal.behaviors.myAccordion = {
  attach(context) {
    const btn = once('open-all', '.my-open-all', context)[0];
    if (!btn) { return; }
    btn.addEventListener('click', () => {
      const total = Drupal.vvja.getTotalPanels('faqs');
      for (let i = 1; i <= total; i++) { Drupal.vvja.openPanel('faqs', i); }
    });
  },
};
```

## Deep linking

Enable **Deep Linking** and set a **URL Identifier** in the style options (`enable_deeplink` +
`deeplink_identifier`). Each panel trigger then renders as an `<a href="#accordion-<identifier>-<n>">`
instead of a `<button>`, and the wrapper gets `data-deeplink-id="<identifier>"`. Loading a page with
that fragment opens the target panel (`setTimeout(() => this.openPanel(n), 100)`); browser back/forward
is supported. The identifier is slug-normalized and cannot be a reserved word (`accordion|panel|vvja|vvj`)
— see [../views/style.md](../views/style.md).

## Accessibility (built in, no config)

Keyboard: Arrow Up/Down, Home, End move between triggers; only one trigger is in the tab order at a time.
ARIA `aria-expanded`, `aria-controls`, `aria-labelledby`, `aria-hidden` reflect state; focusable elements
inside a collapsed pane are neutralized (`tabindex="-1"`, `aria-disabled="true"`) to avoid keyboard
traps. Panel heights recompute on viewport resize. All from the shared `vvj_core` a11y/keyboard-nav/
element-base libraries attached by the style plugin.

## Libraries attached

`render()` (in `VvjStylePluginBase`) attaches `vvj_core/tokens`, `vvj_core/base`, `vvj_core/a11y`,
`vvj_core/element-base`, `vvja/vvja`, plus `vvja/vvja-style` when `enable_css`. `vvja/vvja` depends on
`core/drupal.ajax`, `core/once`, and the `vvj_core` `tokens`/`base`/`a11y`/`element-base`/`keyboard-nav`/
`deeplink-bridge` libraries. No external/CDN JavaScript is loaded.
