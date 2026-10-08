# DOI Publications — manual setup guide

**DOI Publications** (`doi_search`, project name "DOI Publications") looks up
scholarly publication metadata by **DOI** (Digital Object Identifier). It gives
your site two things: a **search page** at `/doi-search` where users can search
for publications, and a **service** (`doi_search.manager`) that other code — and
the companion [DOI Field](https://www.drupal.org/project/doi_field) module — can
call to retrieve information about a publication from its DOI.

Under the hood it queries an external DOI metadata service (the Crossref API) and
surfaces the returned publication details in your site. Because that data comes
from an outside source, treat what it returns as external content. The module is
aimed at academic and library sites that reference publications by DOI.

Developers can use the service directly, for example:

```php
$data = \Drupal::service('doi_search.manager')->getData('10.1000/xyz123');
```

The module works as soon as it is enabled — there is no settings form. Its only
"configuration" is deciding **who** may use it, which you do on the standard
Drupal permissions page (it provides its own permissions). Note that DOI Field
depends on this module, so if you installed DOI Field you already have DOI
Publications.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable the
   module, and set its permissions.

There is **no settings form** for this module. The only setup beyond enabling it
is granting its permissions, described in Installation, and using the search page
described below.

## Where it lives in the admin menu

DOI Publications adds a search page at `/doi-search` rather than an admin settings
page. Its permissions are managed on the standard permissions page, filtered to
this module at `/admin/people/permissions/module/doi_search`.

## How to use it

- **Search interface:** visit `/doi-search` to search for publications by DOI and
  see the returned metadata.
- **As a service:** call `\Drupal::service('doi_search.manager')->getData($doi)`
  from custom code to fetch a publication's data programmatically.
- **With DOI Field:** install the DOI Field module to add a DOI field type that
  uses this module to display publication details on your content.
