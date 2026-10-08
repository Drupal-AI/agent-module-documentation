<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configuring token defaults

## Enable the feature
`token_default.settings` holds two keys (Settings form at
`/admin/config/search/token_default/settings`):

- **`enabled`** (bool, default `TRUE`) — master switch. When `FALSE`,
  `token_default_tokens_alter()` returns immediately and no defaults are applied.
- **`recursive_limit`** (int, default `5`) — how many times a replacement that itself
  contains tokens may be re-resolved before the module gives up and logs
  `Only @count recursive replacements processed to prevent endless loop`.

Drush: `drush cget token_default.settings`, `drush cset token_default.settings enabled 1`.

## Add a default (config entity `token_default_token`)
List/manage at `/admin/config/search/token_default` (permission
`administer token defaults`). Each default is a `token_default_token` config entity with
exported fields:

| Field | Meaning |
|-------|---------|
| `id` | machine name |
| `label` | admin label |
| `type` | owning entity type — **hard-coded to `node`** by the add/edit form (hidden field) |
| `bundle` | node content type to scope to; **empty = applies to any bundle** |
| `pattern` | the token that is being defaulted, e.g. `[node:field_summary]` |
| `replacement` | the string (or token) to substitute when `pattern` resolves to nothing |

Because `type` is hidden and fixed to `node`, the UI only creates defaults for node
tokens. The runtime manager (`TokenDefaultManager`) is entity-type agnostic — it matches
on `loadByProperties(['type' => $entity->getEntityTypeId(), 'pattern' => $token])` — so
config imported directly with another `type` would also work, but there is no UI for it.

## How a default is chosen at runtime
1. Core replaces tokens; `token_default_tokens_alter()` runs afterwards.
2. Missing tokens = requested (`$context['tokens']`) minus already-replaced.
3. The subject entity is taken from `$context['data']['entity']`, else
   `$context['data'][$context['data']['token_type']]`.
4. For each missing token, matching `token_default_token` entities are loaded by entity
   type + `pattern`; a match applies when its `bundle` is empty or equals the entity's
   bundle. Its `replacement` becomes the token value.
5. Each injected replacement is re-scanned; if it still contains tokens they are resolved
   with `Drupal::token()->replace()`, up to `recursive_limit`.

## Practical notes
- Keep the **last link of any chain a literal string** — a fallback that is itself a token
  can also resolve to nothing.
- A default only fires when the token is genuinely **missing**; it does not override a token
  that already produced a value (including an intentional empty string that core returned as
  a real replacement).
- `pattern` is not validated to be a single valid token (README known issue); enter one
  exact token string.
- There is no context restriction (README known issue) — a default applies to every
  consumer of that token (metatag, pathauto, mail, etc.), not just one.
