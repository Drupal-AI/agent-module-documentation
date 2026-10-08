<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The `myemma` Webform handler

`WebformMyEmmaHandler` — `src/Plugin/WebformHandler/WebformMyEmmaHandler.php`.
Extends `Drupal\webform\Plugin\WebformHandlerBase`.

## Plugin definition

```
@WebformHandler(
  id = "myemma",
  label = "MyEmma",
  category = "MyEmma",
  description = "Sends a form submission to a MyEmma group.",
  cardinality = CARDINALITY_UNLIMITED,
  results = RESULTS_PROCESSED,
)
```

Unlimited cardinality means multiple MyEmma handlers can be added to one webform.

## Services (via `create()`)

- `$logger` = `logger.factory` channel `webform_myemma`.
- `$emmaConfig` = read-only `config.factory->get('webform_myemma.settings')`.
- `$tokenManager` = `webform.token_manager`.

## Per-instance configuration

`defaultConfiguration()` keys: `account_name`, `email`, `group_id`, `fields` (array).
`buildConfigurationForm()` renders a "MyEmma settings" fieldset:

- `group_id` — required textfield; numeric Group ID; comma-separated for multiple groups.
- `account_name` — required select; options are the configured account names from
  `getEmmaAccounts()`.
- `email` — required select; options are webform elements of type `email` or
  `webform_email_confirm`.
- `fields` — `webform_mapping` element mapping webform elements (source) to MyEmma field
  shortcuts (destination). `email` is excluded from the source options.

`submitConfigurationForm()` copies matching `$values['myemma'][<key>]` into
`$this->configuration`. (Note: `selectLookup()` exists but references an undefined
`$element_options` and is not wired to any element callback in the current form.)

## Account resolution — `getEmmaAccounts()`

Returns an associative array of accounts. If `webform_myemma.settings:account_id` is set, it
adds a `default` account built from the flat `account_id`/`public_key`/`private_key` config,
then merges each entry from the `accounts` config mapping (keyed by machine name). If no
default `account_id` is configured, it returns an empty array (so the handler no-ops and logs).

## Submission flow — `postSave()`

Runs only for **new** submissions (`if ($update) return;`).

1. `$fields = $webform_submission->toArray(TRUE)`.
2. `$configuration = $this->tokenManager->replace($this->configuration, $webform_submission)` —
   token-replaces the whole handler config against the submission.
3. Resolve `group_ids`: an array is used as-is; a comma-containing string is `explode(',')`ed
   and trimmed; otherwise a single-element array.
4. `$email = $fields['data'][$configuration['email']]`.
5. Build `$emma_fields` by matching each mapped element key to a submitted `data` value.
6. `getEmmaAccounts()`; if the selected `account_name` exists, instantiate
   `new JccClient($account_id, $public_key, $private_key)` and call
   `import_single_member($email, $emma_fields, $group_ids)` (adds/updates the audience member
   and adds them to the groups).
7. On a falsy response, or on any thrown `\Exception`, an error is logged to the
   `webform_myemma` channel (pointing the admin at the settings page / Group ID); the failure
   is not surfaced to the submitting user. If no account is configured for the handler, an
   error naming the webform is logged.

## Operate

- Configure at least the default MyEmma account first (see `agent/config/settings.md`), then
  add this handler to a webform and pick the account, Group ID(s), email element, and field
  mapping.
- Edited/re-saved submissions are intentionally ignored (only first save imports), avoiding
  duplicate MyEmma imports.
- Watch the `webform_myemma` log channel to diagnose failed imports (bad keys, wrong Group ID,
  or missing account selection).
- The MyEmma "field shortcut" (destination) values must match the field shortcut names defined
  in your MyEmma account.
