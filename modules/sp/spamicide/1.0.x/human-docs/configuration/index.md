# Configuration

Spamicide has two parts: the list of **protected forms** and a small **settings**
form.

## Managing protected forms

Go to **Structure → Spamicide** (`/admin/structure/spamicide`), which requires
the **Administer spamicide** permission. This page lists every form protection.
Each one is a configuration entity with:

- **Label** — a human-friendly name for the protection.
- **Description** — an optional note.
- **Form ID** — the Drupal form ID this protection applies to (for example
  `user_register_form`).
- **Status** — whether the protection is enabled. Only enabled protections
  actually add the honeypot to a form.

Use **Add**, **Edit**, and **Delete** to manage the list. To protect a new form,
add a protection and enter its form ID. To stop protecting a form, disable or
delete its entry.

Because these are configuration entities, your protections are exportable with the
rest of your site configuration, so they travel between environments.

### Adding a protection from the command line

```bash
ddev drush php:eval "\Drupal::entityTypeManager()->getStorage('spamicide')->create(['id'=>'my_form','label'=>'My form','spamicide_form_id'=>'my_custom_form','status'=>TRUE])->save();"
```

## Settings

Go to **Structure → Spamicide → Settings**
(`/admin/structure/spamicide/settings`). This form requires the **Administer site
configuration** permission and saves to `spamicide.settings`:

- **Admin mode** (`spamicide_admin_mode`, on by default) — shows an "Add
  spamicide to this form" convenience link on forms that are not yet protected,
  for users who can administer Spamicide. This makes it easy to protect a form
  while you are looking at it. (It deliberately excludes Spamicide's own forms,
  search forms, and pages under `/admin/structure`.)
- **Log attempts** (`spamicide_log_attempts`, on by default) — logs each blocked
  submission (with the form ID and the client IP) to the `spamicide` log channel,
  and increments the counter below.
- **Counter** (`spamicide_counter`) — a running total of blocked spam
  submissions.

## How protection behaves

When a protected form is displayed, Spamicide adds a hidden `feed_me` field near
the bottom and hides it with CSS. On submission:

- If the field is empty (a real person), the submission passes normally.
- If the field has a value (a bot filled it in), the submission is rejected with a
  form error, optionally logged, and the visitor is redirected back — the spammer
  gets no useful feedback.

> **Note:** in this release the honeypot field name is fixed as `feed_me` and
> cannot be renamed. Spamicide is honeypot-only — it does not add flood control,
> CAPTCHA, or timing checks, so layer it with those tools if you need stronger
> protection.
