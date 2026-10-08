# Druplicon — manual setup guide

**Druplicon** (`druplicon`) is a small branding module that lets an administrator
replace the default Druplicon logo shown in the Admin Toolbar with a custom
uploaded image. That logo is the little Drupal drop that appears at the far left
of the toolbar (added by Admin Toolbar's Extra Tools); Druplicon swaps it for a
picture of your choosing.

It solves a simple but useful problem: telling environments apart at a glance and
adding a touch of client or company branding to the admin experience. Upload one
logo on production and a different one on staging, for example, and you will never
again wonder which environment you are editing.

The module depends on the **Admin Toolbar** module — that toolbar's admin menu is
where the replacement logo is injected. It adds a single settings form where you
upload the image; once uploaded and saved, the toolbar shows your logo instead of
the default Druplicon. It supports Drupal 9 and 10.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module (and its Admin Toolbar dependency).
2. [Configuration](configuration/index.md) — upload your custom logo on the
   settings form.

## Where it lives in the admin menu

Druplicon adds one settings form at **Configuration → User interface →
Druplicon** (`/admin/config/druplicon/settings`), reachable by users with the
**Administer site configuration** permission.
