<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# CAPTCHA After — configuration & mechanism

Source: `captcha_after.module`, `src/Form/CaptchaAfterSettingsForm.php`,
`src/CaptchaAfterConstants.php`, `config/install/captcha_after.settings.yml`,
`config/schema/captcha_after.schema.yml`, `captcha_after.routing.yml`,
`captcha_after.links.menu.yml`.

## Install / enable

`drush en captcha_after` (pulls in `captcha`). No install hook, no schema/DB tables of its own — it
only reads/writes config and the CAPTCHA module's `captcha_point` third-party settings, and uses core
flood storage.

## Global defaults form

- Route `captcha_after.settings`, path `/admin/config/people/captcha_after`, title *"CAPTCHA After
  settings"*, permission **`administer CAPTCHA settings`** (defined by the CAPTCHA module, not here).
- `CaptchaAfterSettingsForm extends ConfigFormBase`, form id `captcha_after_settings`,
  editable config `captcha_after.settings`. Five `#type => number`, `#min => 0`, `#required` fields;
  each empty/zero default renders as `THRESHOLD_DISABLED` (`'0'`). `submitForm()` writes the five raw
  values straight into the config object.

## Config object `captcha_after.settings`

Install defaults (`config/install`) — all disabled:

```yaml
submit_threshold: '0'
session_submit_threshold: '0'
global_submit_threshold: '0'
flooding_threshold: '0'
global_flooding_threshold: '0'
```

Schema (`config/schema`) types every key as `string` under a `config_object`. There is a second
schema entry `captcha.captcha_point.*.third_party.captcha_after` (mapping) for the per-form overrides
stored on `captcha_point` entities, with keys `captcha_after_submit_threshold`,
`captcha_after_session_submit_threshold`, `captcha_after_global_submit_threshold`,
`captcha_after_flooding_threshold`, `captcha_after_global_flooding_threshold` (all `string`).

## Per-form overrides (third-party settings on captcha_point)

- `captcha_after_form_captcha_point_add_form_alter()` / `_edit_form_alter()` call
  `_captcha_after_delay_attempt_element()`, which adds a collapsed `captcha_after` details group with
  the same five number fields to the CAPTCHA point add/edit form (CAPTCHA module's *Form settings*
  tab). Defaults shown come from `_captcha_after_settings_from_captcha_point()`.
- `_captcha_after_form_captcha_point_entity_builder()` (registered via `#entity_builders`) saves each
  submitted value with `$captcha_point->setThirdPartySetting('captcha_after', 'captcha_after_<x>', …)`.
- Per field: `0` disables that check for the form; **empty** means "use the module default"
  (`THRESHOLD_DEFAULT = ''`); any positive integer is the count.

## Threshold resolution (`_captcha_after_settings($form_id)`)

Loads the `captcha_point` for the form id (logs a warning and returns `[]` if none). For each of the
five settings: if the per-point value equals `THRESHOLD_DEFAULT` (`''`) it is replaced by
`\Drupal::config('captcha_after.settings')->get($key)` (falling back to `THRESHOLD_DISABLED`);
otherwise the per-point value is used as-is. So per-form empty → global default → disabled.

## Constants (`CaptchaAfterConstants`, aliased `CAC`)

- `THRESHOLD_DEFAULT = ''` — "use module default".
- `THRESHOLD_DISABLED = '0'` — this check is off.
- `FLOOD_EXPIRATION = 3600` — flood window, one hour.
- `GLOBAL_FLOOD_IDENTIFIER = '_global_'` — fixed identifier for all-visitor floods.
- Event-name prefixes: `captcha_after_gft` (global flooding), `captcha_after_ft` (IP flooding),
  `captcha_after_gst` (global submit), `captcha_after_st` (IP submit), `captcha_after_sst`
  (session submit). Each concrete flood event is `<prefix>_<form['#id']>`.

## Show / hide mechanism

`hook_module_implements_alter` moves `captcha_after`'s `form_alter` to the **end** so it runs after
the CAPTCHA module. `captcha_after_form_alter()` acts only when `isset($form['captcha'])`:

1. Resolve settings; if `_captcha_after_all_settings_disabled()` (every value `'0'`), return and leave
   default CAPTCHA behavior untouched.
2. For each enabled threshold, call `$flood->isAllowed(event, threshold, 3600[, identifier])`. If any
   is already exceeded, set `$captcha_access = TRUE`. IP thresholds use the flood default identifier
   (client IP); global thresholds use `GLOBAL_FLOOD_IDENTIFIER`; session threshold uses `session_id()`
   and only when `session_status() == PHP_SESSION_ACTIVE`.
3. Stash `captcha_access`, resolved `captcha_settings`, and the event lists on `$form_state`; append
   `_captcha_after_after_build` to `#after_build` and `_captcha_after_form_validate` to `#validate`.

`_captcha_after_after_build()`: if `captcha_access === FALSE`, set the CAPTCHA element's
`#access = FALSE` (hidden). The element is located by `_captcha_after_get_captcha_element()`, which
checks `$form['captcha']`, `$form['actions']['captcha']`, `$form['buttons']['captcha']` (logs a debug
message if none — valid when a role is allowed to skip CAPTCHA). Hiding is done in `#after_build`
(not `form_alter`) so the CAPTCHA still renders correctly on a validation-error redisplay.

`_captcha_after_form_validate()`:
- Registers the "display"/flooding flood events for this submission via
  `_captcha_after_register_flood_events()`.
- If the CAPTCHA element was hidden (`#access === FALSE`), strips any `captcha_response` validation
  error (`_captcha_after_remove_captcha_validation_error()`) so a hidden CAPTCHA never blocks submit.
- If the form has other errors: registers the invalid-submit flood events, then re-checks thresholds
  with `_captcha_after_validate_captcha_access()`; if now exceeded, flips the CAPTCHA element's
  `#access = TRUE` so the challenge appears on the redisplayed form.
- If the form has **no** errors (successful submit): clears the IP-level (`captcha_after_st_<id>`) and
  session-level (`captcha_after_sst_<id>`, session-keyed) invalid-submit floods, so a legitimate user
  resets their own counter.

`_captcha_after_validate_captcha_access()` re-evaluates the same five `isAllowed()` checks (global
flooding → IP flooding → global submit → IP submit → session submit) and returns TRUE on the first
exceeded, enabled threshold.

## Operating notes

- All thresholds count within a rolling **one hour** (`FLOOD_EXPIRATION`); there is no persistent
  lockout.
- Counting and the show/hide decision are entirely server-side (Drupal flood storage keyed on IP /
  `session_id()` / global). There is no client-controllable trigger to set here.
- `flooding_threshold` / `global_flooding_threshold` count *every* submission of the form; the three
  `*_submit_threshold`s count only submissions that fail validation.
- IP-based counters rely on the request client IP as Drupal resolves it; run behind a correctly
  configured reverse-proxy/`trusted_host`/`reverse_proxy` setup so the real client IP is used.
- A form with no matching `captcha_point` produces a logged warning and no CAPTCHA-After behavior.
