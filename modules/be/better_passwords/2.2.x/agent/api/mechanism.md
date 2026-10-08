# How it works (mechanism)

The module is one `.module` file (no services, no classes beyond the settings form). It hooks
core's `password_confirm` render element.

## Wiring

1. `hook_element_info_alter()` appends `better_passwords_after_build` to the
   `password_confirm` element's `#after_build`.
2. `better_passwords_after_build()`:
   - Appends the active rules to `#description` ("Passwords must be at least @num characters.",
     "Passwords will be rated for their strength.") based on `length`/`strength`.
   - If `auto_generate` is set **and** the current user is authenticated **and** the form is
     `user_register_form`, it makes the password fields non-required and, for Optional (`1`),
     injects an `auto_generate_password` checkbox (id `#auto-generate-password`) that hides the
     `pass1`/`pass2` fields via `#states`; for Required (`2`) it sets `#access = FALSE` on both.
   - `array_unshift($element['#element_validate'], 'better_passwords_validate')` so this
     validator runs **before** core's.

## Validation — `better_passwords_validate()`

Reads `length`, `strength`, `auto_generate` from `better_passwords.settings` and the entered
`pass1` value.

- **Empty value + auto-generate on the register form:** generates a 64-char password with the
  core `password_generator` service and sets it on both `pass1`/`pass2`, then returns (no error).
- **Length:** if `strlen($value) < length`, adds "Passwords must be at least @num characters."
- **Strength:** if `strength` is set, runs `ZxcvbnPhp\Zxcvbn::passwordStrength($value, [name, mail])`
  — the user's name and email are passed as extra dictionary words so a password containing them
  scores lower. If `score < strength`, it walks the zxcvbn match `sequence` and emits a specific
  message per `pattern`:

  | zxcvbn pattern | message (whole password) |
  |---|---|
  | `bruteforce` | Your password is too weak |
  | `date` | Your password must not be a date |
  | `dictionary` | Your password must not match a common password |
  | `digit` | Your password must not be fully numeric |
  | `repeat` | Your password must not be repetitive |
  | `sequence` | Your password must not be sequential |
  | `spatial` | Your password must not be adjacent on the keyboard |
  | `year` | Your password must not be a year |

  (When the pattern covers only part of the password, the message names the offending substring,
  e.g. "%str is a date".)

- Any collected messages become a single `password_confirm` error: **"Please choose a stronger
  password."** followed by a `<ul>` of the specific reasons.

## zxcvbn score scale (what `strength` means)

`strength` is the minimum acceptable zxcvbn `score` (0 = trivial to crack … 4 = very strong).
Requiring `3` rejects anything zxcvbn rates 0–2. Requiring `0` disables the check.

## Things to know

- Applies to **all** `password_confirm` elements (registration, `/user/N/edit`, one-time-login
  reset) — there is no per-form toggle.
- The zxcvbn dependency is the Composer lib `bjeavons/zxcvbn-php` (in `vendor/`), not a JS
  library — checking happens server-side at validation time.
- `better_passwords_update_10001()` (in `.install`) grants `administer better passwords` to any
  role that already has `administer site configuration` on update.
