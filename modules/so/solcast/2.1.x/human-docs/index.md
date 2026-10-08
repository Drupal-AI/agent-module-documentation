# Solcast — manual setup guide

**Solcast** (`solcast`) wires the [Solcast](https://solcast.com) solar
resource and forecasting REST API into Drupal as a ready-to-use HTTP client.
Solcast is a commercial service that sells solar irradiance and PV-power
estimates and forecasts; rather than making you hand-write a Guzzle client, this
module ships a declarative service description so your own code can fetch a
configured client and call named commands against the API.

Under the hood it registers a service with the **HTTP Client Manager** module
(its one dependency) whose base address is fixed to `https://api.solcast.com.au`
over HTTPS, plus a set of resource definitions for the "rooftop sites"
forecasts, recent estimated-actuals, and a data dictionary. This is a
**developer integration surface** — it adds no pages, blocks or permissions of
its own. Once enabled, an extra entry for the Solcast API appears on the HTTP
Client Manager overview at `/admin/config/services/http-client-manager`, and
calling code pulls the client from the `http_client_manager` factory.

Authentication is deliberately kept out of the base module. The optional
**API Key** submodule (`solcast_key`) stores your Solcast token in a Key entity
and attaches it as an `Authorization` header automatically, so the secret never
lives in code or exported config. A second optional submodule, **ECA**
(`solcast_eca`), adds an ECA action for calculating a forecast interval start so
no-code ECA models can drive Solcast calls. To use the service you will need a
Solcast account, which supplies a token and a `resourceId` (the UUID of your
roof).

This guide is written for a **human** setting the module up. If you want terse,
token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer alongside HTTP
   Client Manager, enable the module, and turn on the optional submodules.

## How to use it

There is no settings form to fill in. After you enable the module (and, in
practice, the `solcast_key` submodule for authentication), your custom code or an
ECA model obtains the named client from the `http_client_manager` factory service
and calls the command that matches the resource you want — the rooftop-site
`forecasts` for forward-looking PV/irradiance data, `estimated_actuals` for
recent modelled output, or the `data_dictionary` to discover available fields.
All traffic goes over HTTPS to the fixed Solcast base URI, and activity is logged
to a dedicated `solcast` logger channel.
