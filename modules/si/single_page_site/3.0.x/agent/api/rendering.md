<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Runtime: controller, manager, sub-request rendering

## The page controller

`Controller\SinglePageSiteController::render()` (route `single_page_site.page`):

1. If `manager->getMenu()` is empty → returns a `#markup` message linking to the config form.
2. Snapshots current `messenger()->all()` messages (so per-section sub-requests don't leak status
   messages), then re-injects them after the loop.
3. `manager->getMenuChildren()` loads the configured menu tree (enabled links only, index-sorted).
4. For each item where `manager->isMenuItemRenderable($menu_item)` returns the plugin definition:
   - builds `Url::fromRoute($route_name, $route_parameters)`, takes `->toString()` and
     `->getInternalPath()`;
   - `anchor = manager->generateAnchor($href)`;
   - `render = manager->executeAndRenderSubRequest($internalPath)`; renders if it's a render array;
   - dispatches `EventSinglePageSiteAlterOutput($output, $current_item_count)` on
     `SinglePageSiteEvents::SINGLE_PAGE_SITE_ALTER_OUTPUT` and takes `$event->getOutput()`;
   - pushes `['output' => …, 'anchor' => …, 'title' => $menu_item->link->getTitle(), 'tag' => manager->getTitleTag()]`.
5. Builds `['#theme' => 'single_page_site', '#items' => $items]`, attaches library
   `single_page_site/single_page_site.scrollspy` (plus `…/single_page_site.scroll` when
   `getSmoothScrolling()`), and sets `drupalSettings.singlePage` from
   `menuClass / distanceUp / distanceDown / updateHash / offsetSelector`.

`setTitle()` returns `manager->getPageTitle()` (config `title`, else "Single page site").

## The manager service (`single_page_site.manager`)

`Manager\SinglePageSiteManager` (constructor args: `http_kernel`, `config.factory`,
`event_dispatcher`, `controller_resolver`, `menu.link_tree`, `language_manager`, `module_handler`,
`http_kernel.controller.argument_resolver`). Config is read once from `single_page_site.config`.

- **Config getters:** `getPageTitle`, `getTitleTag` (`tag`), `getMenu` (`menu`), `getMenuClass`
  (`menuclass`), `getMenuItemClass` (`class`), `getDistanceUp`/`getDistanceDown` (`up`/`down`),
  `updateHash` (`updatehash`), `getOffsetSelector` (`offsetselector`), `getSmoothScrolling`
  (`smoothscrolling`).
- **`getMenuChildren()`** — `MenuTreeParameters()->onlyEnabledLinks()`, `menuTree->load(menu, …)`,
  then transform with `menu.default_tree_manipulators:generateIndexAndSort`.
- **`isMenuItemRenderable(MenuLinkTreeElement)`** — returns the plugin definition (truthy) or
  `FALSE`. Skips `<front>` and disabled links. If `class` is empty → include all. Otherwise, only
  when `link_attributes` is enabled and the link's `options.attributes.class` **contains**
  (`strpos`) the configured selector.
- **`generateAnchor($url)`** — if `filterurlprefix` is on, strips the current language's URL prefix
  (read from `language.negotiation` `url`, prefix mode only). Then `substr($url, 1)` and
  `str_replace(['/', '?q='], ['_', ''], …)` → the anchor id. The JS in `js/single-page-site-menu.js`
  computes the same anchor from each link's href so menu links and section ids match.
- **`executeAndRenderSubRequest($href)`** — the core mechanism. Creates a `Request::create($href,
  'GET')` as `HttpKernelInterface::SUB_REQUEST`, dispatches `KernelEvents::REQUEST`. If a listener
  already produced a response (e.g. redirect), dispatches RESPONSE + FINISH_REQUEST and returns it.
  Otherwise resolves the controller (`controller_resolver->getController`, throws
  `NotFoundHttpException` if none), dispatches `KernelEvents::CONTROLLER`, resolves arguments
  (`argument_resolver->getArguments`), calls the controller, and unsets
  `$build['#attached']['html_head_link']` (drops the sub-page's canonical/meta links). Because the
  REQUEST dispatch runs core routing/access as the **current user**, each section is access-checked
  like a normal page view — the page never renders content the viewer couldn't otherwise reach.

## Template & client behaviour

- `templates/single-page-site.html.twig` wraps items in `#single-page-overall-wrapper` (id is
  load-bearing — the JS keys on it); each item is a `.single-page-wrapper` with
  `<{{item.tag}} class="single-page-title">{{item.title}}</…>` then `<div>{{item.output}}</div>`.
  Twig autoescapes `title`; `tag` is char-whitelisted by the form; `output` is an already-rendered
  Markup string.
- `js/single-page-site-menu.js` (`Drupal.behaviors.singlePageMenu`, library `.menu`, attached on
  **every** page via `hook_page_attachments`) rewrites each menu link's `href` to `#anchor`
  (computed the same way as `generateAnchor`), removes items with class `hide` from the DOM, and
  toggles a `fixed` class on the menu when it scrolls off-screen.
- `js/single-page-site-scrollspy.js` (library `.scrollspy`, uses bundled
  `js/lib/jquery.scrollspy.js` + `.jquery_compat` shim for jQuery 4) adds `active` to the matching
  menu link as sections enter/leave, and `pushState`s the fragment when `updateHash` ≠ 0.
- `js/single-page-site-scroll.js` (library `.scroll`, only when `smoothscrolling`) animates jumps to
  `#anchor` targets, honouring `offsetSelector` height.
- `js/jquery-compat.js` re-adds `$.isFunction`/`.bind`/`.unbind` removed in jQuery 4 so the vendored
  scrollspy keeps working.
