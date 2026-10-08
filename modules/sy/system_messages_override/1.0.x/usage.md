<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
System Messages Override replaces the wording of Drupal's built-in status, warning and error messages with text an administrator supplies, from a config form and without writing code.

---

The module works by swapping out core's `messenger` service. `SystemMessagesOverrideServiceProvider::alter()` reassigns the `messenger` service definition to the module's `SystemMessagesOverrideMessenger` (a subclass of `\Drupal\Core\Messenger\Messenger`) and, before doing so, clones the original definition into a new `core_messenger` service kept as a fallback. The subclass overrides `addMessage($message, $type, $repeat)`: it loads the `system_messages_override.settings` config, reads the `messages_override` array of `{original, new}` pairs, and for each pair calls `alterMessage()`, which matches three ways — a `TranslatableMarkup` is matched on its *untranslated string* and rebuilt with `$this->t($new, $args, $options)` so placeholders and options survive; any object with `__toString()` is matched on its rendered string and returned as `Markup::create($this->t($new))`; a plain string is matched by exact equality and returned as-is. The first matching pair wins (`break`) and the (possibly replaced) message is handed to `parent::addMessage()`. Each override is wrapped in try/catch so a failure logs to the `system_messages_override` channel and, only when Debug is on, surfaces an error via the preserved `core_messenger` rather than looping through the overridden one. An optional **Debug** checkbox logs every message's untranslated string (HTML-escaped) at debug level so you can copy the exact text to match — useful with the dblog module. Configuration lives at `/admin/config/system/messages-override` (route `system_messages_override.configurations`, form `SystemMessagesOverrideConfigForm`), gated by the `administer system messages override config` permission (`restrict access: 'TRUE'`); the form is an AJAX table of rows you add and remove, each with an Original and a New textarea. Two caveats: matching is on the *exact untranslated source string*, so a message with dynamic placeholders must be entered with its placeholder tokens (e.g. `Dynamic text: @number`) verbatim, and a replaced message no longer carries core's community translations — on a multilingual site verify how the override interacts with the translation layer before rewording. Version **1.0.2**, core `^10 || ^11`, no dependencies, no config schema.

---

- Rewrite an unhelpful core error message into something a visitor can act on.
- Make the post-login or post-registration status message friendlier and on-brand.
- Match built-in messages to an organisation's vocabulary and style guide.
- Reword an "Access denied" message while keeping enough specificity for support.
- Clarify a form-validation message that uses Drupal jargon.
- Soften a failure or "unexpected error" message for end users.
- Add guidance or a support link into an error message (as markup, admin-entered).
- Reword a checkout, cart or commerce status message from a config screen.
- Reword a password-reset or account notice without a `hook_form_alter`.
- Replace a dynamic message that contains placeholders, keeping the `@token` values intact.
- Support a plain-language or accessibility policy for user-facing feedback text.
- Reduce user confusion after a failed submission by rewriting the confirmation text.
- Change wording provided by a contrib module's status messages without patching it.
- Enable Debug mode to capture the exact text of an elusive message via dblog, then override it.
- Standardise inconsistent success messages across content types and forms.
- Localise brand tone for a monolingual site without using the interface-translation UI.
- Iterate on message copy with editors instead of developers, using the config form.
- Temporarily reword a message during an incident or migration, then remove the override.
- Keep a curated list of overridden messages as exportable configuration.
- Rewrite messages emitted by core workflows (moderation, comment, user) from one place.
