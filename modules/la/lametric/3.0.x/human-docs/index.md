# LaMetric Time — manual setup guide

**LaMetric Time** (`lametric`) sends notifications from your Drupal site to a
physical **LaMetric Time** smart display — the little pixel‑clock device that shows
scrolling messages and metrics. With it, site events such as new orders, form
submissions, or alerts can appear on a device sitting on a desk or wall in your
office, pushed there through LaMetric's API.

The connection is authenticated with a **LaMetric API token**. Because that token
is a secret that lets anything holding it push to your device, it should be stored
securely rather than pasted into configuration that ends up in version control —
this guide shows the environment‑variable approach below.

It depends on core's **System** module and on the contrib **Service** module, and
supports Drupal 8.8 and newer.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it alongside the Service module.
2. [Configuration](configuration/index.md) — enter your LaMetric API token, store
   it securely, and start sending notifications.

## How to use it

Once the module is installed and your API token is configured, Drupal can push
messages to the device. Configure the token first (see
[Configuration](configuration/index.md)), then wire notifications to whatever site
events you want to surface on the display.
