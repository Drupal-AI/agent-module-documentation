<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# webform_rest — enabling resources & settings

The module ships five REST resource **plugins** but activates none of them. Like every core
REST resource, each is turned on by a `rest_resource_config` **config entity**
(`rest.resource.<id>`) that declares allowed **methods**, **formats**, and **authentication**
providers. There is **no dedicated UI** — use one of the three ways below.

Plugin ids: `webform_rest_elements`, `webform_rest_fields`, `webform_rest_submit`,
`webform_rest_submission`, `webform_rest_complete_submission`.

## Option A — REST UI module (recommended for humans)

```
composer require drupal/restui && drush en restui -y
```
Then visit `/admin/config/services/rest`, find e.g. "Webform Submit", enable it, and tick the
methods / formats / auth providers. (`webform_rest`'s install hook nudges you to install it.)

## Option B — programmatically (drush php:eval / a deploy hook)

```php
use Drupal\rest\Entity\RestResourceConfig;
RestResourceConfig::create([
  'id' => 'webform_rest_submit',          // == plugin_id, dots not allowed in the id
  'plugin_id' => 'webform_rest_submit',
  'granularity' => 'resource',            // 'resource' = same methods/formats/auth for all
  'configuration' => [
    'methods' => ['POST'],                // GET for elements/fields; GET+PATCH for submission
    'formats' => ['json'],                // and/or 'xml', 'hal_json' (needs the hal module)
    'authentication' => ['cookie'],       // and/or 'basic_auth' (module), 'oauth2', …
  ],
])->save();
```
Delete (disable) with:
`\Drupal::entityTypeManager()->getStorage('rest_resource_config')->load('webform_rest_submit')->delete();`

## Option C — config YAML (`config/sync`, or a module's `config/install`)

`rest.resource.webform_rest_submit.yml`:
```yaml
langcode: en
status: true
dependencies:
  module:
    - serialization
    - user
    - webform_rest
id: webform_rest_submit
plugin_id: webform_rest_submit
granularity: resource
configuration:
  methods:
    - POST
  formats:
    - json
  authentication:
    - cookie
```
Import with `drush config:import` (or `drush config:set` the single object). After any change,
`drush cr` so the dynamic REST routes rebuild.

Note: the client must also have the relevant Webform permissions (e.g. "access any webform
submission", or submission-create access for the target webform) — enabling the resource only
opens the route.

## Settings form + permission

`webform_rest.settings` route → `/admin/webform_rest/settings`, gated by the permission
**`access webform rest settings`**. One field: **Confirmation Settings**
(`confirmation_settings`, checkbox). When on, the `POST /webform_rest/submit` response includes
the webform's confirmation `type`/`url`/`message`/`title`/attributes in addition to the `sid`;
off (default) returns only `{ "sid": ... }`.

```
drush cset webform_rest.settings confirmation_settings 1 -y
```
