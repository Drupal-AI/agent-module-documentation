# Microsoft Graph API — manual setup guide

**Microsoft Graph API** (`ms_graph_api`) provides the connection and client layer
for the **[Microsoft Graph](https://learn.microsoft.com/graph/)** API — the single
API surface over Microsoft 365 (users, groups, mail, calendars, files, Teams, and
Entra ID directory data). It's an unofficial, lightweight wrapper around the
Microsoft Graph SDK for PHP, pulled in via Composer.

Importantly, **this module adds no features for site builders or end users**. It
is deliberately *plumbing*, not a feature: it holds the credentials, handles the
OAuth token exchange, and exposes an authenticated Graph **client** as a service.
The actual business logic — showing a staff directory, listing events from a
shared calendar, reflecting group membership — is left to whatever custom or
contributed module needs it, which is the right split because no two organisations
want the same thing from Graph. **Install it only if you are developing a custom
module, or a module you use declares it as a dependency.** It supports **Drupal 9,
10, and 11**, and the current release is a **beta** (2.0.0-beta2) — evaluate that
before production use.

**Credential handling here is done correctly and worth citing.** The
**[Key](https://www.drupal.org/project/key)** module (`key:key`) is a hard
dependency, so the Azure app's **client secret is stored as a Key entity** rather
than as a value in configuration — meaning it can live in an environment variable
and stay out of your config exports.

**The permissions that matter are on the Microsoft side, not Drupal's**, and
that's the thing to get right. A Graph app registration is granted API scopes,
and it's easy to grant more than the integration needs — `User.Read.All` and
`Directory.Read.All`, for instance, expose your whole organisation's directory to
whatever holds the credential. Scope the registration to the **minimum**, prefer
**delegated** over application permissions where the use case allows, and remember
that a Drupal site holding an application-permission credential is effectively a
directory-read capability sitting on a web server.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module (and the Key dependency).
2. [Configuration](configuration/index.md) — register the app in Azure/Entra ID
   and create the Key(s) the client uses.

## Where it lives in the admin menu

There is no end-user feature or page. Configuration is about registering an Azure
app and defining **Key** entities (of type *MS Graph API Key*) that hold the
credentials the client uses. See [Configuration](configuration/index.md).

## How other modules use it

Once configured, a module obtains the default authenticated Graph client from the
`ms_graph_api.graph` service and calls the Graph API through it — for example:

```php
$graph = \Drupal::service('ms_graph_api.graph');
$user = $graph->createRequest('GET', '/me')
  ->setReturnType(\Microsoft\Graph\Model\User::class)
  ->execute();
```

For sites working with multiple Azure subscriptions, the
`ms_graph_api.graph.factory` service can build a client for any specific custom
key via `buildGraphFromKeyId('my_graph_api_key')`.
