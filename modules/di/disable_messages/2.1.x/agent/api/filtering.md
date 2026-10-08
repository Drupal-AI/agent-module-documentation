<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# disable_messages — filtering mechanism & configuring from code

The module has no services or public API classes. Filtering is procedural, in
`disable_messages.module`.

## How a message is filtered (runtime)

`disable_messages_preprocess_status_messages(&$variables)` runs when core renders messages.
If `disable_messages_enable` is truthy it passes `$variables['message_list']` through
`disable_messages_apply_filters()`, which:

1. Skips everything if the current user's uid is in `disable_messages_exclude_users`, or the
   user has `exclude from message filtering` (unless `disable_messages_ignore_exclude` is on).
2. Applies page filtering per `disable_messages_filter_by_page` against
   `disable_messages_page_filter_paths` (matched against both alias and internal path).
3. If `disable_messages_enable_permissions` is on, drops whole types (`status`/`warning`/
   `error`) the user lacks `view <type> messages` for.
4. For each remaining message: optionally `strip_tags()` (if `disable_messages_strip_html_tags`),
   collapse newlines to spaces, then `preg_match()` it against **every** pattern in
   `disable_messages_ignore_regex`; a match unsets that message.

So the array that actually filters is **`disable_messages_ignore_regex`**, never the raw
`disable_messages_ignore_patterns` textarea.

## The compile rule (critical for programmatic config)

The settings form's `submitForm()` builds `disable_messages_ignore_regex` from the textarea:
for each line it trims whitespace and produces

```
/^ . <line> . $/ . (ignore_case ? 'i' : '')
```

i.e. the pattern is anchored to a **full match** and the line is **not** escaped (so `.` is a
wildcard). Example: textarea line `Article .* has been created.` with Ignore case on becomes
`/^Article .* has been created.$/i`.

Because the runtime reads only the compiled key, `drush config:set ... disable_messages_ignore_patterns`
alone does **nothing** — you must also write the compiled `disable_messages_ignore_regex`.
Either save through the form (which compiles for you) or set both keys directly:

```bash
drush php:eval '
  $ignore_case = TRUE;                       // mirror disable_messages_ignore_case
  $suffix = $ignore_case ? "i" : "";
  $lines = ["The changes have been saved.", "Article .* has been created."];
  $regex = [];
  foreach ($lines as $l) { $regex[] = "/^" . trim($l) . "\$/" . $suffix; }
  \Drupal::configFactory()->getEditable("disable_messages.settings")
    ->set("disable_messages_enable", "1")
    ->set("disable_messages_ignore_case", $ignore_case ? "1" : "0")
    ->set("disable_messages_ignore_patterns", implode("\n", $lines))
    ->set("disable_messages_ignore_regex", $regex)
    ->save();
'
```

## Notes

- Anchoring means partial text will not match — include the full message (punctuation, and
  any HTML unless `strip_html_tags` is on). Use `.*` for the variable parts.
- Invalid PCRE is rejected by the form's `validateForm()`; a hand-written `ignore_regex`
  bypasses that check, so keep patterns valid.
