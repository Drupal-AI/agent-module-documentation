<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# AJAX BigPipe (ajax_big_pipe) — agent index

Lazy-loads **blocks** (and, nominally, Views displays) into a page **after** the initial HTML, so the
shell renders immediately and the marked fragments stream in when they scroll into view. Mechanism:
you tick **"Use AJAX BigPipe"** on a block's *Visibility* tab (block visibility **condition**
`ajax_big_pipe_condition`); `hook_block_build_alter` then replaces that block's build with a
`#lazy_builder` and forces `#create_placeholder = TRUE`. The module's tagged **placeholder strategy**
service (`AjaxBigPipeStrategy`) intercepts those placeholders and rewrites each into a
`<div data-ajax-placeholder='{callback,args,token}'>` carrying a loading skeleton/spinner, attaching
the `ajax_big_pipe/ajax` JS library and a `drupalSettings.ajaxBigPipe` URL. Client JS
(`misc/ajax_big_pipe.js`) watches each placeholder with an **IntersectionObserver**; when it nears the
viewport it fires a `Drupal.ajax` GET to the module's REST endpoint **`/api/bigpipe`**, which renders
the real lazy-builder and returns AJAX commands (`ReplaceCommand`/`RemoveCommand`) that swap the
placeholder for the live content.

The real entry points are therefore: the **block visibility condition** (turn it on per block), the
**REST resource** `load_ajax_big_pipe` (route `rest.load_ajax_big_pipe.GET`, path `/api/bigpipe`), the
tagged **placeholder strategy** service, and the JS library. The endpoint is guarded by a
`hash_salt`-keyed token that binds each request to the exact `callback`+`args` the server emitted, so
callers cannot render arbitrary callbacks. A Views **display extender** (`ajax_big_pipe`) is
auto-registered at install and exposes a Status toggle, but in 1.0.8 its stored flag is not consumed
elsewhere in the module — the fully wired path is the block condition.

- Depends on: `drupal:big_pipe`, `drupal:rest` (both core). No external libraries; `composer require` is empty.
- Core: `^9 || ^10 || ^11`. Package: `Web services`.
- **No settings page / `configure` route.** Configuration is **per block** (visibility condition) and
  **per view** (display extender). Provides config schema; **no** permissions, **no** drush, defines
  **no** plugin types.

## What you'd do → where

- **Turn AJAX BigPipe on for a block, pick a loading animation / preview / trigger distance** →
  [configure/blocks.md](configure/blocks.md)
- **Enable it on a Views display (and what that flag actually does in 1.0.8)** →
  [configure/blocks.md](configure/blocks.md)
- **Understand the placeholder strategy, the `/api/bigpipe` request/response contract, the token, the
  JS flow, and the hooks — to debug or extend it** → [api/internals.md](api/internals.md)

## Key facts (real machine names)

- Services: `placeholder_strategy.ajax_big_pipe` (`Drupal\ajax_big_pipe\Render\Placeholder\AjaxBigPipeStrategy`,
  tagged `placeholder_strategy`; args `@request_stack`, `@renderer`, `@cache.data`);
  `ajax_big_pipe.lazy_block` (`Drupal\ajax_big_pipe\LazyBlockBuilder`, arg `@entity_type.manager`).
- REST resource plugin id `load_ajax_big_pipe` (`…\Plugin\rest\resource\LoadAjaxBigPipe`) → route
  `rest.load_ajax_big_pipe.GET`, path `/api/bigpipe` (GET, `json`, `cookie` auth); enabled by
  `config/install/rest.resource.load_ajax_big_pipe.yml`. `getBaseRouteRequirements()` sets
  `_access: 'TRUE'` (public; no REST permission required).
- Block visibility condition plugin id `ajax_big_pipe_condition` (`…\Plugin\Condition\AjaxBigPipeCondition`).
  Config keys: `use_ajax_big_pipe`, `use_statis_preview`, `use_preview_height` (default 200, apparently
  unused by the strategy), `use_preview_height_distance` (default 100), `use_preview_templates`
  (`default` | `views_template` | `block_template` | `banner_template` | `custom_template`),
  `use_preview_templates_custom`. Schema type `condition.plugin.ajax_big_pipe`.
- Views display extender id `ajax_big_pipe` (`…\Plugin\views\display_extender\AjaxBigPipe`),
  auto-added to `views.settings:display_extenders` in `hook_install`; option key `enabled`.
- Trusted callback: `LazyBlockBuilder::lazyBlockBuild` (declared via `trustedCallbacks()`).
- Hooks (`ajax_big_pipe.module`): `hook_help`, `hook_block_build_alter`, `hook_entity_presave`;
  (`ajax_big_pipe.install`): `hook_install`, `hook_uninstall`.
- Library `ajax_big_pipe/ajax` (`misc/ajax_big_pipe.js` + `misc/ajax_big_pipe.css`; deps
  `core/drupal`, `core/drupal.ajax`, `core/once`).
- Client markers: `drupalSettings.ajaxBigPipe` (endpoint URL), placeholder attributes
  `data-ajax-placeholder` and `data-loading-distance`; no-JS cookie `big_pipe_nojs`
  (`AjaxBigPipeStrategy::NOJS_COOKIE`) short-circuits both the strategy and the endpoint.
- Token: `AjaxBigPipeStrategy::generateToken($callback, $args)` =
  `Crypt::hashBase64(serialize([$callback, $args, Settings::get('hash_salt')]))`.
