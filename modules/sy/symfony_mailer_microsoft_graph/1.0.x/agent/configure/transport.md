# Configure the Microsoft Graph transport

There is **no settings page of this module's own** (no `configure` route). You configure it inside
Symfony Mailer's transport UI, choosing the **Microsoft Graph** transport, or by supplying a raw
`msgraph://` DSN. All the values below come from an **Azure AD app registration** that has been
granted the Graph **`Mail.Send`** application permission.

## The four values

Source: `Plugin/MailerTransport/MicrosoftGraphTransport.php` (`buildConfigurationForm()`).

| Form field | Config key | Meaning |
|---|---|---|
| User name | `user` | The mailbox to send **as** (a UPN / email address). Becomes the Graph `byUserId(...)` segment, i.e. `POST /users/{user}/sendMail`. |
| Tenant ID | `query.tenant` | Azure AD directory (tenant) id. |
| Client ID | `query.client_id` | Application (client) id of the app registration. |
| Client Secret | `query.client_secret` | The app registration's **client secret value** — 40 chars, e.g. `LXU8Q~...`. NOT the secret **ID** (a 36-char UUID). |

`defaultConfiguration()` returns all four empty. `submitConfigurationForm()` writes them back to
`configuration.user` and `configuration.query.{tenant,client_id,client_secret}`.

## Validation (`validateConfigurationForm`)

The only server-side check: if the Client Secret **is a valid UUID**, the form rejects it with the
message that a UUID is the secret *ID*, not the secret *value*. There is no length/format check
beyond that.

## Operational caveat — the Client Secret field is a password element

`client_secret` is rendered as `#type => 'password'`. Drupal's password element does **not** echo a
stored `#default_value` back into the HTML, so the field always renders **blank** even after a secret
has been saved. Because `submitConfigurationForm()` unconditionally writes
`$form_state->getValue('client_secret')` into config, **re-saving this transport form for any other
reason (e.g. changing the mailbox) with the secret field left blank overwrites the stored secret with
an empty string** and breaks sending. Re-enter the client secret every time you save the form.

## Equivalent DSN

The factory (`Transport/MicrosoftGraphTransportFactory::create()`) reads the DSN as:

```
msgraph://<mailbox>@default?tenant=<TENANT>&client_id=<CLIENT_ID>&client_secret=<SECRET>
```

- DSN **user** (`$dsn->getUser()`) → the mailbox (`user`).
- DSN options `tenant`, `client_id`, `client_secret` → the three query values.
- The host part (`default`) is ignored. Missing options default to `''`.
- Any DSN whose scheme is not `msgraph` throws `UnsupportedSchemeException`.

## Azure app-registration hardening (operational)

Scope the app registration to a **single mailbox** with an application access policy
(`New-ApplicationAccessPolicy`) rather than leaving `Mail.Send` granted tenant-wide — otherwise the
credentials can send as *any* user in the organisation.

## Version note (this site)

This module's plugin extends `Drupal\symfony_mailer\Plugin\MailerTransport\TransportBase`, which
exists in symfony_mailer **1.x**. The site here runs **Mailer Plus (`symfony_mailer`) 2.0.2**, whose
`mailer_transport` submodule replaced that plugin architecture (config entity
`mailer_transport.mailer_transport.*`, `TransportUI` plugins, DSN stored as a single string). On 2.x
the tagged **factory** service still registers the `msgraph` scheme, so a raw `msgraph://` DSN works,
but the friendly four-field plugin form above may not be discoverable. Verify how your installed
Symfony Mailer version exposes transport configuration.
