<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Sending mail, flood control, and programmatic use

## Services

| Service | Class | Notes |
|---|---|---|
| `contact.mail_handler` | `MailHandler` | Also aliased as `Drupal\contact\MailHandlerInterface` for autowiring |
| `access_check.contact_personal` | `ContactPageAccess` | Backs `_access_contact_personal_tab` |
| `logger.channel.contact` | core `LoggerChannel` | Every send is logged here |

## Sending a contact message from code

```php
$message = \Drupal::entityTypeManager()->getStorage('contact_message')->create([
  'contact_form' => 'support',        // bundle = contact_form id
  'subject'      => 'Order 1234',
  'message'      => 'Where is my order?',
  'name'         => 'Anon Visitor',   // only used for anonymous senders
  'mail'         => 'visitor@example.com',
  'copy'         => TRUE,             // send the sender a copy
]);
\Drupal::service('contact.mail_handler')
  ->sendMailMessages($message, \Drupal::currentUser());
```

For a **personal** message set `contact_form => 'personal'` and `recipient => $uid`.
Do **not** expect `$message->save()` to store anything: the entity type's storage handler is
`ContentEntityNullStorage`.

`sendMailMessages()` throws `MailHandlerException` when it cannot determine recipients (no
`recipients` on the form, or no recipient user for a personal message) — catch it if you call the
handler outside the form.

## What gets sent

| Mail key | When | To | Language |
|---|---|---|---|
| `page_mail` | site-wide form submitted | form `recipients` | site default (or recipient's preferred, for personal) |
| `page_copy` | sender ticked *Send yourself a copy* | sender | current language |
| `page_autoreply` | form has a non-empty `reply` | sender | current language |
| `user_mail` | personal form submitted | contacted user | contacted user's preferred langcode |
| `user_copy` | sender ticked copy on a personal form | sender | current language |

Bodies are assembled in `ContactHooks::mail()`:

- Site-wide: subject becomes `[<form label>] <subject>`; body is a "X sent a message using the
  contact form at <url>" line plus the message entity rendered in the **`mail` view mode**
  (`renderInIsolation()`), so any field you add to the form shows up in the email automatically
  once it is enabled in that view mode.
- Personal: subject becomes `[<site name>] <subject>`; body greets the recipient and, unless the
  sender has `administer users`, appends an opt-out line pointing at the recipient's edit form.
  The opt-out line is omitted from `user_copy`.
- Auto-reply body is the form's `reply` string verbatim. **Personal forms do not support
  auto-replies** — `MailHandler` skips it and logs an error if a reply is configured but the
  sender has no email address.

The From address is the **sender's** email (`$sender_cloned->getEmail()`), which is why an SPF/DMARC-
strict site usually wants a mail module that rewrites From and sets Reply-To instead.

## Flood control

`MessageForm::validateForm()`:

```php
if (!$this->flood->isAllowed('contact', $limit, $interval)) {
  $form_state->setErrorByName('', $this->t('You cannot send more than %limit messages in @interval. Try again later.', …));
}
```

and `save()` calls `$this->flood->register('contact', $interval)`. Both read
`contact.settings:flood.limit` / `flood.interval` (defaults 5 / 3600). The event name is the bare
string `contact` for **both** site-wide and personal forms, so the two share one budget per client.

```bash
drush cset contact.settings flood.limit 20 -y      # loosen
drush sqlq "SELECT COUNT(*) FROM flood WHERE event='contact'"   # who is being throttled
drush sqlq "DELETE FROM flood WHERE event='contact'"            # clear during testing
```

After a successful send the form redirects away from itself (to the contacted user's profile if
the sender has `access user profiles`, otherwise to the form's `redirect` or the front page) —
precisely so a reload does not trip the flood limit.

## REST

`ContactHooks::restResourceAlter()` swaps the generic `entity:contact_message` resource class for
`ContactMessageResource`, which restricts `availableMethods()` to POST only (GET/PATCH/DELETE make
no sense against null storage).

```bash
curl -X POST https://example.com/entity/contact_message?_format=json \
  -H 'Content-Type: application/json' \
  -d '{"contact_form":[{"target_id":"support"}],"subject":[{"value":"Hi"}],"message":[{"value":"Hello"}],"name":[{"value":"Visitor"}],"mail":[{"value":"v@example.com"}]}'
```

The usual REST module setup applies (enable `rest`, grant the resource permission); message access
is enforced by `ContactMessageAccessControlHandler`.

## Views

`#[ViewsField("contact_link")]` (`ContactLink extends LinkBase`) renders a "contact" link for a
user row, honouring the same personal-tab access check. `ContactViewsHooks::viewsDataAlter()`
attaches it to the user views data.

## Migrations

`migrations/` ships `contact_category` (D6 categories → contact forms), `d6_contact_settings`,
`d7_contact_settings`, plus a `migrate_drupal` state file; sources are
`Plugin/migrate/source/ContactCategory.php` and `ContactSettings.php`.
