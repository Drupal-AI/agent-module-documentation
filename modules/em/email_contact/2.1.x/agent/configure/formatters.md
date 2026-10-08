<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The two Email Contact formatters

Both target the core **`email`** field type and are chosen per field on the entity's
*Manage display* page — there is no global config page.

| Formatter id | Renders |
|---|---|
| `email_contact_link` | A link (optionally an AJAX **modal**) to the contact form |
| `email_contact_inline` | The contact form embedded directly in the field output |

## Apply via the UI

*Structure → (entity) → Manage display*, set the email field's **Format** to "Email contact
link" or "Email contact inline", click the cog to edit settings, **Update**, **Save**.

## Apply via config / drush (scriptable)

The choice lives in the `entity_view_display` config
(`core.entity_view_display.<entity>.<bundle>.<view_mode>`) at `content.<field>.type`:

```php
$vd = \Drupal::entityTypeManager()->getStorage('entity_view_display')
  ->load('node.article.default');
$vd->setComponent('field_author_email', [
  'type' => 'email_contact_link',
  'label' => 'hidden',
  'settings' => [
    'link_text' => 'Contact the author',
    'modal' => TRUE,
    'title' => 'Message the author',
    'include_values' => 1,
    'default_message' => 'Sent from [current-page:url]',
  ],
])->save();
```

Read it back: `drush cget core.entity_view_display.node.article.default content.field_author_email`
and look at `type` / `settings`.

## Setting keys

### `email_contact_link` (`defaultSettings()`)

| Key | Default | Meaning |
|---|---|---|
| `link_text` | `Contact person by email` | The visible link text |
| `modal` | `FALSE` | Open the form in an AJAX modal dialog instead of a full page |
| `title` | `''` | Page/modal title; if empty → "`<entity label> - Email Contact`" |
| `include_values` | `1` | Include submitter name/email in the message body |
| `default_message` | `''` | Extra text prepended to the body (tokens if Token installed) |
| `redirection_to` | `custom` | Fixed hidden value for this formatter |
| `custom_path` | `''` | Fixed hidden value for this formatter |

### `email_contact_inline` (`defaultSettings()`)

| Key | Default | Meaning |
|---|---|---|
| `redirection_to` | `front` | Post-submit redirect: `front`, `current`, or `custom` |
| `custom_path` | `''` | Path used when `redirection_to = custom` (validated, required) |
| `include_values` | `1` | Include submitter name/email in the message body |
| `default_message` | `[current-user:name] sent a message using the contact form at [current-page:url].` | Extra body text (tokens if Token installed) |
| `link_text` | `''` | Hidden/unused for the inline formatter |

Config schema: `field.formatter.settings.email_contact_inline` and
`field.formatter.settings.email_contact_link` (the link schema extends the inline one, adding
`modal` and `title`).

## Access & display notes

- No module permission: the form/link is shown wherever the user can *view* the entity and the
  field (`ContactController::accessCheck` re-checks entity + field view access).
- The email address itself is never rendered — only the link or the form.
- Set the field **Label** to *hidden* if you don't want a field label above the link/form.
