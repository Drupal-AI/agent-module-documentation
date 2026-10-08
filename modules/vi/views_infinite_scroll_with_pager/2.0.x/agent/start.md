<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Views Infinite Scroll With Pager (views_infinite_scroll_with_pager) — agent index

Provides one **Views pager plugin** (`infinite_scroll_with_pager`) that renders a **standard numeric
pager alongside** Views Infinite Scroll, so the display stays crawlable and usable without
JavaScript. Version **2.0.3**. Package `Views`. Core `^9 || ^10 || ^11`. License GPL-2.0-or-later.
Hard dependency: contrib **`views_infinite_scroll`** (`^2.0`). No routes, permissions, Drush, or
config page — configured per-view.

- **The pager plugin, its options/schema, the preprocess + AJAX + JS glue, and theming** →
  [plugins/pager.md](plugins/pager.md)

## What it actually is (from source)

- Plugin `InfiniteScrollWithPager` (`src/Plugin/views/pager/InfiniteScrollWithPager.php`), id
  **`infinite_scroll_with_pager`**, `theme = views_infinite_scroll_with_pager`, **extends**
  `views_infinite_scroll`'s `InfiniteScroll` pager. Adds `pager_values` options: `quantity`
  (visible links, default 9), `user_friendly_keys` (1-based labels), and `first`/`previous`/`next`/
  `last` label strings.
- `hook_preprocess_views_infinite_scroll_with_pager()` in the `.module` builds the numeric-pager
  link window (logic lifted from core's mini-pager), using `pager.manager` and `Url::fromRoute('<none>')`.
- Event subscriber `AjaxResponseSubscriber` (service `..._with_pager.ajax_subscriber`, on
  `KernelEvents::RESPONSE`): for this pager's `ViewAjaxResponse` with a `next` query param, rewrites
  `replaceWith`→`infiniteScrollPagerInsertView` (append instead of replace) and drops scrollTop.
  Rows still come from the standard Views AJAX response and its access checks.
- JS `js/infinite-scroll-with-pager.js` + Twig `templates/views-infinite-scroll-with-pager.html.twig`
  (includes `@system/pager.html.twig`). Config schema only; no config/install objects.

## Using it

Set the view's Pager to **"Infinite Scroll with Pager"** and set **Advanced → Use AJAX = Yes**.

**Theming, per README:** copy the Twig template into the theme's `templates/` and swap the include —
`{% include '@system/pager.html.twig' %}` → `{% include '@bootstrap/system/pager.html.twig' %}`.
Check after install: pager results match scroll results, and theme CSS isn't hiding the pager.
