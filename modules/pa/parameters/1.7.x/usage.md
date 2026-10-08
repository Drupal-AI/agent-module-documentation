<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Parameters lets you define named, typed configuration values — each a "Parameter" plugin — inside exportable collection config entities, then read them anywhere through auto-generated tokens, a Twig `p()` function, ECA, or a small PHP API.

---

A parameter is a typed plugin instance (raw string, integer, float, boolean, date/time, formatted text, options, color, machine name, SVG icon, encrypted secret, nested YAML, remote-HTTP endpoint, auto-incrementing counter, referenced parameter, or a selection of entity types/bundles/fields/roles) stored as a keyed entry inside a `parameters_collection` config entity. There is one `global` collection plus one collection per fieldable entity bundle — `node.article`, `taxonomy_term.tags`, and so on. Unlike the naive "just add a key to some settings" approach, every value type ships its own config schema (`parameter.string`, `parameter.integer`, `parameter.secret`, …), so collections export, import and diff cleanly through standard configuration management and each value is validated by its plugin. Reads are contextual: `[parameter:global:max_capacity]` targets a collection explicitly, `[node:parameter:max_capacity]` resolves the current node's bundle collection and falls back to `global`, `{{ p('max_capacity', node) }}` does the same in Twig (append `'value'` to get the raw value for conditions instead of rendered markup), and `Parameter::get($name, $node)` / `Parameter::value($name, $node)` do it in PHP (add `'strict'` to throw instead of returning a null object). Collections **auto-lock** the first time any parameter is read (service parameter `parameters_collection.autolock`, default true), which blocks UI deletion so a value other code relies on cannot silently disappear until an admin with `unlock parameters` unlocks it. Managing parameters requires the `parameters_ui` submodule (adds the "Manage parameters" tab next to Field UI, the `/admin/config/parameters` listing, and the `administer parameters` / per-entity-type / per-bundle permissions); the base module alone provides the storage, plugin type, tokens, Twig and API. The `Secret` type encrypts its value (AES-256-GCM) inside config — set `$settings['secret_parameters.salt']` in `settings.php` so encrypted secrets stay portable across environments. `parameters_content`, which backs a parameter with a full content entity, is deprecated and discouraged for performance reasons.

---

- Store an API base URL or third-party endpoint as exportable configuration.
- Define a numeric threshold (max capacity, rate limit, percentage) editable by an admin without code.
- Hold a feature flag or toggle as a boolean parameter and read it in Twig with `p('flag', 'value')`.
- Keep a secret (API key, token) encrypted inside configuration with the `Secret` parameter type.
- Expose a value to a Twig template via `{{ p('name') }}` without adding a preprocess hook.
- Provide a token like `[parameter:global:support_email]` for use in emails, blocks and views.
- Give each content type its own settings (per-bundle `node.<bundle>` collections) via the Manage parameters tab.
- Fall back automatically from a content-type-specific value to a global default.
- Fetch and cache remote JSON from an HTTP endpoint and read individual keys as `[parameter:endpoint:some.nested.key]`.
- Store an SVG icon set and render icons inline with `{{ p('logo')|set_attribute('fill','#000') }}`.
- Auto-increment an integer counter (invoice numbers, sequence ids) with the `Increment` type.
- Store a formatted-text snippet (with a text format) reused across templates and blocks.
- Keep a nested YAML config blob and address its leaves as parameter properties.
- Reference another collection's parameter so one value mirrors another (`Reference` type).
- Store a selection of entity types, bundles, fields or user roles as a reusable configuration value.
- Drive ECA models with parameter values instead of hard-coded constants.
- Read a value in PHP with `Parameter::value('max_capacity', $node)` and throw on absence using `'strict'`.
- Guarantee a value's availability to dependent code via the auto-locking collection mechanism.
- Share per-environment secrets safely by pinning `secret_parameters.salt` in `settings.php`.
- Delegate management of one content type's parameters to an editor role with a per-bundle permission.
- Avoid writing a settings form class, route, schema and menu entry for a handful of values.
- Replace scattered `settings.php` constants with admin-editable, deployable configuration.
