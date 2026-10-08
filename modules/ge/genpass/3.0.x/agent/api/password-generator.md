# genpass API — generator service, action, hooks

## Generate a password in code

Genpass decorates the core `password_generator` service (see `genpass.services.yml`:
`genpass.password_generator` `decorates: password_generator`). Just call the standard
service — you get the Genpass generator when `genpass_override_core` is `true`:

```php
$password = \Drupal::service('password_generator')->generate();     // uses genpass_length
$password = \Drupal::service('password_generator')->generate(20);   // explicit length
```

`GenpassPasswordGenerator::generate(int $length = -1)`:
- If `$length < 5`, falls back to `genpass.settings:genpass_length` (default 12).
- If `genpass_override_core` is **false**, delegates to the inner core generator (still at
  the resolved length) — so disabling the override keeps core output but keeps length control.
- Otherwise builds from four classes and guarantees **≥1 char from each**: lowercase
  (`abcdefghijkmnopqrstuvwxyz`), uppercase (`ABCDEFGHJKLMNPQRSTUVWXYZ`), digits (`23456789`),
  special (`!"#$%&'()*+,-./:;<=>?@[\]^_{}~`). Confusable chars `0 O 1 I l `` | ` are omitted.
- Minimum viable length is the number of character classes (4) or 5, whichever is greater.
  Too-short/too-small sets raise `Drupal\genpass\InvalidCharacterSetsException`.

Character sets are cached in `cache.default` under cid `genpass:character_sets`, tag
`genpass`. Invalidate the `genpass` tag (or `drush cr`) after altering them.

## Bulk action: "Set new random password"

Action plugin id **`genpass_set_random_password`** (`type: user`,
`src/Plugin/Action/UserSetRandomPassword.php`), enabled via the optional config
`system.action.genpass_set_random_password`. Select users at `/admin/people`, choose
"Set new random password" — it generates a password per user, saves the account, and shows
each new password to the operator via a status message. Access requires `edit` on the
account status field and `update` on the account.

## Hooks you can implement (`genpass.api.php`)

- `hook_genpass_character_sets_alter(array &$character_sets)` — add/remove classes used by
  the generator. Result is cached permanently under the `genpass` tag; invalidate to re-run.
  Throw `InvalidCharacterSetsException` territory if the set becomes too small.
- `hook_genpass_user_forms()` — return an array keyed by `form_id` with per-form settings
  (`genpass_mode`, `genpass_admin_mode`, `genpass_display`, `genpass_password_field`,
  `genpass_notify_item`) to apply Genpass password handling to additional user forms.
- `hook_genpass_user_forms_alter(array &$form_ids)` — adjust the set of form ids / per-form
  settings Genpass acts on (e.g. tweak mode for `user_changepass_form`).

## Validation constraint

`GenpassMode` (`src/Plugin/Validation/Constraint/`) interlocks `genpass.settings:genpass_mode`
with `user.settings:verify_mail`: with email verification on, only mode `2` (restricted) is
valid. Added to both schemas so config validation catches invalid combinations.
