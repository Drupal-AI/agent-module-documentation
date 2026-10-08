<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Recipe: override a core message

## Prerequisites
- Module enabled; the current user (or role) has `administer system messages override config`.
- To capture exact strings, enable core **dblog** (Database Logging).

## Steps
1. Go to `/admin/config/system/messages-override` (route `system_messages_override.configurations`).
2. (Optional) Tick **Debug** and Save. Trigger the message on the site, then read Reports → Recent
   log messages: the module logs the message's *untranslated source string* on the
   `system_messages_override` channel. Copy that string exactly.
3. Click **Add Message Override** (AJAX adds a row).
4. **Original** = the exact untranslated source string. For dynamic messages, include the placeholder
   tokens verbatim, e.g. `Dynamic text: @number` — not the rendered value.
5. **New** = the replacement text. It is passed through `t()`, so `@`/`%`/`:` placeholders present in
   the original are re-substituted; the values come from the original message's arguments.
6. Save. The next time core (or any module) calls `addMessage()` with a message whose source string
   matches Original, visitors see New instead.

## Matching semantics (from `SystemMessagesOverrideMessenger::alterMessage`)
- `TranslatableMarkup`: matched on `getUntranslatedString()`; rebuilt with the original `$args` and
  `$options`, so placeholders keep their real values.
- `Stringable`/`Markup`: matched on the rendered string; returned as markup.
- plain `string`: exact `===` match.
- First matching row wins; order in the table therefore matters if two Originals could both match.

## Verify (read-only)
- `drush cget system_messages_override.settings` shows the stored `messages_override` list and `debug`.
- Trigger the message (e.g. submit a form) and confirm the new wording renders.

## Notes
- No config schema ships, so config export works but strict schema checking is not enforced.
- Removing a row and saving restores core's original wording for that message.
- The permission is `restrict access: 'TRUE'` — grant it only to trusted administrators.
