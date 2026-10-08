# Digital Climate Strike Popup — manual setup guide

**Digital Climate Strike Popup** (`dcs_popup`) adds a **Digital Climate Strike**
participation popup to your Drupal site — a banner or overlay shown to visitors that
lets your site take part in the Digital Climate Strike awareness campaign (see
<https://digital.globalclimatestrike.net>). It's a small front-end awareness widget:
enable it, pick a widget style on its settings page, and the popup appears for your
visitors.

There isn't much to it beyond that. The module is a lightweight campaign banner with
a single settings page where you choose which widget to use. It works on Drupal 10
and 11 and has no other module dependencies.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable it.
2. [Configuration](configuration/index.md) — choose the popup widget to display.

## Where it lives in the admin menu

Its settings sit under **Configuration → System → Digital Climate Strike Popup
Settings** (`/admin/config/dcs_popup/settings`), where you pick the widget to use.
