# HAL — manual setup guide

**HAL** (`hal`) adds a `hal_json` serialization format to Drupal that encodes
entities as [Hypertext Application Language](https://en.wikipedia.org/wiki/Hypertext_Application_Language)
— a JSON format that embeds hypermedia `_links` and `_embedded` sections so REST
clients can discover and follow the relationships between entities. When you
serialize a node, term, user, or comment to `hal_json`, each entity gains a
`_links` block (a `self` link, a `type` link identifying its bundle, and one
relation link per field), and any referenced entities are nested inline under
`_embedded`.

HAL was part of Drupal core through Drupal 9. It was removed from core in
Drupal 10 and lives here as a contrib module, so you enable it when you need the
`hal_json` format that older decoupled front‑ends, mobile apps, or
site‑to‑site content migrations already expect. It builds directly on core's
**Serialization** module, registering a set of normalizer services and a
`hal_json` encoder; it is almost always paired with core's **REST** module (and
optionally a Views REST export) to actually expose entities over HTTP.

This is a developer‑facing module — there is **no admin UI and nothing to click
through**. It works the moment you enable it: the `hal_json` format simply
becomes available to the serializer, to REST resources, and to Views REST
exports. The one and only setting is a single config value,
`hal.settings:link_domain`, which overrides the domain used when building link
URIs (leave it blank to use the site's own domain), and it has no form — you
set it in configuration or code if you need it. Because everything is done
through code and the serializer, the real detail lives in the agent docs.

This guide is written for a **human** getting the module installed and oriented.
If you want terse, token‑cheap API references for an AI coding agent, read the
sibling [`agent/`](../agent/start.md) docs instead — they cover the normalizers,
the `hal.link_manager` service, and the alter hooks in depth.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it alongside REST.

## Where it lives in the admin menu

Nowhere. HAL adds no menu items and no settings form. Once enabled it works
behind the scenes: the `hal_json` format becomes selectable wherever Drupal
offers serialization formats — most notably when you configure a REST resource
(**Configuration → Web services → REST** with the REST UI module) or a Views
REST export display.

## How to use it

Enable HAL together with core's **REST** module, then configure a REST resource
(or a Views REST export) to offer the `hal_json` format. From that point on,
requesting an entity with the `hal_json` format returns a HAL document:
referenced entities are embedded under `_embedded`, and every field carries a
stable relation URI under `_links` that documents what it represents. The same
normalizers run in reverse, so an incoming `hal_json` payload can be
denormalized back into a Drupal entity — which is what makes HAL a convenient
interchange format for migrating content between sites.

If your site runs behind a different internal host than the public one, set
`hal.settings:link_domain` to your canonical public domain so the generated
link URIs point at the right place. Developers can also rewrite the generated
type and relation URIs per request with the `hook_hal_type_uri_alter()` and
`hook_hal_relation_uri_alter()` hooks, or add a custom normalizer for a bespoke
field type — see the [`agent/`](../agent/start.md) docs.
