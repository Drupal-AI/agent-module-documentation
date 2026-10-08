<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Filter mechanism: hook + MessageSquelcher service

## Hook entry point

`Drupal\error_squelch\Hook\ErrorSquelchHooks` (`src/Hook/ErrorSquelchHooks.php`),
constructed with the `error_squelch.message_squelcher` service, `config.factory`, and
`current_user` (see `error_squelch.services.yml`).

`#[Hook('preprocess_status_messages')] preprocessStatusMessages(array &$variables)`:
1. If `test_mode` is on **and** the current user has `administer error squelch`, appends a
   hardcoded `Markup::create()` status message ("Error Squelch test mode: …") to
   `$variables['message_list']['status']`. The permission gate keeps the test message from
   leaking to ordinary visitors if test mode is left on.
2. Returns early if `message_list` is empty.
3. Calls `MessageSquelcher::filter($variables['message_list'])`.

`error_squelch.module` defines the `#[LegacyHook]` procedural wrapper
`error_squelch_preprocess_status_messages()` that delegates to the OO hook — required
because core 10.3–11.0 only invokes procedural hooks; 11.1+ skips the wrapper.

## `MessageSquelcher::filter(array &$message_list): void`

`src/MessageSquelcher.php`, service `error_squelch.message_squelcher` (args:
`config.factory`, `logger.channel.error_squelch`).

- Reads `squelch_patterns` from `error_squelch.settings`; `array_filter` drops empties.
  If no patterns, returns without touching the list.
- Reads `use_regex` and `log_suppressed` flags.
- For each message type (status/warning/error) it `array_filter`s the messages, casting
  each to string (`(string) $message`). For each trimmed non-empty pattern:
  - regex mode: `@preg_match($pattern, $text) === 1` (the `@` silences invalid-pattern
    warnings, so bad regexes simply never match);
  - substring mode: `stripos($text, $pattern) !== FALSE` (case-insensitive).
  - On a match: if `log_suppressed`, logs `info` on the `error_squelch` channel with the
    type, pattern, and message text; then drops the message (`return FALSE`).
- Empty type buckets are `unset()` so the template renders nothing for them.

Filtering happens at render time only, so it covers any message added to the messenger
regardless of how/when it was queued. It does not affect Drush CLI output.

## Notes

- Suppression is display-only; the condition that produced the message is unchanged.
- Regex patterns are supplied only via the restricted settings form / Drush by an operator
  with `administer error squelch`; invalid patterns are ignored rather than erroring.
- The injected test-mode message is a static internal string, not user/remote input.
