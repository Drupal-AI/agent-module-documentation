<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# HTTP Response Headers — managing headers

## Admin UI & routes

The `response_header` config entity provides these routes (via `ResponseHeaderRouteProvider`
extending `AdminHtmlRouteProvider`):

| Route | Path | Purpose |
|---|---|---|
| `entity.response_header.collection` | `/admin/config/system/response-headers` | list (configure route) |
| `entity.response_header.add_form` | `/admin/config/system/response-headers/add` | add a header |
| `entity.response_header.edit_form` | `/admin/config/system/response-headers/{response_header}` | edit |
| `entity.response_header.delete_form` | `.../{response_header}/delete` | delete |
| `entity.response_header.enable` / `.disable` | `.../{response_header}/enable`\|`/disable` | toggle |

Permissions: `administer http response headers` (admin), plus `add http response headers`,
`edit http response headers`, `delete http response headers`.

## Config entity shape

Config name: `http_response_headers.response_header.<id>` (schema
`http_response_headers.response_header.*`):

```yaml
langcode: en
status: true                     # enabled?
id: x_frame_options
label: X-Frame-Options
description: 'Clickjacking protection…'
name: X-Frame-Options            # the ACTUAL HTTP header name
value: SAMEORIGIN                # the header value ('' / null ⇒ header is REMOVED)
visibility: {  }                 # map of core condition plugins (see below)
```

`config_export` keys: `id`, `label`, `description`, `name`, `value`, `visibility`
(`status` handled by the entity system).

## Add / change / remove a header

- **Add or change:** create/edit an entity with `name` = header, `value` = desired value,
  `status: true`.
- **Remove a header Drupal/PHP emits:** create an enabled entity whose `name` is that header
  and whose `value` is **empty** — the subscriber then deletes it from the response. The
  shipped `x_powered_by` and `x_generator` defaults work exactly this way (empty value).

Create one with Drush:

```bash
drush php:eval '
  \Drupal::entityTypeManager()->getStorage("response_header")->create([
    "id" => "hrh_frame_deny",
    "label" => "X-Frame-Options DENY",
    "name" => "X-Frame-Options",
    "value" => "DENY",
    "status" => TRUE,
  ])->save();
'
```

## Visibility conditions

`visibility` holds core **condition plugins** (same ones blocks use: request path, user
role, content type, language, …). At response time **all** conditions must pass (AND) for
the header to be applied. Empty `visibility` = always applies. Missing context or values
cause the header to be skipped for that response.

## Shipped default headers (optional config)

Enabling the module installs ten `response_header` configs you can turn on/tune:
`access_control_allow_origin`, `content_security_policy`, `public_key_pins`, `referrer_policy`,
`strict_transport_security`, `x_content_type_options`, `x_frame_options` (SAMEORIGIN),
`x_generator` (empty ⇒ removes), `x_powered_by` (empty ⇒ removes), `x_xss_protection`.
