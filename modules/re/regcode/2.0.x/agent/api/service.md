<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The `registration_code` service, hooks, event, and tokens

Service id **`registration_code`** → `Drupal\regcode\RegistrationCode` (in
`src/RegistrationCode.php`), autowired. The interface `Drupal\regcode\RegistrationCodeInterface` is
aliased to the same service, so you can type-hint the interface for autowiring
(`regcode.services.yml`).

Get it: `\Drupal::service('registration_code')` or inject `RegistrationCodeInterface`.

## Data model

Codes are rows in the `regcode` table (`regcode.install` → `regcode_schema()`), returned as
`\stdClass` objects — **not** entities. Columns: `rid` (serial PK), `uid` (last redeemer, nullable),
`created`, `lastused`, `begins`, `expires` (all int timestamps, nullable), `code`
(varchar 255, **unique key**), `is_active` (int, default 1), `maxuses` (int, default 1),
`uses` (int, default 0).

## Constants (`RegistrationCodeInterface`)

- Validity codes returned by `validateCode()`/`consumeCode()` on failure:
  `VALIDITY_NOT_EXISTING = 0`, `VALIDITY_NOT_AVAILABLE = 1`, `VALIDITY_TAKEN = 2`,
  `VALIDITY_EXPIRED = 3`.
- `save()` modes: `MODE_REPLACE = 0` (delete any existing row with the same `code` first),
  `MODE_SKIP = 1` (insert only if the code does not already exist).
- `clean()` ops: `CLEAN_TRUNCATE = 1`, `CLEAN_INACTIVE = 3`, `CLEAN_EXPIRED = 4`.

## Methods

- `load(?int $id = NULL, array $conditions = []): object|false` — selects one row. If `$id` is
  non-empty it queries `rid`; otherwise it applies each `$conditions` `field => value` as an
  equality condition (e.g. `['code' => 'FOO']`). Invokes `hook_regcode_load()` on the loaded row.
  Returns the object or `FALSE`.
- `validateCode(string $regcode): int|object` — `load()`s by `trim($regcode)` on `code`, then
  returns a `VALIDITY_*` int if: the code doesn't exist; `uses >= maxuses` (and `maxuses !== '0'`)
  → `TAKEN`; `!is_active` or `begins` in the future → `NOT_AVAILABLE`; `expires` in the past →
  `EXPIRED`. Otherwise returns the code object. Read-only (does not consume).
- `consumeCode(string $regcode, string|int $uid): int|object` — calls `validateCode()`; if valid,
  increments `uses`, sets `lastused`, sets `uid`, and sets `is_active = 0` when
  `maxuses != 0 && uses >= maxuses`, then `UPDATE`s the row by `rid`. Loads the user, sets
  `$user->regcode = $code`, invokes `hook_regcode_used($code, $user)`, and dispatches
  `RegcodeUsedEvent`. Returns the code object (or the `VALIDITY_*` int from validation).
- `save(object $code, int $action = MODE_REPLACE): int|false` — requires `$code->code`; invokes
  `hook_regcode_presave()`; in `MODE_REPLACE` deletes any existing row with that `code` first; then
  inserts (`code` stored via `Html::escape()`, `maxuses` defaults to 1, `is_active` to 1) **only if
  the code doesn't already exist**. Returns the new `rid` or `FALSE`.
- `clean(int $op): int|bool` — `CLEAN_TRUNCATE` truncates the table; `CLEAN_EXPIRED` deletes rows
  with `expires < now`; `CLEAN_INACTIVE` deletes rows with `is_active = 0`.
- `generate(int $length, string $output, bool $case): string` — builds a random string from a
  character set chosen by `$output` (`alpha`, `numeric`, `alphanum`, `hexadec`; anything else is
  used literally as the charset). `$case` uppercases the result.
- `deleteAction()/activateAction()/deactivateAction(object &$object, array $context = []): void` —
  per-row delete / set `is_active` 1 / set `is_active` 0 by `rid`; wired as VBO actions in
  `regcode.views.inc`.
- `getVocabTerms(): array` — loads the taxonomy tree of the vocabulary named in
  `regcode.settings:regcode_vocabulary` (legacy/tagging helper) into `tid => name`.

## Hooks (`regcode.api.php`)

- `hook_regcode_used(object $code, UserInterface $user): void` — fired from `consumeCode()` after a
  code is redeemed. Typical place to assign a role/group based on the code.
- `hook_regcode_load(array $code): void` — alter loaded rows (keyed by `rid`); do not change the
  `rid`.
- `hook_regcode_presave(object $code): void` — fired from `save()` before insert (`rid` not yet set).

## Event / Rules

`Drupal\regcode\Event\RegcodeUsedEvent` — `const EVENT_NAME = 'regcode.code_used'`, carries the
`UserInterface` and the code object. Also declared as a Rules event
(`regcode.rules.events.yml`: label *"User has used a registration code"*, contexts `user`,
`regcode`).

## Tokens (`regcode.tokens.inc`)

Token type `regcode` with tokens `created`, `lastused`, `begins`, `expires`, `code`, `regurl`,
`is_active`, `maxuses`, `uses` (via `hook_token_info()` / `hook_tokens()`). Needs a `regcode` data
object in the token context. (Several date tokens format `created` regardless of which date token
was requested — a known quirk in the source.)
