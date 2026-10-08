<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Search API OpenSearch AWS Signature Connector — agent index

Submodule of Search API OpenSearch. Adds ONE OpenSearch connector plugin, id **`aws_signature`**
(label "AWS Signature"), that signs requests to Amazon OpenSearch Service with AWS Signature v4
(SigV4) so a Search API OpenSearch server can talk to a managed AWS domain / use IAM access control.

- **Depends on:** `search_api_opensearch:search_api_opensearch`; requires the `aws/aws-sdk-php`
  library (its `hook_requirements()` blocks install if `Aws\Credentials\Credentials` is missing).
- **Configure route:** none of its own. The connector is selected on a Search API **server** in the
  parent module's backend form; its config lives in `search_api.server.<id>.backend_config`.
- **Permissions / drush / plugin types:** none. It only *provides* one instance of the parent's
  `opensearch_connector` plugin type (it does not define a plugin type).

## Solutions

- **Point a Search API OpenSearch server at Amazon OpenSearch Service with SigV4 signing** →
  [configure/connector.md](configure/connector.md)
- **Set AWS region / credentials, or defer to an IAM role / SDK credential chain** →
  [configure/connector.md](configure/connector.md)

Parent context: server/backend model →
[../../../../2.5.x/agent/configure/backend.md](../../../../2.5.x/agent/configure/backend.md);
connector plugin type →
[../../../../2.5.x/agent/plugins/plugin-types.md](../../../../2.5.x/agent/plugins/plugin-types.md).

## Key facts

- Connector id: `aws_signature` — class
  `Drupal\search_api_aws_signature_connector\Plugin\OpenSearch\Connector\AwsSignatureConnector`
  (extends `StandardConnector`, `#[OpenSearchConnector]` attribute).
- Config schema: `plugin.plugin_configuration.opensearch_connector.aws_signature`.
- Config keys: `url`, `ssl_verification` (both inherited), `api_key`, `api_secret`, `aws_region`.
- Client wiring: `getClientOptions()` adds an `auth_aws` option (`region` + optional `credentials`);
  the actual signing is done by `aws/aws-sdk-php`. Blank `api_key`+`api_secret` → SDK default
  credential chain. Empty `aws_region` → falls back to `us-east-1` at request time.
- No settings form, permissions, drush, events, hooks-of-note, or services beyond the plugin.
