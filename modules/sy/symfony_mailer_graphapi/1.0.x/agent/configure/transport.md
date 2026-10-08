<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configure the MS Graph API transport

This module registers one Symfony Mailer transport. You configure it through Symfony Mailer's
transport collection, not through a page of this module.

## Prerequisites

- A Microsoft **Entra (Azure AD) app registration** in your tenant, granted the **`Mail.Send`**
  *application* permission (admin-consented). You need three values from it: **tenant id**,
  **client id**, and a **client secret**.
- `symfony_mailer` enabled and `vitrus/symfony-office-graph-mailer` installed via Composer (it comes
  in as a dependency of `drupal/symfony_mailer_graphapi`).

## Add the transport (UI)

1. Go to **Administration > Configuration > System > Mailer > Mailer Transport**
   (`/admin/config/system/mailer/transport`, route `entity.mailer_transport.collection`).
2. Add a transport and pick type **"MS Graph API"** (plugin id `symfony_mailer_graphapi_transport`).
   The add form is `/admin/config/system/mailer/transport/add/symfony_mailer_graphapi_transport`.
3. Fill the three required fields and save; set it as the default transport if you want all mail to use it.

The "DSN" transport type is **not** usable for Graph — Symfony Mailer hardwires its DSN transport
list, so this module ships a dedicated plugin instead.

## Config form fields

Defined in `MSGraphApiTransport::buildConfigurationForm()`:

| Field | Config key | Form `#type` | Required |
|-------|-----------|--------------|----------|
| Client ID | `client_id` | `textfield` | yes |
| Client Secret | `client_secret` | `password` | yes |
| Tenant ID | `tenant_id` | `textfield` | yes |

Values are written straight back in `submitConfigurationForm()` and stored as the transport's plugin
`configuration`. `defaultConfiguration()` seeds all three to `''`.

## Where the config is stored

Config entity type `mailer_transport` (provided by `symfony_mailer`). One transport is a config object
`symfony_mailer.mailer_transport.<id>` with:

```yaml
id: my_graph_transport
label: 'Microsoft 365'
plugin: symfony_mailer_graphapi_transport
configuration:
  client_id: '<app client id>'
  client_secret: '<app client secret>'
  tenant_id: '<tenant id>'
```

Config schema (this module, `config/schema/symfony_mailer_graphapi.schema.yml`) declares the mapping
under the type **`mailer_transport.transport_plugin.graphapi`** with keys `client_id`,
`client_secret`, `tenant_id` (all `string`). Note the plugin **id** is
`symfony_mailer_graphapi_transport` while the declared schema type name uses the short token
`graphapi`.

## Create/set via drush or PHP

There is no drush command in this module. Create the transport as a config entity:

```php
$transport = \Drupal::entityTypeManager()
  ->getStorage('mailer_transport')
  ->create([
    'id' => 'my_graph_transport',
    'label' => 'Microsoft 365',
    'plugin' => 'symfony_mailer_graphapi_transport',
    'configuration' => [
      'client_id' => getenv('MS_GRAPH_CLIENT_ID'),
      'client_secret' => getenv('MS_GRAPH_CLIENT_SECRET'),
      'tenant_id' => getenv('MS_GRAPH_TENANT_ID'),
    ],
  ]);
$transport->save();

// Make it the site default transport (symfony_mailer setting).
\Drupal::configFactory()->getEditable('symfony_mailer.settings')
  ->set('default_transport', 'my_graph_transport')->save();
```

Or set the default in one line: `drush cset symfony_mailer.settings default_transport my_graph_transport`.

## How it works at runtime

- `MSGraphApiTransport::getDsn()` returns
  `microsoft-graph-api://{client_id}:{client_secret}@{tenant_id}`.
- Service `symfony_mailer_graphapi.transport`
  (`Vitrus\SymfonyOfficeGraphMailer\Transport\GraphApiTransportFactory`, tagged
  `mailer.transport_factory`) matches scheme `microsoft-graph-api` and builds a
  `GraphApiTransport(host=tenant_id, user=client_id, password=client_secret, http_client, dispatcher, logger)`.
- On the first send (`GraphApiTransport::doSendApi()`), the transport requests an OAuth token:
  `POST https://login.microsoftonline.com/{tenant_id}/oauth2/v2.0/token` with
  `grant_type=client_credentials`, `scope=https://graph.microsoft.com/.default`, and the client id +
  secret. The `access_token` is held in memory (a private property) and reused for the life of the
  transport instance.
- The mail is then sent:
  `POST https://graph.microsoft.com/v1.0/users/{senderAddress}/sendMail` with a bearer token and a
  JSON body built from the Symfony `Email` (subject, to/cc/bcc/replyTo, HTML body preferred over
  text, base64 attachments, `saveToSentItems`). `{senderAddress}` is the envelope sender.
  A `202 Accepted` means success; any other status raises `HttpTransportException`.
- Header **`X-Save-To-Sent-Items: false`** on an outgoing message disables saving a copy to the
  mailbox's Sent Items (default is to save).

## Limitations (from the module README)

- The transport does not modify the outgoing mail; it is a thin transport layer only.
- Although the sender address is read from the message, Microsoft Graph sends from the primary SMTP
  address of the mailbox the app is authorised for; per-message From spoofing is a Graph limitation,
  not something the module controls.
