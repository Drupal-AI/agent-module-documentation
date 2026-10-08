# Analyze: Search Console — manual setup guide

**Analyze: Search Console** (`analyze_search_console`) is a submodule of the
[Analyze](https://www.drupal.org/project/analyze) framework that brings
[Google Search Console](https://search.google.com/search-console) performance data into
Drupal. It surfaces your search impressions, clicks, and queries for content inside the
Analyze module's reporting, so editors can see how content performs in Google search
without leaving Drupal.

The module authenticates to the Google Search Console API over HTTPS using credentials
stored via the **Key** module, which keeps the secret out of exported configuration. It
then fetches your site's search-performance data from your Google account. The report is
gated by the module's own permission, and the module has no access-control role beyond
that.

This guide is written for a **human** clicking through the admin UI. If you want terse,
token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module and its dependencies with
   Composer, then enable it.
2. [Configuration](configuration/index.md) — store your Google Search Console
   credentials with the Key module and grant the permission.

## Where it lives in the admin menu

Search Console performance data appears in the **Analyze** report for your content.
Credentials are managed through the **Key** module (**Configuration → System → Keys**),
and access to the report is controlled by the module's permission on the People →
Permissions page.

## How to use it

Once the Search Console credentials are stored and the permission is granted, open the
Analyze report for a piece of content to see its Google search impressions, clicks, and
queries alongside the content itself.
