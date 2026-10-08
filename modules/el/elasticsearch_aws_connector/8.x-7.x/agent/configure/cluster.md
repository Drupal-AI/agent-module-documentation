# Configure a cluster for AWS signed requests

There is **no module settings page**. All configuration is added to the existing **Elasticsearch
Connector cluster form** (`elasticsearch_cluster_form`, at
`admin/config/search/elasticsearch-connector/cluster/...`) by
`elasticsearch_aws_connector_form_elasticsearch_cluster_form_alter` (`.forms.inc:15`). The values are
saved into the Cluster config entity's `options` array — this module ships no config of its own.

## Fields added to the cluster form

The alter runs only when the cluster form exposes an `authentication_type` select (i.e. "Use
authentication" is on). It then registers a new authentication type and four dependent fields.

| Form element (`options[...]`) | `#type` | Machine value / options | Shown when |
|---|---|---|---|
| `authentication_type` (existing select, extended) | select | adds option `elasticsearch_aws_connector_aws_signed_requests` labelled *"Amazon Web Services - signed requests"* | always (extends the connector's select) |
| `username`, `password` (existing) | — | hidden via `#states` | hidden when auth type = AWS signed requests |
| `elasticsearch_aws_connector_aws_region` | textfield | free text (e.g. `eu-west-1`, `us-west-2`) | auth type = AWS signed requests |
| `elasticsearch_aws_connector_aws_authentication_type` | select | `aws_credentials` \| `aws_role` (default `aws_role`) | auth type = AWS signed requests |
| `elasticsearch_aws_connector_aws_credentials_key` | textfield | AWS access key id | auth type = AWS signed requests **and** AWS auth type = `aws_credentials` |
| `elasticsearch_aws_connector_aws_credentials_secret` | textfield | AWS secret access key | auth type = AWS signed requests **and** AWS auth type = `aws_credentials` |

The show/hide is pure client-side `#states` keyed off `options[authentication_type]` and
`options[elasticsearch_aws_connector_aws_authentication_type]`.

## AWS authentication types

- **`aws_role` (default fallback)** — no key/secret is entered. At runtime the module builds the
  signing handler with no explicit provider, so the AWS SDK's **default credential provider chain**
  supplies credentials (environment variables, shared config file, or an EC2/ECS/EKS instance role).
  Nothing is stored in Drupal.
- **`aws_credentials`** — you enter an access **key** and **secret**; both are saved on the Cluster
  entity and used to build an explicit credential provider. (See `api/hooks.md` for the exact runtime
  wiring.)

## Validation

`elasticsearch_aws_connector_form_elasticsearch_cluster_form_validate` (`.forms.inc:93`) is the only
validation this module adds: if a region was entered it is `strtolower(trim(...))`-normalised and
written back to `options`. There is no validation of the key/secret or the region format.

## Set it from code

The values live on the `elasticsearch_connector` Cluster config entity's `options`:

```php
$cluster = \Drupal\elasticsearch_connector\Entity\Cluster::load('my_cluster');
$options = $cluster->options;
// One host must already declare the AWS-signed-requests auth method for the handler to attach.
$options['elasticsearch_aws_connector_aws_region'] = 'eu-west-1';
$options['elasticsearch_aws_connector_aws_authentication_type'] = 'aws_role'; // or 'aws_credentials'
// Only for aws_credentials:
// $options['elasticsearch_aws_connector_aws_credentials_key'] = getenv('AWS_ACCESS_KEY_ID');
// $options['elasticsearch_aws_connector_aws_credentials_secret'] = getenv('AWS_SECRET_ACCESS_KEY');
$cluster->options = $options;
$cluster->save();
```

If the region is missing at runtime the module aborts handler attachment and shows a status message
*"One must configure the AWS region."* (`.module:41-44`).
