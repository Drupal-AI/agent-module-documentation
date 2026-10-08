# TAPIS Jobs — manual setup guide

**TAPIS Jobs** (`tapis_job`) is the module that actually runs things. In TAPIS, a
job is a TAPIS app run on a TAPIS system, and this module lets Drupal users launch
any TAPIS app as a job from within the site, then watch its status, view its
output files, and cancel or delete it. TAPIS jobs are represented as custom
entities in Drupal, and the module builds a view on each user's profile page
listing all the jobs they can access.

It provides forms for launching a job from an app's page and for cloning an
existing job. It also offers a setting that lets users share their active job
sessions with other users through temporary links — this applies only to Web and
VNC apps. The module depends on **TAPIS Auth**, the **Key** module, the **JWT**
module, and core **Views** (and, through the suite, TAPIS System and TAPIS Apps).

There is no central settings form — you work through the job entities and the
launch/clone forms. Because launching and monitoring jobs calls the external TAPIS
API (egress) and authenticates via TAPIS Auth using JWT and the Key module, keep
your credentials and keys stored as secrets (the Key dependency is exactly the
right tool for this) and connect over HTTPS. Jobs may also process research data,
so handle both inputs and outputs appropriately.

This guide is written for a **human** setting the module up through the admin UI.
If you want terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable the
   module, and its TAPIS, Key, and JWT dependencies.

## How to use it

With the rest of the TAPIS suite configured, users launch a job from a TAPIS
app's page (using the launch form that **TAPIS App Webform** supplies), then track
it from the jobs view on their profile page — checking status, opening output
files, or cancelling and deleting it. Existing jobs can be cloned to re-run with
tweaked parameters. For Web and VNC apps, users can optionally share a live job
session with another user via a temporary link.
