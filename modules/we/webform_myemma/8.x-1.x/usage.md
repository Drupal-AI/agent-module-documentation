<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Webform MyEmma

Adds a webform **MyEmma** handler that, on new submission, imports the submitted email
address (plus mapped fields) into a MyEmma email-marketing group using the
`markroland/emma` API client. Site-wide MyEmma credentials — a default account and any
number of additional named accounts — are configured at
`/admin/config/services/webform_myemma`; each handler instance picks one account, a target
group ID, the email element, and a mapping of webform elements to MyEmma "field shortcuts".

---

## Summary

`SettingsForm` (`/admin/config/services/webform_myemma`, permission **administer webform
myemma**) stores `account_id`, `public_key`, `private_key` for a default account and an
`accounts` list of additional accounts (machine name → id/public/private keys) in
`webform_myemma.settings`. The `WebformMyEmmaHandler` (`@WebformHandler id="myemma"`,
cardinality unlimited) has per-instance settings: `group_id` (numeric, comma-separated for
multiple), `account_name`, `email` element, and a `webform_mapping` of elements to MyEmma
field shortcuts.

On `postSave` for **new** submissions only, it token-replaces the config, resolves the
selected account's keys, instantiates `MarkRoland\Emma\Client($account_id, $public_key,
$private_key)`, and calls `import_single_member($email, $emma_fields, $group_ids)`. Failures
are logged, not surfaced to the user. TLS/HTTP behaviour is delegated to the `markroland/emma`
client. Credentials are stored as plain config and shown as plain textfields to admins.

---

## Use cases

- Add webform subscribers to a MyEmma mailing group automatically on submit.
- Wire a newsletter signup form to a specific MyEmma audience group.
- Route submissions from different forms to different MyEmma accounts.
- Push a single submission to multiple MyEmma groups (comma-separated group IDs).
- Map webform fields (name, company, interests) to MyEmma member field shortcuts.
- Grow an email list from event-registration webforms.
- Segment subscribers by using distinct groups per campaign form.
- Maintain several MyEmma accounts (e.g. per brand) and choose per handler.
- Capture leads from a contact form into MyEmma for follow-up mailings.
- Sync opt-in checkbox forms to a marketing group.
- Add members with prefilled/mapped attributes for personalization.
- Use tokens in handler config to derive group or field values per submission.
- Centralize MyEmma credential management for all forms in one settings page.
- Log integration errors to `webform_myemma` channel for debugging failed imports.
- Only import on first save (updates are ignored) to avoid duplicate imports.
