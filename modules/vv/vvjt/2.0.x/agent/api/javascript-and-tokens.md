<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Public JS API, deep linking, and Views tokens

## JavaScript API — `Drupal.vvjt.*`
Exposed by `js/vvjt.js` (behavior `Drupal.behaviors.VVJTabs`). Each method accepts a
target that is the deep-link identifier, a CSS selector, or an `Element` reference,
resolving to a `<vvjt-tabs>` custom element (defined in `js/vvjt-tabs-element.js`,
extending `Drupal.Vvj.ElementBase` from `vvj_core`).

```js
Drupal.vvjt.goToTab('features', 3);       // activate tab 3 (1-indexed) → boolean
Drupal.vvjt.getCurrentTab('features');    // → number (1-indexed) | null
Drupal.vvjt.getTotalTabs('features');     // → number | null
Drupal.vvjt.getInstance('#vvjt-12345');   // → <vvjt-tabs> element | null
Drupal.vvjt.getAllInstances();            // → <vvjt-tabs>[] (array)
```

Target resolution (`getElement`): an `Element` resolves to its closest `<vvjt-tabs>`;
a string is first matched as a deep-link id
(`vvjt-tabs .vvjt-inner[data-deeplink-id="…"]`), then falls back to a plain
`document.querySelector`. The element's own methods (`goToTab`, `getCurrentTab`,
`getTotalTabs`) mirror the shim. Plugin id `views_vvjt`, theme hook `views_view_vvjt`,
library names (`vvjt`, `vvjt-style`, `vvjt-horizontal`, `vvjt-vertical`, `vvjt-admin`,
`vvjt__576/768/992/1200/1400`), behavior key `Drupal.behaviors.VVJTabs`, and all CSS
classes are preserved verbatim from 1.x (outer tag changed `<div>` → `<vvjt-tabs>`;
`.vvjt` selectors still match).

## Keyboard & behavior
`<vvjt-tabs>` implements the W3C ARIA APG tab pattern: ArrowLeft/ArrowRight (tabs are
horizontally navigable even when displayed vertically), Home/End, Enter/Space; arrow
navigation uses **automatic activation** (focus moves and the tab activates). On tab
switch it re-runs `Drupal.attachBehaviors` on the newly visible pane so nested Views /
field-group tabs wake up. Hydration is lazy (IntersectionObserver, via `ElementBase`);
listeners are AbortController-tracked; tab swaps are wrapped in a View Transition with
graceful fallback. Nested `<a>` inside a tab button have their `href` stripped (saved to
`data-original-href`) so clicking the label switches the tab rather than navigating.

## Deep linking
When `enable_deeplink` is on and an identifier is set, the template stamps
`data-deeplink-enabled="true"` / `data-deeplink-id="{identifier}"` on `.vvjt-inner` and
buttons become `<a href="#tabs-{identifier}-{n}">`. `vvj_core`'s
`Drupal.Vvj.wireDeeplink(this, 'tabs', id, signal, onMatch)` listens for `hashchange`
and on load: it reads `window.location.hash`, checks the `#tabs-{id}-` prefix, and
`Number.parseInt`s the trailing segment to a **numeric** panel index used to look up the
button — the hash value is never written to `innerHTML` or used as a selector.
`writeDeeplinkHash('tabs', id, n)` updates the hash via `history.replaceState` (no scroll
jump) when a tab is activated.

## Views tokens — `[vvjt:FIELD]`
Provided by `Drupal\vvjt\Hook\VvjtTokenHooks` (`hook_token_info` / `hook_tokens`),
delegating to the shared `vvj_core.token_resolver` service. Usable in a View's header,
footer, or empty text **only** when *Use replacement tokens from the first row* is on.
Standard Twig tokens (`{{ title }}`) do not work in those areas — use VVJT tokens:

- `[vvjt:FIELD_NAME]` — rendered HTML of that field from the **first row**.
- `[vvjt:FIELD_NAME:plain]` — plain-text variant (HTML stripped).

Example: `{{ title }}` → `[vvjt:title]`; `{{ field_image }}` → `[vvjt:field_image]`;
`{{ body }}` → `[vvjt:body:plain]`. Values come from the first rendered row only; complex
field rewrites are unsupported. The token type declares `needs-data: view`; the `vvjt`
hook returns nothing (safe no-op) if `vvj_core`'s token resolver is not yet available
(nullable service, 1.x→2.x upgrade window).
