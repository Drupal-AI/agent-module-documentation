<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configuration & content-type selection

## Install / enable
```
composer require drupal/bsky_post   # pulls drupal/bsky
drush en bsky_post -y
```
`bsky_post.info.yml` declares `dependencies: [bsky:bsky]` and `configure: bsky_post.settings`. Before it works, the **bsky** module must be configured with a Bluesky handle + app-password Key (bsky_post itself stores no credentials).

## Settings form — `BskyPostSettingsForm`
`src/Form/BskyPostSettingsForm.php`, form id `bsky_post_bsky_post_settings`, route `bsky_post.settings` at `/admin/config/services/bsky-post-settings`, permission `administer bsky_post configuration`.

- `buildForm()` loads all `node_type` entities via `entity_type.manager` and renders a multi-select `types` (`#multiple => TRUE`) of node-type machine names. Default is the keys of the currently stored `types`.
- `validateForm()` requires at least one content type.
- `submitForm()` writes the selection to config `bsky_post.settings` key `types`, then calls `router.builder->rebuild()` so the tab route's bundle restriction is regenerated. (Note: it stores `types[$type] = $this->types[$type]` where `$this->types` is a numeric-indexed `array_keys(...)`, so the stored map value can be null — only the keys are used downstream.)

## Config object & schema
- Config: `bsky_post.settings`, single key `types` (map of selected node bundles).
- Schema: `config/schema/bsky_post.schema.yml` — `bsky_post.settings` is a `config_object`; note the schema only declares a placeholder `example` mapping, so the real `types` key is effectively schema-loose.

## How the tab is scoped — `BskyPostRouteSubscriber`
`src/Routing/BskyPostRouteSubscriber.php` (service `bsky_post.subscriber`, `RoutingEvents::ALTER` priority -120). `alterRoutes()` reads `bsky_post.settings:types` and sets `bsky_post.tab`'s `options.parameters.node.bundle` to those types, so the `/node/{node}/bsky` tab (and its `entity.node.canonical` local task from `bsky_post.links.task.yml`) only resolves for the selected content types.

## Help
`src/Hook/BskyPostHooks.php` implements `hook_help` (via `#[Hook('help')]`, with a `#[LegacyHook]` shim in `bsky_post.module`) for `help.page.bsky_post`, summarizing dependency/config/usage.
