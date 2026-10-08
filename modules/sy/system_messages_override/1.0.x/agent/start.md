<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# System Messages Override (system_messages_override) — agent index

Replaces the wording of Drupal's built-in status/warning/error messages with admin-supplied text,
from a config form and without code. Version **1.0.2**, core `^10 || ^11`, no dependencies, no
config schema.

## Mechanism (read the source, confirmed)
- **Service override, not a hook.** `src/SystemMessagesOverrideServiceProvider.php` (`alter()`)
  reassigns the core `messenger` service to `SystemMessagesOverrideMessenger` and clones the original
  into a fallback service named `core_messenger`.
- **`src/SystemMessagesOverrideMessenger.php`** extends `\Drupal\Core\Messenger\Messenger` and
  overrides `addMessage()`. It reads `messages_override` (array of `{original, new}`) from
  `system_messages_override.settings` and runs `alterMessage()` on each; first match wins, then
  `parent::addMessage()` is called.
- **Three match modes** in `alterMessage()`:
  1. `TranslatableMarkup` → matched on `getUntranslatedString()`, rebuilt as
     `$this->t($new, $args, $options)` (placeholders/options preserved).
  2. object with `__toString()` → matched on rendered string, returned as `Markup::create($this->t($new))`.
  3. plain string → exact `===` match, returned verbatim.
- **Debug checkbox** logs every message's untranslated string (HTML-escaped) at debug level on the
  `system_messages_override` channel; pair with dblog to copy exact strings. Override failures are
  caught and only surfaced (via the preserved `core_messenger`) when Debug is on.

## Surface
- **Route** `system_messages_override.configurations` → `/admin/config/system/messages-override`,
  form `\Drupal\system_messages_override\Form\SystemMessagesOverrideConfigForm` (AJAX add/remove table).
- **Permission** `administer system messages override config` (`restrict access: 'TRUE'`).
- **Config** `system_messages_override.settings` (`messages_override`, `debug`). No config schema ships.
- **Services** `system_messages_override.messenger` (parent: messenger),
  `logger.channel.system_messages_override`.
- `hook_help` only; no Drush, no plugins, no submodules.

## Gotchas
1. **Match is on the exact untranslated source string.** Dynamic messages must be entered with their
   `@placeholder` tokens verbatim; a whitespace/wording mismatch = no override.
2. **A replaced message loses core's community translations** — it starts from nothing. Verify the
   translation-layer interaction before rewording on a multilingual site.
3. **Error messages carry meaning support and logs rely on** — keep enough specificity to tell which
   condition fired.

See `agent/config/override-a-message.md` for the step-by-step recipe.
