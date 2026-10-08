# TAPIS Apps — manual setup guide

**TAPIS Apps** (`tapis_app`) adds support for TAPIS *apps* to Drupal. In TAPIS, an
app version is a particular configuration of a Singularity/Docker container that
can be run on a TAPIS system as a job. This module lets Drupal users create and
manage these apps directly on the site, so a Drupal science gateway can present
and configure computational applications for its users.

It supports the three main TAPIS app types: **Batch** (a non-interactive
CLI-based app), **Web** (a web app such as a Jupyter Notebook), and **VNC** (an app
that VNC clients connect to). TAPIS apps are represented as custom content types
in Drupal, and the module also builds a view on each user's profile page listing
all the apps they can access. It depends on **TAPIS Auth**, **Webform**, and
**Views** (and, through those, the rest of the TAPIS suite — Tenant, System).

There is no central settings form — you work through the app content you create.
Because the module calls the external TAPIS API (egress) and authenticates via
TAPIS Auth using OAuth/JWT, store your TAPIS credentials and keys as secrets
(through the Key module or environment variables) and connect over HTTPS.

This guide is written for a **human** setting the module up through the admin UI.
If you want terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable the
   module, and its TAPIS and Webform dependencies.

## How to use it

With TAPIS Tenant, Auth, and Systems already in place, enable this module and
create **Tapis App** content to define your Batch, Web, or VNC applications. Each
user's profile page gains a view listing the apps they can access. To turn an app
into something users can actually launch, pair it with **TAPIS App Webform** (for
the input form) and **TAPIS Jobs** (to run and monitor it).
