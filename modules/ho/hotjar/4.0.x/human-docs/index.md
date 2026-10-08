# Hotjar — manual setup guide

**Hotjar** (`hotjar`) adds the Hotjar analytics tracking snippet to your Drupal
pages, so Hotjar can record heatmaps, session recordings and other
user-behaviour data. You give it your Hotjar site ID and choose which pages and
which user roles should be tracked; the module handles injecting the JavaScript on
matching page loads.

Configuration is one settings form. The key value is your **Hotjar ID** — nothing is
output until you set it. From there you control **page visibility** (track every page
except a listed set, track only a listed set, or track nowhere) and **role
visibility** (track only certain roles, or everyone except certain roles). Tracking
is always suppressed on 403 and 404 responses, and the shipped defaults already
exclude admin pages, node add/edit pages and user account sub-pages, so you are not
recording editors in the CMS.

The module works after you enter an ID and save. It depends on core's **Path alias**
module, adds one permission (*Administer Hotjar*, which only gates the settings
form), and has no submodules. It integrates with **EU Cookie Compliance** so tracking
can wait for consent, and it exposes hooks so other modules can veto tracking, serve
a different ID per environment, or wrap the script for a custom consent gate.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — the settings form, field by field:
   the Hotjar ID, page and role visibility, and snippet delivery.

## Where it lives in the admin menu

The settings form sits under **Configuration → System → Hotjar**
(`/admin/config/system/hotjar`), gated by the *Administer Hotjar* permission.
