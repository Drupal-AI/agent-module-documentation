<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configure Views Advanced Routing

Source: `src/Plugin/views/display_extender/AdvancedRouting.php`, `src/Routing/RouteSubscriber.php`,
`config/schema/views_advanced_routing.schema.yml`.

## 1. Enable the display extender (global, once)

Go to **Structure → Views → Settings → Advanced** (route `views_ui.settings_advanced`, permission
`administer views`) and tick **Route** under *Display extenders*. Equivalent config:
`views.settings:display_extenders` must include `views_advanced_routing_route`.

## 2. Set route YAML per display

Open a View with a **page** or **feed** display; a **Route** row appears (category
`views_advanced_routing`, weight −6, just below Page settings/Access). Click it to edit three textareas
— **Defaults**, **Requirements**, **Options** — each holding YAML that mirrors the same-named section of
a `*.routing.yml` entry (top-level keys stripped, paste the values directly).

Validation (`validateOptionsForm`): each block is `Yaml::decode()`d and must be an array; then a
Symfony `new Route('<none>', $defaults, $requirements, $options)` is constructed to catch errors.

### Where it's stored

In the View config entity under the display's
`display_extenders.views_advanced_routing_route.route` = `{defaults: {...}, requirements: {...},
options: {...}}`. Schema `views.display_extender.views_advanced_routing_route` types all three as
`ignore` (free-form).

## 3. Merge at runtime

`RouteSubscriber::alterRoutes()` (an event subscriber) loops all `uses_route` Views displays, and for
any with `views_advanced_routing_route` settings, fetches the generated route
(`$collection->get($display->getRouteName())`) and applies:
`$route->addOptions(...)->addRequirements(...)->addDefaults(...)`.

## Example — attach an entity parameter converter to a tab

Path (set via the normal Views *Path* field): `node/%node/my_view`. Then in the **Options** block:

```yaml
parameters:
  node:
    type: 'entity:node'
```

Other uses: **Requirements** like `_permission: 'access content'` or a parameter regex; **Options**
like `_admin_route: TRUE`.

## Caution

The Route settings let an `administer views` user inject arbitrary route defaults/requirements/options
(including access requirements and route options) — the same power as editing a `routing.yml`. This is
a trusted-admin capability; scope the `administer views` permission accordingly.
