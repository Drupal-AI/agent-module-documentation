Disable Messages lets a site administrator suppress specific Drupal status/warning/error messages from being shown to end users, matching each message against full-string regular expression patterns.

---

Drupal core's messenger prints every `\Drupal::messenger()->addStatus()/addWarning()/addError()` message to the page, but many of those (e.g. "Article X has been created.") are noise for end users. Disable Messages implements `hook_preprocess_status_messages()` and filters the `message_list` before it renders. You list messages to hide in a single **"Messages to be disabled"** textarea (one per line) on the settings form at `/admin/config/development/disable-messages` (route `disable_messages.settings_form`, permission `administer disable messages`). Each line is treated as a regular expression; on save the form wraps every line as `/^PATTERN$/` (plus an `i` flag when "Ignore case" is enabled) and stores the compiled list in the config key `disable_messages_ignore_regex` — that compiled array, not the raw text, is what the runtime filter uses. Because it is anchored with `^` and `$`, a pattern must match the **whole** message; use `.*` as a wildcard (e.g. `Article .* has been created.`). It can additionally filter by page path (show/hide on listed paths, core Block-style visibility), exempt specific user IDs, strip HTML tags before matching, and — when "Enable permission checking" is on — hide entire message *types* from roles lacking the `view status/warning/error messages` permission. A debug mode dumps which messages were filtered (and why) into a hidden (or visible) div at the page bottom. All behavior lives in one config object, `disable_messages.settings`; there are no entities, plugins, services, or Drush commands.

---

- Hide the "Article X has been created." confirmation from anonymous visitors while keeping it for editors.
- Suppress a noisy third-party module's status message that end users should never see.
- Filter out every "... has been created." message with a single wildcard pattern `.* has been created.`.
- Hide "The changes have been saved." on a customer-facing profile edit form.
- Remove verbose success messages after a webform submission so the confirmation page stays clean.
- Suppress warning messages on production while still logging them, by hiding them from non-admin roles.
- Hide PHP/deprecation-style warning banners from end users on a live site.
- Filter error messages away from anonymous users but keep them visible to administrators (via the "Exclude from message filtering" permission).
- Apply message filtering only on specific pages (e.g. only on `/checkout/*`) using page-level include filtering.
- Exclude specific pages (e.g. `/admin/*`) from all message filtering so admins still see everything.
- Turn off filtering entirely for named user IDs (e.g. uid 1) via the "Users excluded from filtering" list.
- Turn off filtering for anonymous users (uid 0) while keeping it for logged-in users, or vice versa.
- Hide all status messages of a given type from a role by enabling permission checking and revoking `view <type> messages`.
- Strip HTML from messages before matching so markup differences don't break your pattern.
- Do case-insensitive suppression by enabling "Ignore case" so `article` matches `Article`.
- Debug which messages are being filtered by enabling the hidden debug div and viewing page source.
- Temporarily show the debug output visibly on a development site while tuning patterns.
- Suppress duplicate/redundant confirmation messages produced by an automated import or migration.
- Hide "You are not authorized to access this page." style messages from anonymous users.
- Quickly disable ALL filtering with one checkbox ("Enable filtering") without deleting your patterns.
- Test a regular expression's validity through the form (invalid PCRE is rejected on save).
- Keep a curated blocklist of unwanted core messages in exported config (`disable_messages.settings`) across environments.
- Reduce message clutter on kiosk/display sites where any Drupal chrome should be invisible.
- Suppress messages only for certain sections of a site by combining page-path filtering with wildcards.
