# The `<vvjf-flipbox>` custom element, data attributes & accessibility

## The custom element

Each flipbox renders as a `<vvjf-flipbox>` custom element (`js/vvjf-flipbox-element.js`,
`class VvjfFlipboxElement extends ElementBase` from `vvj_core`'s `Drupal.Vvj` namespace, `static
patternSlug = 'vvjf'`, registered via `customElements.define('vvjf-flipbox', …)` guarded by a
`customElements.get()` check). Like the rest of the family it **lazy-hydrates** on scroll via the base
class's `IntersectionObserver`; `Drupal.behaviors.VVJFlipbox` (`js/vvjf.js`) is only a `once('vvjf-flipbox-marker', …)`
marker and does no setup. The base's `disconnectedCallback()` aborts every listener (`this.signal` /
AbortController), so the element survives AJAX/BigPipe swaps without leaks.

**There is no public `Drupal.vvjf.*` JavaScript API.** Unlike the accordion (`Drupal.vvja.openPanel(…)`
etc.), the flipbox exposes no programmatic open/close methods — flip state is internal and per-card. Drive
it by dispatching real user events (click/hover/keydown) or by toggling the `.flipped` class yourself if
you must.

## Data attributes read at hydrate

Set by `views-view-vvjf.html.twig` on the `<vvjf-flipbox>` tag; parsed in `onHydrate()`:

| Attribute | Values | Effect |
|---|---|---|
| `data-flip-trigger` | `hover` \| `click` | `hover` binds `mouseenter`/`mouseleave`; anything else (default) binds `click`. |
| `data-breakpoints` | `all` \| `576` \| `768` \| `992` \| `1200` \| `1400` | `all` → always active; otherwise flip is **active when `window.innerWidth >= value`**. Non-numeric falls back to `576`. |

## Behaviour

- **Trigger.** Click mode: click on `.flipbox-item-inner` toggles `.flipped`. Hover mode: `mouseenter`
  flips to back, `mouseleave` flips to front. Either mode: **Enter/Space** on the card flips it
  (`keydown`, `preventDefault`).
- **Viewport gating.** `_applyState()` runs at hydrate and on a **200 ms throttled** `resize`. When active
  (≥ breakpoint, or `all`): per-card listeners bind, ARIA/tabindex track the flipped state, and (in click
  mode) nested links are suppressed. When inactive (below breakpoint): listeners unbind, **both faces are
  shown**, `aria-hidden` is cleared, and every focusable descendant (`a, button, input, select, textarea,
  [tabindex]`) is made tabbable. Any in-progress flip is reset on the transition across the breakpoint.
- **Per-card listeners** are wired through a per-card `AbortController` stored in a `WeakMap` and chained to
  the host `this.signal`, so a trigger change cleanly rebinds and a disconnect tears everything down.
- **Nested-link suppression (click mode, v1 parity).** Anchors inside a face get `tabindex="-1"` +
  `data-vvjf-disabled`, and a single delegated click guard calls `preventDefault()` on clicks landing on a
  nested `.flipbox-front a` / `.flipbox-back a` while suppression is on — so a mouse click on a link inside
  a click-to-flip card flips the card instead of navigating. Suppression is lifted in hover mode and when
  the flipbox is inactive.

## Accessibility (built in, no config)

`role="region"` + a visually-hidden label on the wrapper; each face is a `role="group"` with a
visually-hidden heading. `_updateAccessibility()` keeps `aria-hidden` and `tabindex` on the two faces in
sync with `.flipped`: the hidden face gets `aria-hidden="true"` and its focusables `tabindex="-1"`; the
visible face is exposed and tabbable. Below the active breakpoint both faces are visible and tabbable so
nothing is trapped. Flip-card semantics are less standardised than tabs/accordions — the module keeps the
card keyboard-operable and reachable, but verify `prefers-reduced-motion` handling for your theme if the
rotation matters to your users.

## Libraries attached

`render()` (in `VvjStylePluginBase`) attaches `vvj_core/tokens`, `vvj_core/base`, `vvj_core/a11y`,
`vvj_core/element-base`, `vvjf/vvjf`, plus `vvjf/vvjf-style` when `enable_css`; `Flipbox::buildLibraryList()`
appends the breakpoint media library `vvjf/vvjf__<available_breakpoints>`. No external/CDN JavaScript is
loaded.
