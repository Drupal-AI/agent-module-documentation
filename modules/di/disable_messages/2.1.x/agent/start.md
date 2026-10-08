<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# disable_messages — agent start

Suppresses specific Drupal status/warning/error messages from end users. You list messages
(one per line, as regular expressions) in the **"Messages to be disabled"** textarea at
**Admin → Configuration → Development → Disable messages**
(route `disable_messages.settings_form`, path `/admin/config/development/disable-messages`,
permission `administer disable messages`). A `hook_preprocess_status_messages()` filter drops
any message whose text matches. All state is one config object, `disable_messages.settings`
— no entities, plugins, services, or Drush.

Key gotcha: the textarea key `disable_messages_ignore_patterns` is the raw text you type; on
**save the form compiles** each line into `/^PATTERN$/` (+ `i` if "Ignore case") and stores
that in `disable_messages_ignore_regex`. The runtime filter matches on
`disable_messages_ignore_regex`, so setting patterns programmatically means writing **both**.

- Settings keys, the form, page/user/permission filtering, debug → [configure/settings.md](configure/settings.md)
- Suppressing patterns from code/drush (the compile rule), the filter mechanism, permissions → [api/filtering.md](api/filtering.md)
