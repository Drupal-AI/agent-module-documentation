# EditionGuard API — manual setup guide

**EditionGuard API** (`editionguard_api`) is a connector between your Drupal site
and [EditionGuard](https://www.editionguard.com/), a hosted service that wraps
ebooks in DRM and handles their fulfilment. The module exposes a ready-made API
client as a Drupal service so that developers can list, create, update, and
delete DRM ebooks, generate reader/download links, and manage transactions and
master links — all without hand-writing HTTP calls against EditionGuard's v2
REST API.

It is important to be clear about who this module is for: **the base module has
no front-end and does nothing on its own.** The intended audience is module
developers and site programmers. Once you enter your EditionGuard credentials on
its settings form, the client (`editionguard_api.client`) authenticates against
EditionGuard, caches the returned token, and is then available for your own code
to call. Each API operation is modelled as a discoverable "endpoint plugin"
(for example `book_list`, `book_create`, `deliver_book_link`), so your code asks
the client to run a named endpoint rather than building requests by hand.

The only parts a webmaster or site builder will touch are the **settings form**
(where the EditionGuard account credentials live) and the two **test forms**,
which let an administrator exercise an endpoint interactively while building an
integration. Everything else is code you write. The module has no module
dependencies of its own, and it needs an active EditionGuard account with API
access.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — enter your EditionGuard credentials,
   set the token lifetime, and toggle request logging (includes an important note
   on how the credentials are stored).

## Where it lives in the admin menu

Once enabled, the settings form sits at **Configuration → Web services →
EditionGuard API** (`/admin/config/services/editionguard-api`). Two companion
routes — a general **Test** form and an **Endpoint test** form
(`/test/endpoint/{endpoint_id}`) — let an administrator run any endpoint by hand.
All three routes require the **Administer site configuration** permission, so
there are no anonymous or front-end endpoints.

## How to use it

After entering your credentials, obtain the client service from your own code and
run a named endpoint:

```php
$client = \Drupal::service('editionguard_api.client');
$manager = $client->getEndpointPluginManager();
$endpoint = $manager->createInstance('book_list');
$result = $client->request($endpoint, $query_params, $form_params);
```

`request()` returns the decoded JSON response on success. The client handles
authentication for you — it POSTs your credentials to EditionGuard, caches the
token, and adds it to each call as an `Authorization: Token …` header. Book
create/update/replace operations automatically switch to multipart uploads so the
ebook file is streamed. All traffic goes to EditionGuard over HTTPS with normal
TLS certificate verification.
