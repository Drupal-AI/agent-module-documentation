<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Canvas Override (canvas_override) — agent index

Replaces Drupal Canvas's **component tree loader**. Version **1.0.0-beta1**. Core `^11`.
Depends on `canvas:canvas`.

**Documented from source — cannot be enabled against canvas 1.8.0. Verified:**

```php
final class ComponentTreeLoader { …            // canvas 1.8.0
class CanvasOverrideComponentTreeLoader extends ComponentTreeLoader {   // canvas_override
```

```
Fatal error: Class …CanvasOverrideComponentTreeLoader cannot extend final class
Drupal\canvas\Storage\ComponentTreeLoader
```

Fatal on class load → container cannot build → site and Drush down.

**The shape: upstream sealed a class its companion extends.** `final` is a deliberate statement
that a class is not an extension point, and adding it breaks anyone extending it. **Neither
module's composer constraints prevent the pairing** — `canvas_override` does not cap `canvas`, so
composer resolves exactly this combination.

If the loader is meant to be replaceable, the mechanism is an interface plus a service alias — a
`final` class and a subclass cannot both be right.