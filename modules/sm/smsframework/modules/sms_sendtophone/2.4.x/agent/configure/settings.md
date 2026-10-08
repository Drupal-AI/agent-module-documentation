# Configure Send To Phone

## Which content types show the link

Admin form `Drupal\sms_sendtophone\Form\AdminOverviewForm` at route
`sms_sendtophone.admin_overview` → `/admin/config/smsframework/sendtophone` (permission
`administer smsframework`). It writes the config object `sms_sendtophone.settings`:

| Key | Type | Meaning |
|---|---|---|
| `content_types` | sequence of strings | Node bundles on which the "Send to phone" node link appears. |
| `archive_max_age_days` | integer | Declared in schema; not used by the shipped code. |

```php
\Drupal::configFactory()->getEditable('sms_sendtophone.settings')
  ->set('content_types', ['article', 'page'])
  ->save();
```

`sms_sendtophone_node_links_alter()` adds a "Send to phone" link to nodes of the selected bundles —
shown when the current user has `send to any number` or already has a phone number; otherwise
authenticated users are prompted to set up and confirm their mobile number.

## The send form

Route `sms_sendtophone.page` → `/sms/sendtophone/{type}/{extra}`, form
`Drupal\sms_sendtophone\Form\SendToPhoneForm` (id `sms_sendtophone_form`), `_permission: 'access content'`.
`type` selects what is texted:

| `type` | What is sent |
|---|---|
| `node` (`extra` = node id) | The node's absolute URL. |
| `field` / `cck` | The `text` query parameter (set by the field formatter/link). |
| `inline` | The `text` query parameter (set by the `[sms]…[/sms]` filter). |

The form shows the message (or a preview) and a phone-number field, then queues an outgoing
`SmsMessage` through the parent `sms.provider`
([send flow](../../../../2.4.x/agent/api/services.md)). `buildForm()` only renders the send form if
the user has `send to any number` **or** at least one phone number returned by the framework's
phone-number provider; otherwise it shows a prompt to set up/confirm a number or to sign in/register.

## Permission

| Permission | Grants |
|---|---|
| `send to any number` | Intended to allow sending to an arbitrary typed number (vs. only the user's own confirmed number). |
