# Dropfort Update — manual setup guide

**Dropfort Update** (`dropfort_update`) reports your site's update information to a
[Dropfort](https://www.dropfort.com) dashboard, so you can review update status,
available updates, and site health for many Drupal sites from one place. Instead
of logging into each site to check for security releases, you let each site push
its update picture to Dropfort and watch the whole fleet centrally. It's aimed at
teams and organizations managing more than one Drupal site.

The module is the client half: it collects the site's status report (installed
modules and themes, their versions, and available updates) and sends it to the
Dropfort service. It builds on core's **Update** module for that data. Dropfort
itself (a product of Coldfront Labs) is where the collected information is viewed
and filtered.

Two things to keep in mind. First, the data it transmits — a detailed inventory
of exactly which modules and versions your site runs — is itself sensitive,
because it describes the site's precise attack surface. So the connection should
be authenticated, sent to a recipient you trust, and carried over HTTPS. Second,
store any Dropfort API credentials as secrets rather than committing them to
configuration.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.
2. [Configuration](configuration/index.md) — connect the site to your Dropfort
   account and store the credentials securely.

## Where it lives in the admin menu

Once enabled, the settings form is available at the module's configuration route
(`dropfort_update.settings`) under the site **Configuration** menu. Access to it
is governed by the module's own administration permission on **People →
Permissions**.

## How to use it

1. Set up a Dropfort account and register the site there (this is where the
   connection details/credentials come from).
2. Install and enable the module (see [Installation](installation/index.md)).
3. Enter the Dropfort connection details on the settings form and store the
   credentials securely (see [Configuration](configuration/index.md)).
4. Confirm the site appears in your Dropfort dashboard and that its update status
   is reported there.
