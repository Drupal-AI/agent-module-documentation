<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Canvas Override replaces Drupal Canvas's component tree loader, so a site can change how a Canvas page's component tree is resolved.

---

Canvas stores a page as a tree of components, and `ComponentTreeLoader` is what turns stored data into that tree. Overriding it is the hook a site needs when the tree should come from somewhere else, or be transformed on the way — an inherited default layout, a per-context variation, a migration shim reading an older format.

**It cannot be enabled against Canvas 1.8.0, and this was verified.** `canvas` declares:

```php
final class ComponentTreeLoader {
```

and `canvas_override` does:

```php
class CanvasOverrideComponentTreeLoader extends ComponentTreeLoader {
```

which PHP refuses outright:

```
Fatal error: Class Drupal\canvas_override\Storage\CanvasOverrideComponentTreeLoader
cannot extend final class Drupal\canvas\Storage\ComponentTreeLoader
```

Fatal on class load — the container cannot build, so site and Drush both go down.

**This is a contrib-vs-contrib version skew of a specific kind: the upstream module sealed a class its companion extends.** `final` is a deliberate statement that a class is not an extension point, and adding it is a breaking change for anyone who was extending it. Nothing in either module's composer constraints prevents the pairing — `canvas_override` does not cap the `canvas` version it works against, so composer will resolve exactly this combination.

Check which `canvas` release the override was written for before adopting either. If Canvas intends the loader to be replaceable, an interface and a service alias is the mechanism; a `final` class and a subclass cannot both be right.

---

- Override how a Canvas component tree is loaded.
- Supply a tree from a different source.
- Transform a tree during loading.
- Apply an inherited default layout.
- Read an older stored format during migration.
- Check which canvas release the override targets.
- Diagnose a cannot-extend-final-class fatal.
- Recognise sealing as a breaking change.
- Cap the canvas version in composer.
- Ask for an interface rather than a subclass.
- Recover a site after a class-load fatal.
- Report the incompatibility upstream.
- Evaluate the module against an older canvas.
- Plan a Canvas extension strategy.
- Document the module's behaviour for the team.
- Review it during a site audit.
- Verify its assumptions after an upgrade.
