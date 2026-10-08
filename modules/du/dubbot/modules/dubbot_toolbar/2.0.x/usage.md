DubBot Toolbar is a small submodule of DubBot that adds an item to the Drupal admin toolbar linking to the current page's DubBot report.

---

The submodule is a thin glue shim: it depends on core `toolbar` and on `dubbot`, and implements a single `hook_toolbar()` (bridged through `Drupal\dubbot_toolbar\ToolbarHandler`, resolved via the class resolver). The handler uses the parent module's `dubbot.link_generator` service to build a report link for the current route and renders it as a `toolbar_item` (weight 125) with the `dubbot_toolbar/toolbar` CSS library. It has no configuration, no settings form, no permissions and no config schema of its own — it reuses DubBot's configuration and the `access dubbot report` / per-pane permissions. The toolbar item is cached per `user.permissions` and `url`, and is deliberately hidden on 403/404 pages and on pages that are not viewable by anonymous users (since DubBot can only crawl publicly reachable pages) or when no report link is available. Enabling it is the supported way to get the toolbar shortcut described in DubBot's README.

---

- Add a one-click DubBot report shortcut to the Drupal admin toolbar.
- Let editors open the current page's accessibility/links/spelling report from the toolbar.
- Provide report access without placing a DubBot Report block on every page.
- Give QA reviewers a persistent toolbar entry to the DubBot report while browsing the site.
- Reuse DubBot's existing permissions to control who sees the toolbar item.
- Hide the report shortcut automatically on pages anonymous users cannot see (non-crawlable).
- Keep the toolbar item off 403/404 error pages.
- Surface the report link contextually for whatever page the user is currently viewing.
- Offer a lightweight alternative to the report block for site-wide report access.
- Complement the DubBot Overview page with an in-context per-page link.
- Ship toolbar CSS styling via the `dubbot_toolbar/toolbar` library.
- Cache the toolbar item per user permissions and URL for correctness.
- Enable/disable the toolbar integration independently of the main DubBot module.
- Give administrators quick navigation to a page's governance/best-practices report.
- Add DubBot to the standard Drupal admin toolbar workflow for content teams.
