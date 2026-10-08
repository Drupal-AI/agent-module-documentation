# ActiveNet — manual setup guide

**ActiveNet** (`activenet`) provides a basic integration with **ActiveNet** (the
Active Network activity-registration and management platform). It is most
commonly used on **YMCA Website Services** sites to surface programs and
activities held in ActiveNet inside Drupal — so visitors can browse and find
activities without leaving the site.

The integration is deliberately basic: it connects to ActiveNet, fetches
program/activity data, and makes it available in Drupal. It ships its own
permissions and sits in the "YMCA Website Services" package, and it runs on
Drupal 9, 10, and 11.

As a third-party integration there are a couple of things to handle carefully.
It authenticates to the ActiveNet API with credentials, so those must be stored
as secrets (not in exported configuration) and the connection should be over
HTTPS. The program/activity data it fetches is external content, so make sure it
is escaped when displayed. Beyond its own permission, the module has no
access-control role.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — provide the ActiveNet API
   credentials, stored as secrets, over HTTPS.

## Where it lives in the admin menu

After enabling, connect the module to ActiveNet using your API credentials (see
[Configuration](configuration/index.md)) and grant the module's permission to the
users who should manage or view the integration. It then fetches program and
activity data for display on the site.
