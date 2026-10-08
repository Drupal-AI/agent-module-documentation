# Site Info REST — manual setup guide

**Site Info REST** (`site_info_rest`) adds a small REST resource that returns your
site's basic branding — its **name, slogan, logo URL, and favicon URL** — as JSON. It
exists to serve a decoupled or headless front end that needs to render the same
branding as the Drupal site without hard-coding it: fetch the endpoint and you get the
current values straight from the site.

The resource is intentionally limited to public branding. It returns name, slogan,
logo, and favicon — and deliberately *not* the Drupal version, module list, or any other
information that could help fingerprint the site — so it is low-sensitivity by design.
Being a standard REST resource, it is also permission-gated: access is controlled by
core's REST `restful get` permission, which you grant to whichever audience should be
able to read it.

The module works after a little setup: enable it, enable the REST resource, and the
data is available at `/site/info?_format=json`. It depends only on core **REST** and
adds no configuration form of its own — you manage the resource through core's REST
machinery (the REST UI module is the easy way to do that). There are no submodules.

This guide is written for a **human** setting the module up. If you want terse,
token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable the module,
   and turn on the REST resource.

## How to use it

Once the module is enabled and the REST resource is turned on, retrieve site
information with a GET request to **`/site/info?_format=json`**. The response contains
the site name, slogan, logo, and favicon. There is no dedicated settings page — the
resource is configured through Drupal core's REST configuration, which the contributed
**REST UI** module gives you a friendly interface for (see
[Installation](installation/index.md)).
