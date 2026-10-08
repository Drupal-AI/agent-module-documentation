<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Character Generator (charactergen) — agent index

Token-module add-on. Provides one custom token, `[charactergen:random]`, that returns a 10-character
Crockford-base32 alphanumeric string (alphabet `23456789ABCDEFGHJKLMNPQRSTUVWXYZ`), intended as an
Automatic Entity Label value. Version **1.1.0**, core `^10 || ^11`.

- **Dependency:** `token:token` (required). Pair with `auto_entitylabel` to actually apply the label.
- **No** config UI/route, permissions, services, plugins, entities, config schema, drush, or libraries.
- **Ships only** `charactergen.module` (+ README.txt, LICENSE.txt). No `src/`.

## What it provides
- `hook_token_info()` — declares token type `charactergen` and token `charactergen.random`.
- `hook_tokens()` — resolves `[charactergen:random]`; only fires when `$data['node']` is present.
- `hook_help()` — help.page.charactergen text.
- `hook_entity_type_build()` — see note in the token doc (references a class the module does not ship).

## Solution docs
- [Token: charactergen:random](tokens/random.md) — how the token is generated, when it fires, integration.

The generated string is a **labeling convenience, not a secret**: it is time-derived, not guaranteed
unique, and not intended as an unguessable identifier.
