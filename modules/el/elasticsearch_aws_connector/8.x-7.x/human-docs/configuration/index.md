# Configuration

This module has no settings page of its own. Its configuration happens on the
**Elasticsearch Connector** cluster form, where it adds "Amazon Web Services -
signed requests" as an authentication option.

## Configure the cluster to use signed requests

1. Go to your Elasticsearch Connector cluster configuration (**Configuration →
   Search and metadata → Elasticsearch Connector**) and add or edit the cluster
   that points at your AWS domain.
2. Turn on **Use authentication**.
3. For **Authentication type**, choose **Amazon Web Services - signed requests**.
4. Fill in the **AWS region** — the region where your Elasticsearch/OpenSearch
   domain lives, for example `eu-west-1` or `us-west-2`.
5. Choose your **AWS authentication type**:
   - **AWS IAM Role** — the site assumes an IAM role and holds no long-lived
     secret. This is the recommended option when the site runs on EC2, ECS, or EKS.
   - **AWS Credentials** — you supply an access **key** and **secret** directly.
     Use this only when an instance role isn't available.
6. If you chose **AWS Credentials**, enter the **key** and **secret**.
7. Save the cluster.

## Handling the credentials safely

- **Prefer an IAM role over keys.** A role means there is no secret stored in
  Drupal at all. Where keys are unavoidable, scope the IAM policy tightly to the
  specific domain and the specific actions the site needs — not a blanket
  Elasticsearch policy.
- **Never commit the key and secret.** If you use DDEV, keep them in environment
  variables — for example
  `ddev dotenv set .ddev/.env --aws-access-key-id=<value> --aws-secret-access-key=<value>`
  (keep `.ddev/.env` out of version control), then `ddev restart` — and reference
  those rather than hard-coding secrets into exported configuration. Where the
  connector supports it, store the secret in a Key entity backed by the environment
  variable rather than in plain config.
- **Don't expose the domain by IP instead.** Opening the AWS domain to an IP range
  with no signing is the tempting shortcut, but it means anyone who reaches the
  endpoint can read and write the entire index. IAM signing is the safer model —
  which is the whole reason this module exists.
- **Remember what's in the index.** The domain's access policy is protecting a copy
  of your site's content — including unpublished content if the indexer was
  configured to include it — so treat the domain as sensitive and keep its traffic
  over TLS.

## Version note

This `8.x-7.x` series signs requests for **Elasticsearch 7**. Amazon's OpenSearch
forked from Elasticsearch at 7.10 and the APIs have diverged since, so confirm the
series matches what your AWS domain actually runs before relying on it in
production.
