# HTTP Status Code — manual setup guide

**HTTP Status Code** (`http_status_code`) lets you map specific request paths to
a chosen HTTP status code, overriding the response status that Drupal would
otherwise send. Its headline use is SEO index hygiene: when you permanently
remove a page, Drupal returns `404 Not Found` for the old URL, and search
engines treat a 404 as "gone for now, maybe back later." By mapping that path to
`410 Gone` instead, you tell crawlers the page is gone for good, and Google will
drop it from the index.

The module does not create pages or content — it only manipulates the HTTP
header on responses that match a path you configured. You add mappings through a
small admin UI: each mapping is a label, a path to match, and the status code to
return. At runtime an event subscriber checks every response against your list
and, on a match, rewrites the status code.

Two things are worth knowing before you rely on it. First, the module's own help
text cautions that "fiddling with HTTP Headers could make both browsers and
Google confused" — use it deliberately. Second, the subscriber runs a lookup on
*every* response, so a very large number of mappings adds a little overhead to
each page.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — add and manage path → status code
   mappings, field by field.

## Where it lives in the admin menu

Mappings are managed at **Configuration → HTTP Status Code**, under
`/admin/config/http_status_code/http_status_entity`, where you can add, edit,
list, and delete them. The mappings are stored as configuration entities, so
they export and deploy with the rest of your site configuration.
