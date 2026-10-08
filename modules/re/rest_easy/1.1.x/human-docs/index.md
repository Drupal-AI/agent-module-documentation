# REST Easy — manual setup guide

**REST Easy** (`rest_easy`) is a developer framework for building custom RESTful API
endpoints in Drupal with far less boilerplate than the usual approach. Rolling your
own API in Drupal normally scatters the pieces across several files — an
authentication plugin here, a controller there, route definitions in a YAML file,
OpenAPI documentation somewhere else. REST Easy pulls those moving parts together
behind a small set of plugin attributes, so you define an endpoint — its route, the
parameters it accepts, how they are validated, the output it produces, and its
documentation — in one place.

It is worth being clear about what this module is and is not. REST Easy is a
**toolkit for developers**: on its own it exposes no endpoints and does nothing a
site builder can click together in the admin UI. You get value from it by writing
PHP — three related plugin types (**API**, **Endpoint**, and **Parameter**) that
you place in your own module. An **API** plugin declares where a group of endpoints
lives (base path, authentication, tags, version); an **Endpoint** plugin declares a
single route and its `call()` method that produces the response; a **Parameter**
plugin declares an input the endpoint accepts and how it is validated. When your
module is enabled, REST Easy registers the routes for you.

Because the endpoints are yours, **their security is yours too**. REST Easy wires
each endpoint through a `_custom_access` callback and an access event, but it does
not decide who may call your endpoint — you supply that authorization logic. Treat
every endpoint you write as public until you have added and tested its access
check.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module (and where to write your API code).

There is **no configuration page** for REST Easy itself — it is a framework you
build on in code, not a form you fill in. If you also enable its optional OpenAPI
integration, your generated API documentation appears under **Configuration → Web
services → OpenAPI** (that page is provided by the OpenAPI module, not by REST Easy).

## How to use it

At a high level, building an API with REST Easy means adding three kinds of plugin
class to your own module, each marked with a REST Easy attribute:

1. **An API plugin** (`Plugin/rest_easy/API/…`) with a `#[RESTEasyAPI(...)]`
   attribute — sets the API's id, label, base path, authentication, default
   permission, produced content types, tags and version.
2. **One Endpoint plugin per endpoint** (`Plugin/rest_easy/Endpoint/…`) with a
   `#[RESTEasyEndpoint(...)]` attribute — sets the path, HTTP methods, the
   parameters it uses, expected responses and tags, and implements `call()` to
   return the response (JSON by default).
3. **One Parameter plugin per input** (`Plugin/rest_easy/Parameter/…`) with a
   `#[RESTEasyParameter(...)]` attribute — sets the parameter's type, location
   (`query`, etc.), default, whether it is required, and an optional `validate()`
   method. Parameters can be reused across endpoints.

Enable your module and REST Easy registers the routes defined by the API base path
and endpoint paths. The full annotated code templates for each of these three
classes are in the module's own project page and README.
