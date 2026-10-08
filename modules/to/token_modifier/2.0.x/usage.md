<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Token Modifier adds a meta token type `token-modifier` that wraps any other token and runs its resolved value through a transformation: `[token-modifier:uppercase:node:title]` uppercases the node title. Ten transformations ship (case, trim, length, strip-tags, urlencode) and sites can add more as small plugins.

---

Tokens are plain values, so getting an uppercased title or a URL-encoded field used to mean custom code. This module registers the token type `token-modifier` whose token name reads as `{modifier-id}:{the-rest-of-the-token}`. Its `hook_tokens()` splits the name on `:`, takes the first segment as the modifier plugin id, rebuilds the remainder into a normal token, instantiates the plugin from `plugin.manager.token_modifier`, and calls `transform("[inner]", $data, $options)`; the plugin resolves the inner token with the core token service and applies a PHP string operation. The ten shipped modifier ids are `urlencode`, `uppercase`, `lowercase`, `title-case`, `upper-case-first`, `length` (which takes an extra `:{n}` argument, e.g. `[token-modifier:length:8:current-user:name]`), `trim`, `ltrim`, `rtrim` and `strip-tags`. Because each modifier re-runs token replacement, modifiers chain by prepending another `token-modifier:{id}:`. Every modifier is a plugin discovered by `TokenModifierPluginManager` from an `@TokenModifier` annotation extending `TokenModifierPluginBase`, so adding one is a small class in `src/Plugin/token_modifier/`, and `hook_token_info()` advertises each (marked `dynamic`) in the Token browser. The module requires the contrib Token module and has no configuration, permissions or Drush commands.

---

- Uppercase a node title inside a Pathauto alias pattern.
- URL-encode a field value used inside a link or redirect token.
- Trim whitespace from an imported field before it is displayed.
- Strip HTML tags out of a body-summary token for a plain-text context.
- Title-case a taxonomy term name in a generated page title.
- Cap a username to the first 8 characters with `length`.
- Lowercase an email-address token for consistent storage.
- Normalise values used to build generated file names.
- Produce cleaner Metatag values from messy content fields.
- Safely compose a URL query string from token values.
- Apply a transformation without writing a custom token plugin.
- Reformat token values inside email templates.
- Standardise letter casing across generated aliases.
- Right-trim trailing separators from concatenated tokens.
- Left-trim a leading marker character off a field token.
- Add a project-specific modifier as a small `@TokenModifier` plugin.
- Chain uppercase over trim over any contrib module's token.
- Keep string-transformation logic out of Twig templates.
- Improve consistency of imported data at render time.
- Expose available modifiers to editors through the Token browser.
- Reuse one modifier across many different token contexts.
- Alter or remove a modifier definition with `hook_token_modifier_info_alter()`.
