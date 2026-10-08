# Configuration

This module extends your existing Search API OpenSearch setup, so its configuration
builds on the standard Search API screens at **Configuration → Search and
metadata → Search API** (`/admin/config/search/search-api`). The one piece unique
to this module is telling it which OpenSearch ML model to use.

## Prerequisite — an ML model in OpenSearch

The model that produces the embeddings is configured **in OpenSearch, not in
Drupal**. Before configuring anything here, integrate an ML model in your
OpenSearch cluster and note its **model ID**. OpenSearch's "Integrating ML models"
guide covers this. This module deliberately leaves model setup to OpenSearch and
just consumes the resulting model ID.

## Set the model ID

In this module's settings, enter the **model ID** of the OpenSearch ML model you
want to use for generating embeddings. That single value connects Drupal's semantic
search to the model running in your cluster.

## Enable semantic search on the index

With the model ID in place, enable the vector/semantic search capability on your
Search API OpenSearch index — this uses the semantic field added in OpenSearch 3.1.
Once configured and re-indexed, queries against the index can match by semantic
similarity (meaning) rather than only by matching keywords.

## Things to confirm before going live

- **Egress.** Generating embeddings may send your content to an embedding model or
  service. Confirm that sending this content is acceptable for your site's data
  policy.
- **Access.** The content is indexed into OpenSearch. Make sure you respect Search
  API's access handling so that semantic results can't surface content a given user
  isn't allowed to see — this module adds no access control of its own.

Because the module is experimental and under active development, test the behavior
on a small set of content before rolling it out broadly.
