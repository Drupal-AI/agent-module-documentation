# PET — sending API & the preview flow

## Programmatic sending (functions in `pet.module`)

### `pet_send_mail($pet_id, $recipients, $options)`
Sends one template to many recipients.
- `$pet_id` — the pet entity **id** (numeric). Loaded via `pet_load()` (respects current
  interface language / translations).
- `$recipients` — array; each item is either a plain email string (uid looked up via
  `user_load_by_mail`) **or** `['mail' => …, 'uid' => …]` (more efficient).
- `$options` — any of: `nid`, `subject`, `body`, `body_plain`, `from`, `reply_to`, `cc`,
  `bcc`, `language`. `subject`/`body`/`body_plain` override the stored template for this send;
  `from` falls back to `from_override` then `system.site:mail`.
- Returns a per-recipient status array. Calls `pet_send_one_mail()` for each recipient.

### `pet_send_one_mail(Pet $pet, array $params)`
Sends to a single recipient. Required `$params`: `pet_from`, `pet_to`. Optional: `pet_uid`
(for `user` tokens), `pet_nid` (for `node` tokens), `pet_reply_to`, `language`, plus any extra
data other modules read. It builds `subject`/`body` by running Token `replace()` with
`clear => TRUE`, then calls the mail manager `->mail('pet', $pet->id(), $to, $langcode,
$params, $from)`. `pet_mail()` (`hook_mail`) sets subject/body and adds `Cc`/`Bcc` headers.

## Token substitution (`pet_substitutions()`)

Builds the substitution context: always `global`; adds `user` when a `pet_uid` resolves to a
`User`; adds `node` when a `pet_nid` resolves to a `Node` (translated to the send language).
Then invokes `hook_pet_substitutions_alter($substitutions, $params)` so modules can add token
objects. See [../hooks/hooks.md](../hooks/hooks.md).

## Interactive send: `/pet/{pet}` (`PetPreviewForm`)

Route `pet.preview`, permission `view PET entity`. Two-step `FormBase`:
1. **Step 1** — recipients (`To`, an email field), CC/BCC (default to template values),
   editable subject + body (these edits apply only to this send), token help. Query args read
   from the request: `?uid=` (prefills the To with that user's email and drives `user` token
   substitution), `?nid=` (drives `node` token substitution), `?recipient_callback=true` (or
   legacy `uid=0`) to pull recipients from the template's `recipient_callback` function.
2. **Step 2** — shows the token-substituted preview (subject/HTML body/plain body); **Send
   email(s)** calls `pet_send_mail($pet->id(), $recipients, $options)`. **Back** returns to
   step 1.

Recipients are validated with the core `email.validator`; each valid address is paired with a
looked-up uid. `recipient_callback` must name an existing global function returning an array.

