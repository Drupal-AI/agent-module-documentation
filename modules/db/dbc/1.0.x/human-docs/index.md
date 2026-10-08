# Domain Base Css — manual setup guide

**Domain Base Css** (`dbc`) lets a multi-domain Drupal site load a *different* CSS
file for each domain. If you run several domains from one Drupal install using the
[Domain](https://www.drupal.org/project/domain) module — affiliate sites, partner
microsites, or seasonal campaign domains — this module gives each domain its own
stylesheet, uploaded through the admin UI, without building a separate subtheme for
every domain.

The mechanism is simple and purely additive. On its settings form you get one file
upload field per configured domain, restricted to `.css` files (stored under
`public://dbc/`). On every page request the module works out which domain is
active, looks up the CSS file you saved for that domain, and appends a
`<link rel="stylesheet">` to the page `<head>` pointing at it. The stylesheet is
layered *on top of* your active theme rather than replacing it, so you can use it to
tweak colours, brand a single domain differently, or apply print/accessibility
adjustments scoped to one domain of the farm.

It depends on the **Domain** module and does one job: injecting a site-admin-uploaded
stylesheet per domain. There are no anonymous or content-changing endpoints — the
only page it adds is the permission-gated settings form, and the only permission it
introduces controls who may manage the per-domain CSS.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer
   (alongside Domain) and enable it.
2. [Configuration](configuration/index.md) — upload a CSS file for each domain on
   the settings form.

## Where it lives in the admin menu

Its settings form sits under **Configuration → Domain → Domain CSS Switcher**
(`/admin/config/domain/domain_css_switcher`), behind the **Administer domain css
switcher setting** permission.
