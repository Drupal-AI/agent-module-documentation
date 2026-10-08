<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Config Plus provides developer helpers around Drupal's config entity system: a service to install a module's shipped configuration from code, a save-time check that flags config entities created without a UUID, and an install-time fix for entities missing their UUIDs.

---

Config Plus adds three code-level helpers for teams that manage Drupal configuration as code. Its
`config_plus.config_installer` service installs new configuration that a module ships (from the
module's `config/install/` and `config/optional/` directories) as if Drupal's own installer had run
it during module installation — the intended use is calling it from a `hook_update_N()` so existing
sites pick up newly added config. An event subscriber on config save watches config entities and,
when one is saved without a UUID (the tell-tale sign it was written through the config factory
instead of the config entity API), throws an exception and logs it so the developer notices. Finally,
a fix that runs on install adds missing UUIDs to config entities that lack them, heading off the
range of problems missing UUIDs cause.

It targets developers and site builders working with config-as-code. It is developer/build-time
tooling: there is no admin settings page, no route, no permission, and no runtime end-user
access-control role. The save-time check keys specifically on a missing UUID — it does not inspect
dependencies, ownership, or naming — and it runs after the save, so it alerts rather than prevents.

---

- Install a module's shipped config from a `hook_update_N()`.
- Read config from `config/install/` and `config/optional/`.
- Create config entities as Drupal's own installer would.
- Stamp `_core.default_config_hash` on installed config.
- Dependency-sort config before installing it.
- Create only config that does not already exist.
- Optionally apply `config_rewrite` rewrites when that module is present.
- Flag config entities saved without a UUID.
- Throw a ConfigException on an improperly created config entity.
- Log improper config-entity saves for the developer.
- Detect config saved via the config factory instead of the entity API.
- Fix config entities missing their UUIDs on install.
- Generate and write a UUID for a UUID-less config entity.
- Clean up stale config lookup key-value entries.
- Support config-as-code deployments.
- Operate only on config entities in the default collection.
- Provide no admin UI or settings form.
- Provide no route, permission, or Drush command.
- Play no runtime end-user access-control role.
- Work on Drupal 9, 10, and 11.
