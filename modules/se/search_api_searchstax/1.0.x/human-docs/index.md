# Search API SearchStax — manual setup guide

**Search API SearchStax** (`search_api_searchstax`) connects Drupal's Search API
to **SearchStax**, a managed Solr hosting service, so your site can have real Solr
search without you having to run, secure, monitor, back up and upgrade a Solr
server yourself.

Solr is the standard backend for serious Drupal search — faceting, relevance
tuning, strong multilingual handling — but operating it is an extra service to
look after. Managed hosting takes that burden away, and this module supplies the
Search API connector that lets your indexes talk to a SearchStax-hosted Solr
instance. It depends on the **Search API** module and works on Drupal 10 and 11.
This release is covered by Drupal's security advisory policy.

This guide is written for a **human** setting the module up through the admin UI.
If you want terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

## How to use it

The module has no settings page of its own. After enabling it, you add a Search
API **server** at **Configuration → Search and metadata → Search API**
(`/admin/config/search/search-api`) and choose the SearchStax connector as the
server's backend, then enter the connection details for your SearchStax account.
Point your indexes at that server and index as usual.

## Three things to get right before you rely on it

**Keep the credentials out of configuration.** Your SearchStax connection details
are a live secret. Store them in an environment variable rather than exported
configuration, and surface them to Drupal through a Key entity where the
connector supports it — never commit them to the repository.

**Remember that your indexed content leaves the site.** SearchStax holds a copy
of whatever you index. For a site with unpublished or access-restricted content
that is a data-processing question worth thinking through. Result access is still
governed by **Search API's own access handling** and your index configuration —
the hosted backend does not enforce your site's permissions for you, so verify
that restricted content is not queryable by the wrong person rather than assuming
it is protected.

**Weigh cost and lock-in.** Managed Solr is a billed service, and an index built
to one provider's specifics is work to move later. Before committing, confirm that
self-hosted Solr (via `search_api_solr`) has genuinely been ruled out rather than
assumed away.
