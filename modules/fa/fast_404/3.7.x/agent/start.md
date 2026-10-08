# Fast 404 (fast404) — agent index

Serves cheap, low-memory 404/410 responses for missing static files and (optionally) missing
Drupal paths, avoiding a full bootstrap. Machine name is **fast404** (project/dir is `fast_404`).

Key facts an agent needs:
- No admin UI, no `*.routing.yml`, no config entity, no permissions, no Drush, no config schema.
- Everything is configured through `$settings['fast404_*']` keys in `settings.php`
  (read at runtime via `Settings::get()`). Reference: `example.settings.fast404.php`.
- Enabling the module alone gives static-file extension checking with safe defaults; all
  other behaviour is opt-in.
- Core is a single event subscriber (`fast404.event_subscriber`) on `KernelEvents::REQUEST`
  (priority 100) and `KernelEvents::EXCEPTION`, plus a `fast404.factory` service.

Docs:
- [configure/settings.md](configure/settings.md) — every `fast404_*` settings.php key, defaults,
  the two checks (extension vs path), the optional `fast404.inc` preboot, and the services/classes
  you can reuse or override.
