# HTTP Client Manager — manual setup guide

**HTTP Client Manager** (`http_client_manager`) is a developer tool for talking
to third-party REST/HTTP APIs. Instead of hand-writing Guzzle request code for
every endpoint of every service you integrate with, you *describe* an API once —
its base URL, its operations, their parameters — and then call those operations
by name through managed, reusable client instances. It builds on the
`guzzlehttp/guzzle-services` "service description" format, so a CRM, payment
gateway, weather service or any other API becomes a tidy set of named commands
you can call from anywhere in your Drupal code.

This is primarily a **code-first** module: the real work of integrating an API
happens in a couple of YAML files you add to a custom module, plus a few lines of
PHP to call the operations. On top of that it provides a small admin UI for
inspecting the APIs you've described and for saving reusable, pre-filled calls
(called *HTTP Config Requests*) that you or other modules can run on demand. It
also ships two Action plugins (so a call can run from Views Bulk Operations or
ECA), fires events around every request, defines a request-location plugin type,
and includes a Drush code generator to scaffold a new API description.

Because most of the setup lives in code rather than on a settings form, this
guide focuses on getting the module installed and on the admin UI it provides.
The declarative API files and PHP calling patterns are summarised under "How to
use it" below and covered in full in the sibling
[`agent/`](../agent/start.md) docs — which are the terse, token-cheap references
written for an AI coding agent. It has several third-party library dependencies
(pulled in automatically by Composer) and ships one optional example submodule.

## Contents

1. [Installation](installation/index.md) — install with Composer (note the
   third-party libraries it pulls in), enable it, and optionally turn on the
   example submodule.
2. [Configuration](configuration/index.md) — the admin UI: the API preview page,
   the settings form, and managing saved HTTP Config Requests.

## Where it lives in the admin menu

Once enabled, the module's admin area is at **Configuration → Web services →
HTTP Client Manager** (`/admin/config/services/http-client-manager`). You need
the **Administer HTTP Client Manager** (`administer http_client_manager`)
permission to reach it. This page is mainly for *previewing* the APIs you've
described in code and for managing saved requests — you don't define an API here.

## How to use it

The typical workflow is:

1. **Describe the API in code.** In a custom module, add a
   `MODULE.http_services_api.yml` file that gives the API an id, a title, an
   `api_path` pointing at a Guzzle service description (a JSON/YAML/PHP file
   listing the operations), and a `config` block with at least a `base_uri`
   (plus optional `timeout`, `auth`, headers). Don't want to write that by hand?
   Run `drush generate http_client_manager:service` (alias `http-service`) and
   the generator scaffolds all three files for you.

2. **Call an operation from PHP:**

   ```php
   $factory = \Drupal::service('http_client_manager.factory');
   $client  = $factory->get('my_api');            // an HttpClient for that API
   $result  = $client->call('FindPost', ['postId' => 1]);
   $data    = $result->toArray();
   ```

   You can also expose an API as its own injectable service by extending the
   abstract `http_client_manager.client_base` service.

3. **Point one API at different servers per environment.** Override any API's
   `base_uri` (or whitelist/blacklist which commands are available) from
   `settings.php` — handy for dev/stage/prod — as long as overriding is enabled
   in the module's settings.

4. **Save reusable calls.** A frequently-used, pre-filled call can be stored as
   an *HTTP Config Request* config entity and executed later with
   `->execute()`, run from the admin UI, or triggered as an Action.

For the full YAML structure, the client/factory API, the events, the
request-location plugin type and the API-wrapper facade pattern, see the
[`agent/`](../agent/start.md) docs.
