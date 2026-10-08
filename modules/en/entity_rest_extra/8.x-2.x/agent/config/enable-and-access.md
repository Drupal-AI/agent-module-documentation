<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Enabling, access, serialization

The module ships no `.routing.yml`, `.permissions.yml`, `.services.yml`, or `config/` directory. All
of that is provided by Drupal's REST framework once a resource is enabled — this module only supplies
the three `@RestResource` plugins (see [../plugins/rest-resources.md](../plugins/rest-resources.md)).

## Install / enable

```bash
composer require drupal/entity_rest_extra
drush en entity_rest_extra -y
```

Dependencies (from `entity_rest_extra.info.yml`): core `serialization` and contrib `restui`
(`drupal:serialization`, `restui:restui`). Enabling the module makes the plugins available but does
not expose any route yet — a resource has no route until it is turned on in the REST config.

## Turning resources on

Each plugin becomes a live route only when a `rest_resource_config` config entity enables it. The
`restui` module provides the UI at **Configuration → Web services → REST**
(`/admin/config/services/rest`). Per resource you select the HTTP method (`GET`), one or more
authentication providers (e.g. `cookie`, `basic_auth`, or an OAuth provider), and the accepted
serialization formats — `json` is the recommended/typical choice. Core's `rest.resource_routes`
route subscriber then generates the route for the plugin's `canonical` `uri_paths`.

## Access model

The plugins do not override `ResourceBase::permissions()`, so core auto-generates a permission per
method: `restful get <plugin_id>` — i.e. `restful get entity_bundles`,
`restful get bundle_view_modes`, and `restful get Entity Bundle Resource Label`. Core adds that
permission as the route's requirement, so a caller must be authenticated by one of the enabled
providers and hold the resource's permission (assigned under **People → Permissions**). The `get()`
methods themselves do no additional per-entity checks — they return entity-type/bundle
**configuration** (bundle info, `field_config`/`field_storage` definitions, view-mode config), not
entity content.

## Serialization

All three `get()` methods return a `ResourceResponse` wrapping a plain PHP array. Core's serializer
(from the `serialization` dependency) renders it to the requested `_format` (e.g. `?_format=json`).
The bundles response for `node` additionally includes each type's description; the fields response
serializes `FieldConfig` and field-storage definition objects per field.

## Calling the endpoints

```
GET /entity/node/bundles?_format=json
GET /entity/node/article/view_modes?_format=json
GET /entity/node/article/fields?_format=json
```

Send credentials for whichever authentication provider was enabled on the resource.
