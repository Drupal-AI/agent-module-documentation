<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Views Advanced Routing adds a Views **display extender** that lets you set raw route `defaults`, `requirements` and `options` YAML for a View's page/feed display, giving access to Symfony/Drupal routing features Views' UI doesn't otherwise expose (parameter converters, custom requirements, etc.).

---

The module provides a `ViewsDisplayExtender` plugin (`views_advanced_routing_route`, class
`AdvancedRouting`) that you must first enable globally under **Structure → Views → Settings →
Advanced → Display extenders** (core route `views_ui.settings_advanced`, gated by `administer views`).
Once enabled, page/feed displays gain a **Route** setting in the middle column where you paste three
YAML blocks — Defaults, Requirements, Options — matching the sections of a normal `*.routing.yml`
entry (with the top-level keys stripped). The values are validated as YAML (must decode to arrays) and
test-instantiated as a Symfony `Route`, then stored in the display's `display_extenders` options
(config schema `views.display_extender.views_advanced_routing_route`, all three sub-keys typed
`ignore`). At route-build time an event subscriber (`RouteSubscriber`, extending
`RouteSubscriberBase`) iterates all route-using Views displays, reads the stored `route` settings, and
merges them onto the generated route via `$route->addDefaults()/addRequirements()/addOptions()`. This
enables things like attaching entity parameter converters to a `%node`-style path, adding custom access
requirements, or setting route options such as `_admin_route`. Configuration is per display and stored
in the View config entity; there are no permissions, Drush commands, or services of the module's own.

---

- Add an entity parameter converter (upcasting) to a Views page path (e.g. `node/%node/tab`).
- Expose a View as a local task/tab attached to an entity route.
- Set custom route `requirements` (e.g. a regex or custom access check) on a View display.
- Add route `options` such as `_admin_route: TRUE` to a Views page.
- Provide route `defaults` (extra default parameters) for a View's page/feed route.
- Use `%parameter` converter syntax where Views' `{parameter}` path syntax is insufficient.
- Attach a required parameter type without a custom module.
- Fine-tune feed display routes with options Views' UI omits.
- Wire a View into an existing entity's route hierarchy as a tab.
- Apply advanced routing consistently through exported View config.
- Prototype route behavior on a View before moving it to a custom `routing.yml`.
- Set route requirements that restrict a View page to certain parameter formats.
- Add a `_format` or content-negotiation requirement to a feed display route.
- Configure route options that change how the View page integrates with menus/tabs.
- Pass default controller arguments to a Views route without custom code.
- Keep advanced routing config in the View entity so it deploys with the View.
- Test-validate route YAML in the UI (it builds a Symfony Route before saving).
- Enable the extender site-wide once, then apply routing tweaks display-by-display.

