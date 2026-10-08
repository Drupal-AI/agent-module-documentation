# Elasticsearch AWS Connector — manual setup guide

**Elasticsearch AWS Connector** (`elasticsearch_aws_connector`) lets a Drupal site
talk to Amazon's managed **Elasticsearch / OpenSearch** service by signing every
request with **AWS Signature Version 4 (SigV4)**. It is an add-on to the
[Elasticsearch Connector](https://www.drupal.org/project/elasticsearch_connector)
module (its one dependency), not a standalone search backend.

Why is it needed at all? A self-hosted Elasticsearch cluster is reached with a URL
and maybe basic auth, and that's what every Drupal integration assumes. Amazon's
managed service works differently: access is controlled by **IAM**, and requests
must be SigV4-signed — the same signing scheme as the rest of the AWS API — or they
are rejected no matter where they come from. This module supplies that signing, so
Elasticsearch Connector can point at an AWS domain.

Three things are worth knowing before you rely on it. First, **IAM signing is the
better security model**, and the alternative people fall back to — opening the
domain to an IP range with no signing — means anyone who can reach the endpoint can
read and write the whole index, so the setup here is worth doing. Second, **prefer
an instance role over long-lived keys**: a site on EC2, ECS, or EKS can assume an
IAM role and never hold a secret; where keys are unavoidable, scope the IAM policy
tightly to the specific domain and actions. Third, **a search index usually
contains a copy of everything the site indexes** (including unpublished content if
the indexer was set up carelessly), so the domain's access policy is protecting
real content, not just a cache.

One version caveat: this `8.x-7.x` series tracks **Elasticsearch 7**, and OpenSearch
forked from Elasticsearch at 7.10 with the APIs diverging since — so check the
series against what your AWS domain actually runs.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable it
   alongside Elasticsearch Connector.
2. [Configuration](configuration/index.md) — choose AWS signed requests as the
   authentication type on your Elasticsearch Connector cluster and supply the
   region and credentials.

## Where it lives in the admin menu

This module adds **no admin page of its own**. Instead, it adds an authentication
option to the **Elasticsearch Connector** cluster form (**Configuration → Search
and metadata → Elasticsearch Connector**). When you enable authentication on a
cluster there, "Amazon Web Services - signed requests" becomes an available
authentication type — see [Configuration](configuration/index.md).
