# JSON:API Resources — manual setup guide

**JSON:API Resources** (`jsonapi_resources`) is a **developer framework** that
lets a module define its own JSON:API-compliant endpoints at routes of your
choosing. Drupal core's JSON:API auto-generates routes for every entity type, but
it won't let you create custom URLs. This module fills that gap: you can return
exactly the collection, aggregate, or shaped payload a decoupled front end needs,
while still emitting standards-compliant JSON:API documents that reuse existing
resource types.

This is a tool for developers, not a click-and-configure feature. Enabling the
module exposes **nothing** on its own — it ships no routes, resources, config,
permissions, or Drush commands. Instead it provides an authoring convention: you
declare an ordinary route in your module's `*.routing.yml`, but instead of a
`_controller` default you use a `_jsonapi_resource` default that names a PHP
class (or a service id). That class extends
`Drupal\jsonapi_resources\Resource\ResourceBase` (or a subclass) and implements a
public `process()` method that builds and returns the JSON:API response.

Three base classes climb in capability: **`ResourceBase`** works with any data
source (a config object, a remote API, a computed value); **`EntityResourceBase`**
adds helpers to turn entities into resource objects with access checks; and
**`EntityQueryResourceBase`** gives you entity-query collections with JSON:API
filtering, sorting, and pagination built in. One important caveat: much of the
module's code lives in an `Unstable\` namespace that is explicitly **not** part
of the public API — only the `ResourceBase` family (outside `Unstable`) is safe
to depend on.

This guide is written for a **human** setting the module up. Because this is a
code-first framework, the practical "how to build a resource" reference lives in
the sibling [`agent/`](../agent/start.md) docs — start with
[`agent/api/extend.md`](../agent/api/extend.md).

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module (core JSON:API is the only dependency).

## Where it lives in the admin menu

Nowhere — there is no admin UI and no settings page (`configure` is `null`). You
work entirely in code: routing files and PHP resource classes.

## How to use it

At a high level, defining a custom JSON:API endpoint looks like this:

1. Enable the module (see [Installation](installation/index.md)).
2. In your custom module's `*.routing.yml`, declare a route whose path **begins
   with `/%jsonapi%`** (a placeholder the module rewrites to your site's JSON:API
   base path, `/jsonapi` by default). Instead of a `_controller` default, set
   `_jsonapi_resource` to your resource class (or a service id), and declare a
   `_jsonapi_resource_types` array listing the resource types the route may emit.
   Add access requirements (`_permission`, `_entity_access`, `_custom_access`,
   and so on) exactly as you would on any route.
3. Write the resource class extending `ResourceBase` (or `EntityResourceBase` /
   `EntityQueryResourceBase`) with a public `process(Request $request, …)`
   method. Inside it, build a `ResourceObjectData` and return it via the
   inherited `createJsonapiResponse()`, which produces a cache-aware response
   that JSON:API normalizes.
4. Clear caches so the route is registered. The endpoint is now live at your
   chosen URL, speaking the JSON:API media type your client already understands.

Typical uses include a `/jsonapi/featured-content` collection, a `/jsonapi/me`
endpoint returning the current user, cross-entity aggregates that core JSON:API
can't express in one request, or a `POST` route that creates an entity with extra
server-side logic. For the full field-by-field authoring details, method
signatures, and examples, see
[`agent/api/extend.md`](../agent/api/extend.md).
