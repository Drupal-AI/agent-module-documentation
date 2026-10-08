<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The sync engine — `brevo_contact_sync_entity_presave()`

Source: `brevo_contact_sync.module` (the module's only hook; no service class).

## Trigger

`hook_entity_presave` on **every** entity save; the body runs only when
`$entity->bundle() == "user"`. So sync fires on user create/edit (registration, admin edit,
programmatic user save) *before* the save is written. There is no queue — the Brevo HTTP calls
happen synchronously inside the presave, so a slow/failing Brevo API slows the user save.

## Credential + client setup

- `$api_key = \Drupal::config('sendinblue_api.config')->get('api_key')`. If empty → logs
  `error('API key is missing.')` and returns (no data sent).
- `$api_config = Configuration::getDefaultConfiguration()->setApiKey('api-key', $api_key)` then
  `new ContactsApi(NULL, $api_config)` — the official Brevo PHP SDK with its default Guzzle HTTP
  client (standard HTTPS to `api.brevo.com`; TLS verification left at the SDK/Guzzle default).

## Value extraction (per mapping row)

Iterates `$config->get('mappings')`. For each row with both `user_field` and `mapping_field` set,
it loads the user field definition and branches on field type, building `$createContact[<mapping_field>]`:

- **entity_reference**: `ref_value == 'entity_reference_name'` → referenced Node title or Term
  name; else the `target_id`.
- **boolean**: `'1'` → `TRUE`, else `FALSE`.
- **link**: `link_url` → uri; `link_label` → title.
- **integer / decimal / float / datetime / timestamp**: raw `->value`.
- **list_string**: `list_string_value` → the human label from the field's `allowed_values`;
  `list_string_key` → the stored key.
- **file**: `file_uri` → `File::getFileUri()`; `file_full_url` → `File::getFilename()` (note: the
  "full_url" branch actually returns the filename, not a URL).
- **address**: reads the requested sub-property (country_code, address_line1-3, locality,
  postal_code, administrative_area, given_name, family_name, organization) and assigns it directly
  into `$createContact[$mapping_field]`.
- Default/`string`: `$value = $entity->get($user_field)->value`.

Only the address branch and the explicit branches assign into `$createContact`; note the simpler
branches compute `$value` but do not always write it back into `$createContact` for the non-address
types — behaviour is field-type dependent, so verify mappings against the actual attribute you see
in Brevo.

## Create vs. update

- `$email = $account->getEmail()` is the contact key. `$list_IDs` = the configured `selected_list`
  coerced to int(s); only `$list_IDs[0]` is used.
- Existence check: `try { $contactsApi->getContactInfo($email)->getEmail(); } catch { [] }`.
- If found → `UpdateContact(['attributes'=>$createContact,'emailBlacklisted'=>FALSE,
  'listIds'=>[$list_IDs[0]]])` → `updateContact($email, …)`; logs
  `notice('Updated contact: @email')`.
- Else → `CreateContact(['email'=>$email,'attributes'=>$createContact,'emailBlacklisted'=>FALSE,
  'listIds'=>[$list_IDs[0]]])` → `createContact(…)`; logs `notice('Created new contact: @email')`.

## Operational notes

- The create/update block sits **inside** the mappings loop, so with N mapping rows the module can
  issue N getContactInfo + create/update round-trips per user save. Keep the mapping list small.
- No delete/unsubscribe path — removing a Drupal user does not remove the Brevo contact.
- Logs contain the contact **email** (an "info"/notice-level PII trace) but never the API key.
- `emailBlacklisted` is always forced to `FALSE`, so a sync can un-blacklist a contact that had
  previously opted out on the Brevo side.
