<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Drupal Forge Token (drupalforge_token) — agent index

Adds one **dynamic token group `drupalforge`** to Drupal's token system. A numeric token such as
**`[drupalforge:71]`** is replaced with a `<webform-component>` custom-element tag that (client-side)
fetches and embeds the **Drupal Forge** ("starshot-quickstart") launch webform for that template id.
No settings, no permissions, no config, no dependencies. Core requirement **`8 - 11`**.
License GPL-2.0-or-later. Version 1.0.1.

- **The token it defines, its exact output, and how to use it** → [tokens/tokens.md](tokens/tokens.md)

## What it actually is

- **One hook.** `hook_tokens()` only — implemented in `src/Hook/TokenHooks.php` (`TokenHooks::tokens()`,
  a `#[Hook('tokens')]`-attributed autowired service) and bridged for legacy discovery by
  `drupalforge_token.tokens.inc` (`#[LegacyHook]` `drupalforge_token_tokens()`).
- **No `hook_token_info()`.** The tokens are *dynamic*: they are matched at replacement time, not
  registered, so they do **not** appear in a token browser. You must know the numeric template id.
- **No** routing, permissions, config objects/schema, services beyond `TokenHooks`, plugins, Drush,
  submodules, or Composer/PHP requirements. `drupalforge_token.info.yml` declares only the module.
- **One asset library:** `drupalforge_token/webform-component` = `js/webform-component.js`
  (`drupalforge_token.libraries.yml`), a `WebformComponent extends HTMLElement` custom element.

## Mechanism (from source)

- `TokenHooks::tokens()` acts only when `$type == 'drupalforge'`. For each token whose **template key
  is numeric** (`is_numeric($template)`), it builds `#type => 'html_tag'`, `#tag =>
  'webform-component'`, attributes `host => 'https://www.drupalforge.org'` and `templateid => $template`,
  attaches library `drupalforge_token/webform-component`, renders it, and stores it in `$replacements`.
- Non-numeric templates are ignored (not replaced). `host` is hard-coded; `templateid` is always the
  numeric token key. Output goes through core's `html_tag` renderer (attribute-escaped).
- The custom element (browser) fetches `https://www.drupalforge.org/form/starshot-quickstart?embed=1&template=<id>`,
  injects the returned HTML, sets a `template_<id>` cookie, and polls for app-readiness. Default
  template id is 71 (Drupal CMS) when none is supplied.

## Usage in one line

Enable the module, then put `[drupalforge:<numeric-template-id>]` (e.g. `[drupalforge:71]`) in any
markup-rendering, token-processed context. See [tokens/tokens.md](tokens/tokens.md).
