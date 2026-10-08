<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Elasticsearch AWS Connector (elasticsearch_aws_connector) — agent index

Lets `elasticsearch_connector` talk to an **Amazon-managed Elasticsearch / OpenSearch domain** by
signing every request with **AWS Signature Version 4**. It is a thin glue module: two procedural hook
implementations, no routes/services/plugins of its own. It (1) adds an authentication type
**"Amazon Web Services - signed requests"** to the Elasticsearch Connector *cluster* form (with AWS
region + AWS credentials/role fields), and (2) on library-options build, swaps in a signing
**request handler** (`Aws\ElasticsearchService\ElasticsearchPhpHandler` from `jsq/amazon-es-php`) so
the AWS SDK signs the outgoing request. Region and credentials are stored in the Cluster entity's
`options` array; the handler is only attached when a host's auth method is the AWS-signed-requests
type and a region is set.

- Depends on: `elasticsearch_connector:elasticsearch_connector`. Composer libs:
  `drupal/elasticsearch_connector ^7.0-alpha2`, `jsq/amazon-es-php ^0.3.0` (the AWS ES PHP handler).
- Core: `^8.8 || ^9 || ^10 || ^11`. Package: `Elasticsearch`. Version **8.x-7.2** (installed/enabled).
- **No dedicated settings page / `configure` route.** All configuration is done inline on the
  Elasticsearch Connector cluster form (`elasticsearch_cluster_form`). No permissions, no drush, no
  plugin types, no config schema of its own (the AWS keys are stored as untyped keys on the Cluster
  config entity).
- Two AWS auth modes: **`aws_role`** (default fallback — uses the AWS SDK default credential provider
  chain: env vars / shared config / EC2·ECS·EKS instance role, no secret stored) and
  **`aws_credentials`** (an explicit access key + secret entered on the form).

## What you'd do → where

- **Point a cluster at an AWS domain / choose signed-requests + region + role-vs-keys** →
  [configure/cluster.md](configure/cluster.md)
- **Understand the two hooks, the signing handler, and the config keys read at runtime** →
  [api/hooks.md](api/hooks.md)

## Key facts (real machine names)

- Hooks implemented:
  - `hook_form_FORM_ID_alter` → `elasticsearch_aws_connector_form_elasticsearch_cluster_form_alter`
    (`.forms.inc:15`) — alters form id `elasticsearch_cluster_form`; adds a validate callback
    `elasticsearch_aws_connector_form_elasticsearch_cluster_form_validate` (`.forms.inc:93`).
  - `hook_elasticsearch_connector_load_library_options_alter` →
    `elasticsearch_aws_connector_elasticsearch_connector_load_library_options_alter` (`.module:20`) —
    an alter hook *invoked by* `elasticsearch_connector` when it builds client options.
- Constant: `ELASTICSEARCH_AWS_CONNECTOR_AWS_SR_KEY = 'elasticsearch_aws_connector_aws_signed_requests'`
  (`.module:13`) — the machine value of the added authentication-type option.
- Cluster `options` keys written/read: `elasticsearch_aws_connector_aws_region`,
  `elasticsearch_aws_connector_aws_authentication_type` (`aws_credentials` | `aws_role`),
  `elasticsearch_aws_connector_aws_credentials_key`, `elasticsearch_aws_connector_aws_credentials_secret`.
- External classes used: `Aws\Credentials\CredentialProvider`, `Aws\Credentials\Credentials`,
  `Aws\ElasticsearchService\ElasticsearchPhpHandler`, `Drupal\elasticsearch_connector\Entity\Cluster`.
- No routes, services, permissions, plugins, render elements, libraries, templates, `.install`, or
  `config/` in this module.
