<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Custom Token — configuring tokens

## Model
- **Keys** (structure) → Config `custom_token.settings:keys` — export with `drush config:export`, commit to repo.
- **Values** (environment data) → State `custom_token.tokens` (assoc array key→value) — never exported, set per environment.

## Admin form
`/admin/config/system/custom_token` (permission `administer custom token`). Add rows of key + value:
- Keys validated to `^[a-z0-9_]+$`, duplicates rejected, empty rows skipped.
- Save writes keys to config and values to State, then resets token info and invalidates the `custom_token` cache tag.
- After saving, run `drush config:export` to commit the keys.

## Using a token
Reference `[custom_token:<key>]` anywhere token replacement runs. Resolution:
- `hook_tokens()` (`custom_token.module`) looks up `<key>` in State and returns the raw value.
- For Webform email handlers, `hook_webform_handler_invoke_alter()` also rewrites `[custom_token:*]` inside `settings.to_mail` and each `settings.to_options[].text` on the handler's `postSave`.

## Drush / deployment flow
1. On any environment: add keys + values in the form, `drush config:export`.
2. Commit config (keys only — values stay in each site's State).
3. On other environments: `drush config:import`, then set that environment's values via the form.

## Note for agents
Keep values plain text and restrict the `administer custom token` permission (already `restrict access: true`).
