<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The next-page event subscriber

`EventSubscriber\AlterSinglePageSiteOutput` (service
`single_page_site_next_page.alter_output`, tagged `event_subscriber`, constructor arg
`@single_page_site.manager`).

## Subscribed event

`getSubscribedEvents()` → `SinglePageSiteEvents::SINGLE_PAGE_SITE_ALTER_OUTPUT`
(`single_page_site.alter_output`) handled by `alterOutput()`.

## Build-time item list

The constructor calls `setSinglePageItems()`, a `drupal_static`-cached method that loads the same
renderable menu items the parent controller uses:
`manager->getMenuChildren()` filtered through `manager->isMenuItemRenderable()`, collecting each
item's plugin definition into `$this->menuItems` (a 0-indexed array in menu order).

## alterOutput()

```
$current_item = $event->getCurrentItemCount();   // 1-based
if ($current_item < count($this->menuItems)) {
  $menu_item = $this->menuItems[$current_item];   // the NEXT item (0-based index == current 1-based)
  $href   = Url::fromRoute($menu_item['route_name'], $menu_item['route_parameters'])->toString();
  $anchor = $this->manager->generateAnchor($href);
  $link   = '<a href="#' . $anchor . '" class="to-next-page">' . $menu_item['title'] . '</a>';
  $event->setOutput(Markup::create($event->getOutput() . $link));
}
```

- The link is skipped on the last section (`$current_item == count`).
- The anchor is produced by the parent manager's `generateAnchor()`, so it matches the section id
  the parent controller emitted.
- `$menu_item['title']` is the menu link title (an administrator-controlled value set via
  `menu_link_content`). The class hook is `to-next-page`; style it in your theme.
- The result is wrapped in `Drupal\Core\Render\Markup::create()` and handed back through
  `setOutput()`. A source comment notes the author would prefer a fragment-only rendered link but
  falls back to a raw `<a>` string.

No configuration, permissions, or additional services. Uninstalling the submodule simply removes
the subscriber; the parent module's page renders unchanged.
