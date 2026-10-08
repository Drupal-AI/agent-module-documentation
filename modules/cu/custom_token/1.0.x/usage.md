<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Custom Token lets you define `[custom_token:*]` tokens whose KEYS are stored in configuration (exported to the repo) while their VALUES are stored in the State API (never exported, set per environment).

---

This separates structure from environment-specific data: the same token key (e.g. `general_email`) is committed once, but dev, QA and production each hold their own value set locally. The admin form at `/admin/config/system/custom_token` (permission `administer custom token`, `restrict access: true`) manages a table of key/value rows — keys are validated to `[a-z0-9_]+`, saved to `custom_token.settings`, while values go to `\Drupal::state()->set('custom_token.tokens', ...)`. `hook_token_info()` advertises each key and `hook_tokens()` resolves it from State. A `hook_webform_handler_invoke_alter()` implementation additionally resolves `[custom_token:key]` patterns inside Webform email handler `to_mail` and `to_options` values on postSave, covering places Webform's own token processing may not reach.

Typical setup: enable the module (requires Webform), open the settings form, add token keys and per-environment values, run `drush config:export` to commit the keys, then set the real values on each environment. Uninstall cleans up the State entry. Security-wise the values are set only by holders of the restricted admin permission.
---
- Define a `general_email` token used across Webform email handlers.
- Keep token keys in config but store real email addresses per environment.
- Set a different notification address on dev vs production without config changes.
- Use `[custom_token:key]` in a Webform email To address.
- Inject an environment-specific value into a Webform email subject or body.
- Resolve tokens inside Webform `to_options` (purpose → email) mappings.
- Export token keys to the repo with `drush config:export`.
- Set token values locally with the admin form, never committing them.
- Add or remove token rows via the AJAX add/remove buttons.
- Prevent accidental leakage of production emails into config sync.
- Provide a placeholder for a support address that varies by site.
- Centralize environment constants used in outgoing mail.
- Validate token keys to a safe `[a-z0-9_]+` pattern automatically.
- Clean up State values automatically on module uninstall.
- Reset token cache/info after saving via cache tag `custom_token`.
- Preview the exact token string for each key in the admin table.
- Restrict token management to trusted admins via a restricted permission.
- Reuse the same token in multiple Webform handlers consistently.
