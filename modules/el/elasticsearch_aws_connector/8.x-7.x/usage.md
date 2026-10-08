<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Elasticsearch AWS Connector lets the Elasticsearch Connector module talk to an Amazon-managed Elasticsearch or OpenSearch domain by signing each request with AWS Signature Version 4.

---

Amazon's managed Elasticsearch/OpenSearch controls access with **IAM** and requires every request to be **SigV4-signed**, which a stock `elasticsearch_connector` cluster does not do — so this thin glue module supplies the signing. It adds nothing you visit directly: install it alongside `elasticsearch_connector` (`composer require drupal/elasticsearch_aws_connector`, `drush en elasticsearch_aws_connector`), then edit your cluster at **Configuration → Search and metadata → Elasticsearch Connector**, turn on **Use authentication**, and pick the new authentication type **"Amazon Web Services - signed requests"**. That reveals an **AWS region** field (for example `eu-west-1` or `us-west-2`) and an **AWS authentication type** selector with two choices: **AWS IAM Role** (`aws_role`, the default — the site's ambient AWS credentials from an EC2/ECS/EKS instance role, environment, or shared config are used, so nothing is entered) and **AWS Credentials** (`aws_credentials` — you supply an access **key** and **secret**). On save, whenever `elasticsearch_connector` builds its client for a host whose auth method is the AWS-signed-requests type and a region is set, this module attaches an `ElasticsearchPhpHandler` (from the `jsq/amazon-es-php` library) that signs the outgoing request; if the region is left empty it shows *"One must configure the AWS region."* and does not sign. Version **8.x-7.2** targets the Elasticsearch 7 series — confirm that matches what your AWS domain actually runs, since OpenSearch forked from Elasticsearch at 7.10.

---

- Connect a Drupal site to Amazon OpenSearch Service.
- Connect a Drupal site to Amazon Elasticsearch Service.
- Sign Elasticsearch Connector requests with AWS SigV4.
- Add "Amazon Web Services - signed requests" as a cluster auth type.
- Authenticate search traffic to a managed AWS domain via IAM.
- Use an EC2/ECS/EKS instance IAM role for search access.
- Use an explicit AWS access key and secret when no role is available.
- Set the AWS region for a signed Elasticsearch cluster.
- Run Search API + Elasticsearch Connector against AWS OpenSearch.
- Avoid running and patching your own Elasticsearch servers.
- Point an existing Elasticsearch Connector cluster at an AWS endpoint.
- Support a cloud-hosted search backend.
- Sign search requests from inside a container or serverless task.
- Support a multi-account or multi-region AWS search setup.
- Keep search traffic within the AWS IAM access model.
- Integrate a Drupal search index with a managed search cluster.
- Switch a cluster between IAM-role and explicit-credential authentication.
- Configure signed requests entirely from the connector's cluster form.
