<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Alert behavior plugins

Behaviors control how an alert displays and behaves. Two parts:

1. **Drupal plugin** — a class annotated `@AlertTypeBehavior` (annotation in `src/Annotation/AlertTypeBehavior.php`), discovered by `AlertTypeBehaviorManager`. Shipped examples: Dismissable, Dismiss Timer.
2. **JavaScript plugin + library** — an `alert_types.plugin.*.js` file registered as a library, hooked into the front-end alert renderer (`alert_types.alerts.js` / `alert_types.plugins.js`).

Active alerts are delivered to the browser by the `/alerts/json` controller (`AlertServiceController::json`), which renders each entity from `AlertStorage::loadActive()` (published + `accessCheck(TRUE)`, sorted by `weight`) and returns `{id, content}` items. The JS injects them, applies behaviors, and stores dismissals in a cookie so a dismissed alert does not reappear. Because rendering is AJAX, alerts honour cache contexts and per-path visibility.

To add a behavior: create the JS plugin + library, then the `@AlertTypeBehavior` plugin, and attach it to an alert type.
