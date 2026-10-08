<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Ignition Error Handler (ignition) — agent index

Replaces Drupal's error page with **spatie/ignition** — a readable stack trace, source excerpts,
request context, and (distinctively) **suggested solutions** for the error. It works by subscribing
to the kernel `EXCEPTION` event at very low priority (`-255`): `ErrorHandlerSubscriber` renders the
Ignition HTML and sets it as the response, otherwise it does nothing and Drupal's normal handler
runs. A configured `Spatie\Ignition\Ignition` instance is built by `IgnitionFactory::make()` (wired
as the `ignition.ignition` service via a factory) with `applicationPath(DRUPAL_ROOT)`, the site theme
config, and all registered solution providers. The module is a **development tool** (`package:
Development`) — the module's own README states it should not be enabled on a production website.

- Depends on: nothing (info.yml `dependencies` empty). Uses core `user` (`user.data`) and `session`.
- Composer libs: `spatie/ignition:^1.5`, `openai-php/client` (for the optional AI provider).
- Core: `^10 || ^11`. Package: `Development`. Version `1.0.4`.
- Settings page / `configure` route: **yes** — `ignition.settings` at
  `/admin/config/development/ignition` (perm `administer site configuration`).
- Permission: **`view ignition error page`** — decides who sees the Ignition page on an error.
- Drush: none. Config schema: yes (`ignition.settings`). Plugin types: none (solution providers are
  registered as **tagged services**, not a Drupal plugin type).

## What you'd do → where

- **Enable/disable it, dark mode, the required error level, the OpenAI provider, config keys** →
  [configure/settings.md](configure/settings.md)
- **The exact conditions under which the error page renders (the four-part gate)** →
  [configure/settings.md](configure/settings.md)
- **Register a custom solution provider; the services, factory, routes and subscriber** →
  [api/services-and-solutions.md](api/services-and-solutions.md)

## Key facts (real machine names)

- Routes: `ignition.settings` (`/admin/config/development/ignition`, form
  `Drupal\ignition\Form\IgnitionSettingsForm`, perm `administer site configuration`);
  `ignition.update_config` (`/_ignition/update-config`, POST, `_format: json`, perm
  `view ignition error page`, controller `Drupal\ignition\Controller\UpdateConfigController`) — stores
  the per-user Ignition display preferences (theme/editor) picked from the error page's cog menu.
- Permission: `view ignition error page`.
- Config object: `ignition.settings` — keys `enabled` (bool), `dark_mode` (bool),
  `store_settings_file` (bool), `open_ai` (bool), `open_ai_key` (string).
- Services: `ignition.subscriber` (`ErrorHandlerSubscriber`), `ignition.ignition_factory`
  (`IgnitionFactory`), `ignition.ignition` (factory → `Spatie\Ignition\Ignition`),
  `ignition.solution_provider.collector` (`SolutionProviderCollector`, service_collector on tag
  `ignition_solution_provider`), `ignition.file_config_manager` (`Spatie\…\FileConfigManager`),
  `ignition.cache.open_ai_solution` (`Cache\SimpleCacheBridge`) over cache bin `open_ai_solution`.
- Bundled solution providers (tag `ignition_solution_provider`): `ignition.open_ai.solution_provider`
  (`OpenAISolutionProvider`, priority -1), `ignition.mysql_read_committed.solution_provider`,
  `ignition.permissions_must_exist.solution_provider`,
  `ignition.entity_query_access_check.solution_provider`.
- Event: `KernelEvents::EXCEPTION` at priority `-255` (`ErrorHandlerSubscriber::onKernelException`).
- Menu link: `ignition.settings` under `system.admin_config_development`. Hook: `hook_help`.
