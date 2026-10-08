# Custom Page Title — manual setup guide

**Custom Page Title** (`custom_page_title`) lets you set a specific, custom page
title for individual pages on your site. Drupal normally derives a page's title
(the browser `<title>` and the on-page H1) from the node, view, or route it comes
from — which isn't always the wording you want for SEO or presentation. This
module lets you override that title from a settings form, matching pages by their
path alias, so you can present exactly the title you choose.

It's a small SEO/display helper: it changes only the page title, not the page's
content and not who can access it. There are no permissions of its own and no
dependencies beyond Drupal core, so it's safe to enable and use only on the
handful of pages where the default title falls short.

The module needs a little configuration to be useful — you tell it which paths
should get which titles on its settings form. Until you add an entry there, it
changes nothing.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — the settings form where you map
   paths to custom titles.

## Where it lives in the admin menu

Once enabled, Custom Page Title adds a settings form (route
`custom_page_title.custom_page_title_settings_form`) under **Configuration**. Open
it to define your custom titles — see [Configuration](configuration/index.md) for
the details.
