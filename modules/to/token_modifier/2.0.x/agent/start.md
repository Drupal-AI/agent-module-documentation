<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Token Modifier (token_modifier) — agent index

Adds a meta token type **`token-modifier`** that wraps any other token and runs its
resolved value through a transformation (uppercase, trim, strip-tags, urlencode, …).
Transformations are plugins of a `token_modifier` plugin type, so sites can add their own.
Depends on contrib **token**. No settings page, no permissions, no config schema, no Drush.

Basic form: `[token-modifier:{modifier-id}:{original-token}]`
e.g. `[token-modifier:uppercase:node:title]`, `[token-modifier:urlencode:current-user:name]`.

Do / find it here:
- **Modifier syntax, the 10 shipped modifier ids, chaining, and writing your own modifier** → [plugins/token-modifier.md](plugins/token-modifier.md)
- **How it plugs into the Token system (hook_token_info / hook_tokens dispatch, the alter hook, runtime trace)** → [hooks/token-integration.md](hooks/token-integration.md)
- **The plugin-manager service, the transform() contract, and the base class** → [api/services.md](api/services.md)

Key facts:
- Token **type**: `token-modifier` (hyphen). Every modifier is a token of that type keyed by its
  plugin id, registered `dynamic => TRUE` so it appears in the Token browser.
- **Shipped modifier ids** (in `src/Plugin/token_modifier/`): `urlencode`, `uppercase`,
  `lowercase`, `title-case`, `upper-case-first`, `length`, `trim`, `ltrim`, `rtrim`, `strip-tags`.
  Note the real id is `upper-case-first` (not `uppercase-first`), and there is **no** `sentence-case`
  modifier despite the README mentioning one.
- `length` takes an extra numeric argument before the token:
  `[token-modifier:length:{n}:{token}]` e.g. `[token-modifier:length:8:current-user:name]`.
- **Plugin type** `token_modifier`: manager service `plugin.manager.token_modifier`
  (`Drupal\token_modifier\Plugin\TokenModifierPluginManager`), annotation `@TokenModifier`
  (`src/Annotation/TokenModifier.php`), interface `TokenModifierInterface`, base class
  `TokenModifierPluginBase`, plugin dir `Plugin/token_modifier/`, alter hook
  `hook_token_modifier_info_alter`.
- Module file `token_modifier.module` implements `hook_token_info()` + `hook_tokens()`; the only
  service is the plugin manager (`token_modifier.services.yml`).
- `core_version_requirement: '>=8'`; documented release 2.0.6.
