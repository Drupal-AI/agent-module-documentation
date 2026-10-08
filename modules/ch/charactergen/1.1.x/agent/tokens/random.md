<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Token: `[charactergen:random]`

Everything the module does lives in `charactergen.module`. There is no `src/`, no config, no route.

## Install / enable
1. Requires the Token module (`dependencies: token:token` in `charactergen.info.yml`).
2. `drush en charactergen` (enables `token` too). No configuration screen — works out of the box.
3. To use it as a node title, also enable `auto_entitylabel` and set the pattern to `[charactergen:random]`.

## Declaration (`charactergen_token_info()`)
- Registers token **type** `charactergen` (label "Character Generator").
- Registers token `charactergen.random` (label "Random 10-characters"): "Generates a 10-character
  alphanumeric string."

## Resolution (`charactergen_tokens($type, $tokens, $data, $options, $bubbleable_metadata)`)
Runs only when `$type === 'charactergen'` **and** `!empty($data['node'])`. So the token resolves only
in a node context; without a node in `$data` it yields nothing. (The node value itself is not read —
its presence is only a gate.)

Algorithm for `random`:
- Alphabet `$cbase32 = "23456789ABCDEFGHJKLMNPQRSTUVWXYZ"` (32 chars; omits `0 1 I O` to avoid
  visual ambiguity — Crockford-style base32).
- `getdate()` gives the current date/time.
- `$nMilliSeconds = (hours*3600 + minutes*60 + seconds)*1000 + rand(0, 100)` — time-of-day in ms plus
  a 0–100 offset.
- `$ndays = (yday + 1) + (year % 100) * 367` — day-of-year combined with 2-digit year.
- First loop base32-encodes `$nMilliSeconds` into the **last 6** characters (loop runs while
  `count <= 5`).
- Second loop base32-encodes `$ndays` and prepends the **first 4** characters (loop runs while
  `count <= 3`).
- Result is a 10-character string assigned to `$replacements[$original]`.

Character composition is therefore mostly deterministic from the current date and time; the only
non-time input is `rand(0, 100)`. The value is a compact reference/label code, not a unique key —
there is no duplicate check (the maintainer lists this as a to-do).

## `hook_entity_type_build()` note
`charactergen_entity_type_build()` iterates entity types and, for any whose entity class
`entityClassImplements(TokenEntityMapperInterface::class)`, sets the `token` handler to
`Drupal\charactergen\TokenEntityMapper`. That class is **not shipped** by this module (no `src/`
directory exists). In practice entity classes do not implement `TokenEntityMapperInterface` (it is a
service interface from the Token module, `Drupal\token\TokenEntityMapperInterface`), so the condition
is not satisfied for normal entities and the missing-class handler is not assigned. Treat this hook as
inert/dead code rather than active behavior.

## Operating notes
- Use in an Automatic Entity Label pattern, optionally with prefixes: `REF-[charactergen:random]`.
- Preview via the Token browser UI (provided by the Token module).
- Because output is time-derived, do not rely on it for uniqueness or unpredictability.
