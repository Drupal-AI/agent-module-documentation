<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Contact forms, settings and routes

## Install

```bash
composer require drupal/contact      # only resolves on Drupal 11.4+
drush en contact -y
```

On Drupal ≤ 11.3 core still ships `contact`; enabling the core one is the same `drush en contact`.
The contrib project takes over transparently after the core module is removed — same machine
name, same config names, so no migration step is needed.

## Config objects

### `contact.settings`

```yaml
default_form: feedback      # which contact_form /contact shows
flood:
  limit: 5                  # messages…
  interval: 3600            # …per this many seconds
user_default_enabled: true  # personal contact form on by default for new users
```

```bash
drush cget contact.settings
drush cset contact.settings flood.limit 3 -y
drush cset contact.settings default_form support -y
```

Note `default_form: feedback` ships as the default value but **no `feedback` form is installed by
this module** — only `contact.form.personal`. Until you create one, `/contact` throws a 404 for
regular users and shows an admin error message ("The contact form has not been configured") to
users with `administer contact forms`.

### `contact.form.{id}` — one per form

```yaml
langcode: en
status: true
dependencies: {  }
id: support
label: 'Support request'
recipients:
  - support@example.com
  - ops@example.com
reply: 'Thanks — we aim to answer within two working days.'   # auto-reply body, '' = none
weight: 0
message: 'Your message has been sent.'                        # status message after submit
redirect: '/thank-you'                                        # '' = front page
```

Create one from the CLI:

```bash
drush php:eval '\Drupal\contact\Entity\ContactForm::create([
  "id" => "support",
  "label" => "Support request",
  "recipients" => ["support@example.com"],
  "reply" => "Thanks, we will be in touch.",
  "message" => "Your message has been sent.",
  "redirect" => "/thank-you",
  "weight" => 0,
])->save();'

drush cget contact.form.support
```

The shipped `contact.form.personal` has **empty `recipients`** — recipients for personal messages
come from the contacted user account, and `reply` is ignored (see below).

## Routes and UI map

| Route | Path | Requirement |
|---|---|---|
| `entity.contact_form.collection` | `/admin/structure/contact` | `administer contact forms` |
| `contact.form_add` | `/admin/structure/contact/add` | `administer contact forms` |
| `entity.contact_form.edit_form` | `/admin/structure/contact/manage/{contact_form}` | `_entity_access: contact_form.update` |
| `entity.contact_form.delete_form` | `…/{contact_form}/delete` | `_entity_access: contact_form.delete` |
| (route provider) | `…/{contact_form}/permissions` | per-form permissions, via `EntityPermissionsRouteProvider` |
| `contact.site_page` | `/contact` | `access site-wide contact form` |
| `entity.contact_form.canonical` | `/contact/{contact_form}` | `_entity_access: contact_form.view` |
| `entity.user.contact_form` | `/user/{user}/contact` | `_access_contact_personal_tab: TRUE` |

`configure` in info.yml points at `entity.contact_form.collection`.

## Adding fields to a form

`contact_message` is a fieldable content entity whose bundles are the contact forms, with
`field_ui_base_route: entity.contact_form.edit_form`. With Field UI enabled, *Manage fields* /
*Manage form display* tabs appear on each form's edit page.

```bash
drush en field_ui -y
# Fields are attached per bundle, i.e. per contact form id:
#   field.field.contact_message.support.field_order_id
```

Remember messages are not saved (null storage), so an added field only travels into the email
body — build the mail body accordingly (see [../api/mail-and-messages.md](../api/mail-and-messages.md)).

## Personal contact form defaults

- `contact.settings:user_default_enabled` decides the behaviour for users who never touched the
  setting.
- Each user's own choice is stored in **`user.data`**, module `contact`, key `enabled`
  (not in a field, not in config).

```bash
# Turn off the personal form for user 5:
drush php:eval '\Drupal::service("user.data")->set("contact", 5, "enabled", 0);'
# Read it back:
drush php:eval 'var_dump(\Drupal::service("user.data")->get("contact", 5, "enabled"));'
```

The checkbox itself is injected into the user form by
`ContactFormHooks::formUserFormAlter()`, and the site default checkbox into
`/admin/config/people/accounts` by `formUserAdminSettingsAlter()`.
