<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Single Page Site Next Page (single_page_site_next_page) — agent index

Optional submodule of **Single Page Site**. Appends a "scroll to next page" anchor link to every
single-page section except the last. Package `Design`. Version **3.0.0**. Core `^11 || ^12`.
License GPL-2.0-or-later. Depends on **`single_page_site:single_page_site`**.

- **How the subscriber works** → [api/subscriber.md](api/subscriber.md)

## What it actually is

- No routes, no permissions, no config, no schema, no UI. One service.
- Service `single_page_site_next_page.alter_output`
  (`EventSubscriber\AlterSinglePageSiteOutput`, arg `@single_page_site.manager`, tagged
  `event_subscriber`) — subscribes to
  `SinglePageSiteEvents::SINGLE_PAGE_SITE_ALTER_OUTPUT` (`single_page_site.alter_output`).
- On each section, if it is not the last renderable menu item, appends
  `<a href="#{next-anchor}" class="to-next-page">{next title}</a>` to the section output via
  `Markup::create()`.

Enable: `drush en single_page_site_next_page -y`. It is the reference example for the parent's
alter-output extension point — see the parent's
[../../../3.0.x/agent/api/events.md](../../../3.0.x/agent/api/events.md).
