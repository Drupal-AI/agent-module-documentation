# Configuration

Most of what makes HTTP Client Manager work — the API definitions themselves —
lives in code (the `*.http_services_api.yml` files and Guzzle service
descriptions described on the [overview page](../index.md)). The admin UI does
**not** create APIs; it lets you *inspect* the ones you've described, adjust one
override switch, and manage saved requests. Everything here requires the
**Administer HTTP Client Manager** (`administer http_client_manager`) permission.

## Open the admin area

1. Log in as a user with the *Administer HTTP Client Manager* permission (an
   administrator by default).
2. Go to **Configuration → Web services → HTTP Client Manager**, or navigate
   directly to `/admin/config/services/http-client-manager`.

## The preview page

The landing page is a **preview / inspection** tool. It lists the APIs you've
declared in code and lets you drill into each one to see its available commands
(operations) and the parameters each command expects. Use it to confirm that a
service description you just wrote was discovered correctly, and to check
parameter names before you wire up code or build a saved request. Nothing here
changes the API definition — it's read-only inspection.

## The settings form

At `/admin/config/services/http-client-manager/settings` there is a small
settings form with one meaningful option:

- **Enable overriding service definitions** — when on (the default), your API
  definitions may be overridden per environment, either from `settings.php`
  (for example to point a logical API at a different `base_uri` on staging, or to
  whitelist/blacklist which commands are available) or from the module's own
  stored overrides. Turn it off if you want the definitions declared in code to
  be authoritative and immune to override. If you rely on per-environment base
  URLs, leave it enabled.

Click **Save configuration** to store the change.

## HTTP Config Requests — saved, reusable calls

An **HTTP Config Request** is a saved configuration entity that pins a specific
API + command + a fixed set of parameters together under a label, so the call can
be run again without repeating the parameters. For example, "Find post 1" might
save the `example_services` API, the `FindPost` command and `postId: 1`.

You manage these from the admin area (they hang off each API's command in the UI,
at paths under
`/admin/config/services/http-client-manager/{serviceApi}/{command}/http-config-request`).
From there you can **add**, **edit**, **delete** and **execute** a saved request.
Each request stores:

- **Id** and **Label** — the machine name and human name.
- **Service API** — which described API it belongs to.
- **Command** — which operation of that API to run.
- **Parameters** — the fixed values passed to the command. Parameter values may
  contain Drupal **tokens** (for example `[current-user:uid]`), which are
  resolved each time the request runs — so a "saved" request can still be
  user- or context-specific.

Because they're config entities, saved requests are exportable: they end up in
your configuration (as `http_client_manager.http_config_request.<id>`) and deploy
between environments like any other config.

### Running a saved request elsewhere

Beyond the UI's *execute* link, a saved request can be run from code
(`HttpConfigRequest::load('<id>')->execute()`) or fired as a Drupal **Action**
via the `http_client_manager_preconfigured_request` plugin — which means it can
be attached to Views Bulk Operations, ECA workflows, and similar. A companion
`http_client_manager_command` action runs an arbitrary command directly. These
Action integrations are aimed at developers and site builders comfortable with
Drupal's Actions system; see the [`agent/`](../agent/start.md) docs for details.
