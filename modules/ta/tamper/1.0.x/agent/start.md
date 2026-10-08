# tamper — agent start

Defines the **Tamper** plugin type: each plugin takes a value, transforms it, returns a value.
Ships ~45 built-in tampers. No UI/config of its own — a developer toolkit (Feeds is the main
consumer). Manager service `plugin.manager.tamper`.

- Write a Tamper plugin + built-in plugin list → [plugins/tamper.md](plugins/tamper.md)
- Apply tampers in code (manager, item interface, exceptions, alter hook) → [api/manager.md](api/manager.md)
