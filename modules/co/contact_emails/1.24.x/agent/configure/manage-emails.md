# Configure Contact Emails

There is **no single settings form** for behaviour — each email is a `contact_email` **content
entity** you add to a contact form. One global config object holds a charset toggle.

## Routes / UI

| Route | Path | Permission | Purpose |
|---|---|---|---|
| `entity.contact_email.full_collection` (the `configure` route) | `/admin/structure/contact/emails` | `manage contact form emails` | List all emails across every form |
| `entity.contact_email.collection` | `/admin/structure/contact/manage/{contact_form}/emails` | `manage contact form emails` | Emails for one form |
| `entity.contact_email.full_add_form` / `entity.contact_email.add_form` | `.../emails/add` | `manage contact form emails` | Add an email |
| `entity.contact_email.edit_form` / `.delete_form` | `.../emails/{contact_email}/edit` \| `/delete` | `manage contact form emails` | Edit / delete |
| `contact_email.settings` | `/admin/structure/contact/emails/settings` | `administer contact forms` | Global settings form |

On a contact form's own edit form, if it already has ≥1 email the core **Recipients** and
**Auto-reply** fields are hidden and a link "Emails for this form are managed here" is shown.

## The `contact_email` entity fields

Stored in the `contact_email` / `contact_email_field_data` tables (entity id key `email_id`,
label = `subject`, `status` = enabled flag). Key fields:

| Field | Meaning |
|---|---|
| `contact_form` | Entity reference to the `contact_form` this email belongs to (required). |
| `subject` | Email subject (token-aware, `contact_message` tokens). |
| `message` | Body (`text_long`, formatted; HTML or plain depending on the text format). |
| `append_message` | Boolean: append the full rendered submission below the body. |
| `status` | Boolean: whether this email is enabled/sent. |
| `recipient_type` | One of `manual`, `submitter`, `field`, `reference`, `context`, `default`. |
| `recipients` | Address list used when `recipient_type = manual` (comma/`;`/newline separated). |
| `recipient_field` | Message field name used when `recipient_type = field`. |
| `recipient_reference` | `field.entity_type.bundle.email_field` path used when `recipient_type = reference`. |
| `reply_to_type` | One of `default`, `submitter`, `field`, `reference`, `context`, `manual`. |
| `reply_to_email` | Address used when `reply_to_type = manual`. |
| `reply_to_field` / `reply_to_reference` | Field / reference path for the other reply-to types. |

### recipient_type / reply_to_type semantics
- `manual` — literal address(es) in `recipients` / `reply_to_email`.
- `submitter` — the sender email on the contact message.
- `field` — read the address from a named field on the message.
- `reference` — follow a reference path to an email field on a referenced entity.
- `context` — the owner/author of the entity in the current route context.
- `default` — the site email (`system.site` `mail`).

## Global setting

Config object `contact_emails.settings`:

```yaml
allow_charset_utf_8: false   # when true, HTML mails use "text/html; charset=UTF-8"
```

Read/write with drush:

```bash
drush cget contact_emails.settings allow_charset_utf_8
drush cset contact_emails.settings allow_charset_utf_8 true -y
```

## Create an email with drush (scriptable)

```php
$email = \Drupal::entityTypeManager()->getStorage('contact_email')->create([
  'contact_form'   => 'feedback',      // a contact_form id
  'subject'        => 'New enquiry: [contact_message:subject]',
  'recipient_type' => 'manual',
  'recipients'     => 'sales@example.com, support@example.com',
  'reply_to_type'  => 'submitter',
  'status'         => TRUE,
]);
$email->save();
```

Read them back: `drush php:eval '$ids = \Drupal::entityQuery("contact_email")->accessCheck(FALSE)->condition("contact_form","feedback")->execute(); var_export($ids);'`
