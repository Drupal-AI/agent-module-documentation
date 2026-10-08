# Hooks & runtime signing (API)

The module implements exactly two hooks and defines one constant. It has no services, controllers or
plugins — the "API" is the two hooks plus the config keys they read.

## Constant

```php
// elasticsearch_aws_connector.module:13
const ELASTICSEARCH_AWS_CONNECTOR_AWS_SR_KEY = 'elasticsearch_aws_connector_aws_signed_requests';
```

This string is both the machine value of the added authentication-type option and the per-host `auth`
`method` that triggers signing.

## 1. Form alter — `hook_form_FORM_ID_alter`

`elasticsearch_aws_connector_form_elasticsearch_cluster_form_alter($form, $form_state, $form_id)`
(`.forms.inc:15`, loaded via `include_once` from `.module:15`). Alters form id
`elasticsearch_cluster_form` (owned by `elasticsearch_connector`) to add the AWS auth type and the
region / auth-type / key / secret fields, and appends a validate callback. See
[../configure/cluster.md](../configure/cluster.md) for the field table.

## 2. Options alter — `hook_elasticsearch_connector_load_library_options_alter`

`elasticsearch_aws_connector_elasticsearch_connector_load_library_options_alter(array &$options, Cluster $cluster)`
(`.module:20`). This is an **alter hook invoked by `elasticsearch_connector`** while it assembles the
Elasticsearch PHP client options for a cluster. This module's job is to inject a signing `handler`.

Control flow:

1. Return early if `$options['auth']` is not set (no authentication configured) — `.module:22-24`.
2. Loop `$options['hosts']`; if any host's `$options['auth'][$url]['method']` equals
   `ELASTICSEARCH_AWS_CONNECTOR_AWS_SR_KEY`, set `$sign_requests = TRUE` — `.module:29-33`.
3. Return if no host requested signing — `.module:36-38`.
4. Return (with a status message) if `$cluster->options['elasticsearch_aws_connector_aws_region']` is
   empty — `.module:41-44`.
5. Build the handler from the AWS auth type — `.module:46-55`:

```php
$aws_region = $cluster->options['elasticsearch_aws_connector_aws_region'];
if ($cluster->options['elasticsearch_aws_connector_aws_authentication_type'] == 'aws_credentials') {
  // Explicit key + secret from the Cluster config entity.
  $provider = CredentialProvider::fromCredentials(
    new Credentials(
      $cluster->options['elasticsearch_aws_connector_aws_credentials_key'],
      $cluster->options['elasticsearch_aws_connector_aws_credentials_secret']
    )
  );
  $options['handler'] = new ElasticsearchPhpHandler($aws_region, $provider);
}
else {
  // aws_role: no provider → AWS SDK default credential provider chain
  // (env vars / shared config / EC2·ECS·EKS instance role).
  $options['handler'] = new ElasticsearchPhpHandler($aws_region);
}
```

`ElasticsearchPhpHandler` (from `jsq/amazon-es-php`) is a request handler that SigV4-signs each
outgoing request with the resolved credentials for the given region, then delegates the HTTP call.
The module sets only `$options['handler']`; it does not touch transport/TLS options — those remain
whatever `elasticsearch_connector` and the underlying SDK/Guzzle default to.

## Config keys read at runtime

All read from the `elasticsearch_connector` Cluster config entity's `options` array:

| Key | Values | Used for |
|---|---|---|
| `elasticsearch_aws_connector_aws_region` | e.g. `eu-west-1` | region passed to the handler; required (else handler is not attached) |
| `elasticsearch_aws_connector_aws_authentication_type` | `aws_credentials` \| `aws_role` | selects explicit-credentials vs default-chain path |
| `elasticsearch_aws_connector_aws_credentials_key` | AWS access key id | only in the `aws_credentials` path |
| `elasticsearch_aws_connector_aws_credentials_secret` | AWS secret access key | only in the `aws_credentials` path |

## No other integrator surface

No routes, no `*.services.yml`, no permissions, no plugin managers, no drush, no events, no
`config/schema`. To extend behaviour you implement `hook_elasticsearch_connector_load_library_options_alter`
yourself in another module, or set the Cluster `options` programmatically (see
[../configure/cluster.md](../configure/cluster.md)).
