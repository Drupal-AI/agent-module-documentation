<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Use a UI Patterns component as a layout

Layout plugin id form: `ui_patterns:<theme_or_module>:<component>` (e.g.
`ui_patterns:olivero:teaser`). List them:
```bash
drush php:eval 'foreach(array_keys(\Drupal::service("plugin.manager.core.layout")->getDefinitions()) as $id){ if(strpos($id,"ui_patterns:")===0) print $id."\n"; }'
```

- The component's **slots** are exposed as the layout's **regions** (place blocks/fields
  into them in Layout Builder or Display Suite).
- The component's **props** are configured in the layout settings form and stored under
  `settings.ui_patterns` (`component_id`, `variant_id`, `props`, `slots`) — same shape as
  the block/formatter surfaces (see parent `agent/configure/components.md`).
- Enable Layout Builder for a display, then choose the component layout for a section:
  `drush en layout_builder -y` and configure via the display's Layout Builder UI, or set
  the section's layout id to `ui_patterns:<component_id>` in the display config.
- Requires core `layout_discovery` (a module dependency, auto-enabled).
