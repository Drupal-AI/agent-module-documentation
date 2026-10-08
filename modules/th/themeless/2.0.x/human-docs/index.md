# Themeless — manual setup guide

**Themeless** (`themeless`) is a small REST API that serves Drupal entities —
nodes, users, and taxonomy terms — *without* the theme wrapper around them. You
request an entity at a clean URL and get back just its content, as JSON, XML, or
plain (theme-free) HTML. It is mainly meant for pulling clean HTML into an iframe
on another site, but the JSON and XML formats make it handy for headless Drupal,
mobile apps, and other external integrations too.

The endpoints follow a simple pattern: `/api/node/{id}`, `/api/user/{id}`, and
`/api/taxonomy/term/{id}`. Add a `?format=` query parameter to choose the output —
`json` (the default, pretty-printed), `xml`, or `html` (the entity rendered
through Drupal's view builder but with no page theme around it). Which fields
appear in the output is controlled through a standard Drupal **view mode** called
"Themeless", so you shape the response with the normal Manage Display screens
rather than a bespoke settings form.

Themeless does need a little setup before it is useful: you grant the access
permission, turn on the Themeless display for the entity types you want to expose,
and (optionally) tune CORS, a referrer/domain whitelist, and access tokens through
a YAML configuration file. It depends on core's **Node** module and requires
**PHP 8.1+**. A demo submodule, `themeless_demo`, ships sample content for testing.
Note that version 2.0.x is a complete rewrite for Drupal 10/11 with no upgrade path
from the old Drupal 7 (7.x-1.x) branch.

Because these endpoints hand out entity content directly, the important thing is
scope: the output routes use a custom access check, and you should make sure only
the entities and bundles you actually mean to publish are exposed — so unpublished
or access-controlled content is not leaked. The referrer/domain whitelist and
token options exist to help you lock embedding down to the sites you trust.

This guide is written for a **human** setting the module up. If you want terse,
token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable the
   module, and (optionally) enable the demo submodule.
2. [Configuration](configuration/index.md) — grant the permission, turn on the
   Themeless display, and set the CORS / whitelist / token options.

## How to use it

Once configured, fetch an entity from its endpoint and pick a format:

```bash
# JSON (default)
curl https://example.com/api/node/1
curl https://example.com/api/node/1?format=json

# XML
curl https://example.com/api/node/1?format=xml

# Theme-free HTML (good for iframes)
curl https://example.com/api/node/1?format=html

# A user, or a taxonomy term
curl https://example.com/api/user/1?format=json
curl https://example.com/api/taxonomy/term/5?format=json
```
