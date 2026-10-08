<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Views Advanced Routing — agent index

A Views display extender (`views_advanced_routing_route`) that merges admin-supplied route
`defaults` / `requirements` / `options` YAML onto a page/feed display's route. Enable it globally at
Structure → Views → Settings → Advanced (`views_ui.settings_advanced`, `administer views`), then set
per display. Config stored in the View entity. No permissions/Drush/services of its own.

- **Enable the extender, the Route YAML blocks, storage, the route subscriber, examples** →
  [configure/extender.md](configure/extender.md)

Key facts:
- Plugin `AdvancedRouting` (`@ViewsDisplayExtender id="views_advanced_routing_route"`); form has three
  textareas (Defaults/Requirements/Options) validated as YAML → arrays → test `new Route(...)`.
- `RouteSubscriber::alterRoutes()` iterates `Views::getApplicableViews('uses_route')` and calls
  `addDefaults()/addRequirements()/addOptions()` with the stored `route` settings.
- Config schema `views.display_extender.views_advanced_routing_route` (defaults/requirements/options,
  each type `ignore`), stored inside the View's `display_extenders` options.
- All configuration is by trusted `administer views` admins (route settings are effectively
  code-level power — treat like editing a `routing.yml`).
