<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Hooks

The module implements **no** procedural hooks — `contact.services.yml` sets
`contact.skip_procedural_hook_scan: true` and everything lives in `#[Hook]` methods on three
classes under `src/Hook/`. It defines no `contact.api.php`, so there are no contact-specific hooks
for you to implement; you extend it through core's generic hooks listed at the bottom.

## `ContactHooks`

| Hook | What it does |
|---|---|
| `help` | Help text for the module and its admin routes |
| `entity_type_alter` | Adds a `contact-form` link template to the **user** entity type → `/user/{user}/contact`, so `$user->toUrl('contact-form')` works |
| `entity_extra_field_info` | Registers the pseudo-fields on the message form (see below) and a `contact` group on the user form |
| `menu_local_tasks_alter` | Removes the *Contact* tab from a user profile when that user has no email address |
| `mail` | Builds subject/body for `page_mail`, `page_copy`, `page_autoreply`, `user_mail`, `user_copy` |
| `rest_resource_alter` | Replaces `entity:contact_message`'s class with `ContactMessageResource` (POST only) |

Extra fields registered per `contact_message` bundle (all on the **form** display, so they can be
reordered/hidden in *Manage form display*):

| Pseudo-field | Weight | Notes |
|---|---|---|
| `name` | -50 | Sender name (anonymous senders) |
| `mail` | -40 | Sender email |
| `recipient` | -30 | **`personal` bundle only** — recipient username |
| `preview` | 40 | Preview button |
| `copy` | 50 | "Send yourself a copy" checkbox |

Plus `user.user.form.contact` (weight 5) — the *Contact settings* group on the user edit form.

## `ContactFormHooks`

| Hook | What it does |
|---|---|
| `form_user_form_alter` | Adds the per-user "Personal contact form" checkbox, defaulting from `user.data` (`contact`/`enabled`) or `contact.settings:user_default_enabled` |
| `form_user_admin_settings_alter` | Adds the site-wide *Enable the personal contact form by default for new users* checkbox to `/admin/config/people/accounts` |

## `ContactViewsHooks`

| Hook | What it does |
|---|---|
| `views_data_alter` | Adds the `contact_link` field to the user views data |

## Extending contact from your own module

There is no dedicated API; use core hooks:

```php
// Change the form (add a honeypot, a CAPTCHA, reorder elements).
function mymodule_form_contact_message_support_form_alter(&$form, FormStateInterface $form_state) {
  $form['message']['widget'][0]['value']['#description'] = t('Please include your order id.');
}

// Change the outgoing email after contact built it.
function mymodule_mail_alter(&$message) {
  if ($message['module'] === 'contact') {
    $message['headers']['Reply-To'] = $message['from'];
    $message['from'] = 'no-reply@example.com';
  }
}

// React to a submission (contact never saves the entity, so hook_entity_insert is useless here).
function mymodule_form_alter(&$form, FormStateInterface $form_state, $form_id) {
  if (str_starts_with($form_id, 'contact_message_')) {
    $form['actions']['submit']['#submit'][] = 'mymodule_contact_submitted';
  }
}
```

Two gotchas worth remembering:

- `hook_ENTITY_TYPE_insert('contact_message')` never fires — storage is
  `ContentEntityNullStorage`. Hook the form submit or `hook_mail_alter()` instead.
- Rendering of the message inside emails uses the **`mail` view mode** of `contact_message`; a
  field you add must be enabled there or it will not appear in the email.
