<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Yunke help is a developer study/debugging helper that exposes a suite of Drupal introspection and maintenance endpoints under `/yunke-help/*`, all gated by a single `yunke help` permission.

---

It is aimed at developers learning Drupal internals: routes dump the service container (static and runtime), event-dispatcher listeners, theme registry, plugin data, entity/field/schema definitions, route lookups, and YAML encode/decode; a set of forms explore fields, hooks, menu trees and multistep-form patterns. Maintenance routes truncate every `cache_*` table, clear compiled Twig templates, rebuild routes/theme registry, delete unused managed files, rotate the cron key, and show `phpinfo()`. A "reset password" route lets the current logged-in user set a new password for their own account without entering the old one.

Operationally this is a powerful debugging toolbox that should never be enabled on production. Several controllers `echo … die`, skipping the render pipeline. Grant `yunke help` to trusted developers only and keep the module out of production.
---
- Enable only on local/dev sites for studying Drupal internals.
- Grant `yunke help` to trusted developers exclusively.
- Open `/yunke-help` for the index of available developer tools.
- View `phpinfo()` output at `/yunke-help/phpinfo`.
- Dump the compiled service container definition at `/yunke-help/container`.
- Dump the runtime container parameters, aliases and service definitions at `/yunke-help/container-run`.
- Inspect event-dispatcher listeners and priorities at `/yunke-help/event`.
- Print the theme hook registry at `/yunke-help/theme-registry`.
- Truncate every `cache_*` table at `/yunke-help/cache-clean`.
- Delete compiled Twig template caches at `/yunke-help/twig-clean-cache`.
- Garbage-collect stale Twig caches at `/yunke-help/twig-cache-garbage-collection`.
- Rebuild all routes or the theme registry via `/yunke-help/op/{type}`.
- Rotate the external cron key via the op route `cron-key`.
- Delete unused managed files via the op route `delete-unused-managed-file`.
- Look up the file that defines a class at `/yunke-help/class-path`.
- Encode or decode YAML at `/yunke-help/yaml/encode` and `/yunke-help/yaml/decode`.
- Explore entity, field, schema and base-field definitions via the bundled forms.
- Inspect plugin manager data at `/yunke-help/plugin`.
- Resolve a route by name or by path with the route lookup forms.
- Reset the current user's own password (no old password needed) at `/yunke-help/rest-password`.
