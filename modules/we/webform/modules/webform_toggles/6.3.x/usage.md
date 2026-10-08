Webform Toggles is a legacy client-side asset (a single `webform_toggles.element.js` behavior wrapping the jQuery Toggles plugin) for rendering checkbox-style inputs as sliding on/off toggle switches. In webform 6.3.x it is not a real installable submodule — the directory contains only the JS file and has no `.info.yml`.

---

The `modules/webform_toggles/` directory ships one file, `js/webform_toggles.element.js`, which defines a `Drupal.behaviors.webformToggle` behavior that upgrades matching elements into UI toggle switches using the third-party jQuery Toggles library (`$.fn.toggles`). Because there is no `webform_toggles.info.yml`, Drupal cannot enable it as a module, and it exposes no PHP, routes, permissions, config, services, or plugins. It is a historical remnant of the earlier "toggle" element styling; current Webform styles toggle-like inputs through core Webform's own CSS/JS. Treat this entry as a stub for completeness rather than a functional submodule.

---

- (Legacy) Render a boolean/checkbox input as a sliding on/off toggle switch via jQuery Toggles.
- Historical reference only: the folder has no `.info.yml`, so it is not installable as a module.
- No configuration, permissions, routes, services, or plugins are provided.
