<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configure the `aws_signature` connector

This submodule adds one OpenSearch connector plugin, id **`aws_signature`**, label **"AWS Signature"**.
It is not configured on its own page — it is selected on an OpenSearch-backed Search API **server**
and its settings live inside that server's `backend_config`. See the parent module's server/backend
model in [../../../../../2.5.x/agent/configure/backend.md](../../../../../2.5.x/agent/configure/backend.md)
and the connector plugin type in
[../../../../../2.5.x/agent/plugins/plugin-types.md](../../../../../2.5.x/agent/plugins/plugin-types.md).

Class: `Drupal\search_api_aws_signature_connector\Plugin\OpenSearch\Connector\AwsSignatureConnector`
(extends the parent's `StandardConnector`). Discovered via the `#[OpenSearchConnector]` attribute in
`src/Plugin/OpenSearch/Connector/`.

## When to use it

Use this connector when the OpenSearch endpoint is **Amazon OpenSearch Service** (managed AWS) and the
domain requires AWS Signature Version 4 (SigV4) signed requests / IAM access control instead of basic
auth. For a plain or basic-auth cluster, use the parent's `standard` / `basicauth` connectors.

## Config keys

Schema: `plugin.plugin_configuration.opensearch_connector.aws_signature`
(`config/schema/search_api_opensearch.connector.aws_signature.schema.yml`).

| Key | Type | Default | Meaning |
| --- | --- | --- | --- |
| `url` | string | `''` | OpenSearch domain endpoint, e.g. `https://search-mydomain.eu-west-1.es.amazonaws.com` (no trailing slash). Required; inherited from `StandardConnector`. |
| `ssl_verification` | boolean | `TRUE` | Verify the endpoint's TLS certificate. Inherited from `StandardConnector`; leave enabled. |
| `api_key` | string | `''` | AWS access key id. Optional — see below. |
| `api_secret` | string | `''` | AWS secret access key. Optional — see below. |
| `aws_region` | string | `''` | AWS region of the domain, e.g. `eu-west-1`. Falls back to `us-east-1` at request time if empty. |

Only `api_key`, `api_secret`, `aws_region` are added by this submodule; `url` and `ssl_verification`
come from the parent connector. The form (`buildConfigurationForm()`) renders all five as text fields;
`submitConfigurationForm()` `trim()`s the three AWS values before saving.

## How the credentials are used

`getClientOptions()` builds on `parent::getClientOptions()` (which sets `base_uri` = `url` and
`verify` = `ssl_verification`) and adds an `auth_aws` option consumed by the OpenSearch PHP client:

```php
$options = parent::getClientOptions() + [
  'auth_aws' => ['region' => $this->configuration['aws_region'] ?? 'us-east-1'],
];
// Explicit keys only added when BOTH are non-empty; otherwise the AWS SDK
// default credential provider chain is used (env vars, ~/.aws, IAM role, etc.).
if ('' !== $this->configuration['api_key'] && '' !== $this->configuration['api_secret']) {
  $options['auth_aws']['credentials'] = [
    'access_key' => $this->configuration['api_key'],
    'secret_key' => $this->configuration['api_secret'],
  ];
}
```

Key behavior to know:
- **Leave `api_key`/`api_secret` blank to use the AWS SDK default credential chain** (environment
  variables, shared config file, or the instance/task IAM role). Explicit keys are attached only when
  BOTH fields are set — a key with an empty secret (or vice versa) is ignored and the chain is used.
- `aws_region` defaults to `us-east-1` only at client-build time; set it explicitly for other regions.
- The signing itself is performed by `aws/aws-sdk-php` through the client's `auth_aws` handler — this
  module only assembles the options. `getClient()` / `createClient()` (and the `ClientOptionsEvent`
  dispatch) are inherited unchanged from `StandardConnector`.

## Requirements

- Depends on the parent module `search_api_opensearch:search_api_opensearch`.
- `hook_requirements()` (install phase) hard-blocks install with `REQUIREMENT_ERROR` if the
  `aws/aws-sdk-php` library is missing (checks `class_exists(Aws\Credentials\Credentials::class)`).
  Install it with `composer require aws/aws-sdk-php` (the parent lists it under composer `suggest`).

## Set it via drush / PHP

There is no settings form of its own. Configure the connector on the server config entity
`search_api.server.<id>`. The connector id lives at `backend_config.connector` and its values at
`backend_config.connector_config`.

Prefer keeping AWS values out of exported config by setting them in `settings.php` overrides
(the field descriptions in the UI point at exactly these keys):

```php
// settings.php — <id> is the Search API server machine name.
$config['search_api.server.<id>']['backend_config']['connector'] = 'aws_signature';
// NOTE: the real config key is 'url'. The UI field description mislabels the
// settings.php override as ['connector_config']['uri'], but the connector reads
// $this->configuration['url'] — use 'url' here.
$config['search_api.server.<id>']['backend_config']['connector_config']['url'] = 'https://search-mydomain.eu-west-1.es.amazonaws.com';
$config['search_api.server.<id>']['backend_config']['connector_config']['aws_region'] = 'eu-west-1';
$config['search_api.server.<id>']['backend_config']['connector_config']['api_key'] = getenv('AWS_ACCESS_KEY_ID');
$config['search_api.server.<id>']['backend_config']['connector_config']['api_secret'] = getenv('AWS_SECRET_ACCESS_KEY');
```

Or set the region on the saved config entity with drush:

```bash
drush config:set search_api.server.<id> backend_config.connector aws_signature -y
drush config:set search_api.server.<id> backend_config.connector_config.aws_region eu-west-1 -y
```

To let an EC2/ECS IAM role supply credentials, set only `connector`, `uri` and `aws_region` and leave
`api_key`/`api_secret` empty so the SDK default chain resolves the role.
