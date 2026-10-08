<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Collections, schema, locking and secrets

## The `parameters_collection` config entity

Class `Drupal\parameters\Entity\ParametersCollection` (`config_prefix: collection`, so config names
are `parameters.collection.<id>`). Exported keys: `id`, `label`, `status`, `locked`, `deletable`,
`parameters`. The `parameters` key is a name-keyed sequence; each entry is a parameter plugin config
whose schema is `parameter.[type]` (typed dynamically off the entry's `type`).

- Installed by default: `parameters.collection.global.yml` — id `global`, `locked: false`,
  `deletable: false`, empty `parameters`.
- Per-bundle collections have id `<entity_type>.<bundle>` (e.g. `node.article`,
  `taxonomy_term.tags`). They are created on demand when you first save a parameter through the
  "Manage parameters" tab. `preCreate()` auto-derives a human label from the entity type / bundle.
- The entity implements `EntityWithPluginCollectionInterface`; its parameters are a
  `ParameterPluginCollection` (lazy plugin instances). `get('parameters.<name>')` returns a single
  parameter config array; `getParameter($name)` / `getParameters()` delegate to `ParameterRepository`.

## Config schema

`config/schema/parameters.schema.yml` defines `parameters.collection.*` and a `parameter_plugin`
base mapping (`name`, `label`, `description`, `type`, `weight`, `third_party_settings`) that every
type extends: `parameter.string`, `parameter.text` (text_format), `parameter.integer`,
`parameter.float`, `parameter.boolean`, `parameter.datetime`, `parameter.machine_name`,
`parameter.color`, `parameter.options`, `parameter.icon`, `parameter.secret`
(`value` = base64 ciphertext + `encoding` map), `parameter.yaml`, `parameter.http`,
`parameter.increment`, `parameter.reference`, `parameter.null`, and the derived
`parameter.bundles:*` / `parameter.fields:*` / `parameter.roles:*`. Because every value type has a
schema, collections import/export and diff correctly under standard configuration management.

## Auto-locking (availability guarantee)

Service parameter `parameters_collection.autolock` (default `true`, in `parameters.services.yml`).
The **first read** of any parameter in an unlocked collection triggers
`ParametersCollectionInterface::lockAndSave()` (see `ParameterRepository::getParameter`). Effects:

- `ParametersCollectionStorage::delete()` refuses to delete a locked collection and logs an error;
  the UI delete/lock routes 404 for locked collections.
- Locked collections still accept **new** parameters, but existing parameters cannot be removed.
- `getConfigDependencyName()` also locks on config-dependency calculation, so exported collections
  come out locked. To delete or prune one, an admin with `unlock parameters` must unlock it first
  (UI `/admin/config/parameters/{id}/unlock`), or code can call `setLocked(FALSE)->delete()`
  (which `hook_uninstall()` does for every collection).
- `lockAndSave()` guards against lock-recursion via the static `$lockSaves` map.

Set `parameters_collection.autolock: false` (override the service parameter) if you do not want
this behavior — then collections are freely deletable and parameters freely removable.

## Secret parameters and the salt

The `secret` parameter type encrypts its value with `openssl_encrypt` using
`secret_parameters.cipher_algo` (default `aes-256-gcm`) and a per-value random passphrase combined
with a site salt; the ciphertext, IV, GCM tag and a SHA-256 checksum are stored in config under
`encoding`. Reveal happens transparently on read (token/Twig/API).

Salt source order (`Secret::getSalt`): `$settings['secret_parameters.salt']` →
`secret_parameters.salt_callback` service parameter → `secret_parameters.salt` container parameter →
Drupal state `secret_parameters.salt` → `$settings['hash_salt']` → otherwise a random salt is
generated and **persisted in state** (the UI warns when the salt comes from state, since that does
not port across environments). For multi-environment deployments of encrypted secrets, set
`$settings['secret_parameters.salt'] = getenv('SECRET_PARAMETERS_SALT');` in `settings.php`.

## Language config overrides

`ParametersConfigOverrideSubscriber` listens for `language` config-override save/delete on
`parameters.collection.*` and re-fires the affected parameters' `UsageParameterInterface` change
hooks so translated overrides stay consistent.
