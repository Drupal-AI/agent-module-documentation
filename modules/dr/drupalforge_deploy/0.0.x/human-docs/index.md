# Drupal Forge Deployment — manual setup guide

**Drupal Forge Deployment** (`drupalforge_deploy`) integrates with **Drupal
Forge** — the community hosting/demo platform — to help you launch a copy of your
Drupal site. It handles the fiddly parts of that hand‑off: exporting the database
(through Backup and Migrate to an AWS S3 destination), detecting your Git
repository's GitHub or GitLab remote, and assembling a launch URL with all the
parameters Drupal Forge needs.

The problem it solves is turning "I want a live copy of this site on Drupal Forge"
into a few clicks. Rather than manually gathering a backup, working out your repo
details, and hand‑building a launch URL, you open the module's Deploy page, let it
verify your configuration through a set of readiness checks, pick a Git branch and
a backup, and click Deploy.

This is an **early release** (`0.0.x`) and it has real prerequisites: your site
must be in a Git repository with a GitHub or GitLab remote, and you must have the
**Backup and Migrate** module configured with an **AWS S3** destination — that S3
integration is a hard dependency of this module. It also provides its own
permission, so gate the Deploy page to trusted users.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable the
   module, and satisfy the Backup and Migrate / S3 prerequisites.

There is **no field‑based settings form** — the module's admin interface is the
Deploy page (a guided readiness‑check and launch workflow), described in "How to
use it" below.

## Where it lives in the admin menu

Once enabled, the Deploy page is at **Configuration → Development → Drupal Forge
Deploy** (`/admin/config/development/drupalforge-deploy`), gated by the module's
own permission.

## How to use it

1. Make sure the prerequisites are in place: your site is in a Git repo with a
   GitHub or GitLab remote, and **Backup and Migrate** has an **AWS S3**
   destination configured.
2. Open the Deploy page at
   **Configuration → Development → Drupal Forge Deploy**
   (`/admin/config/development/drupalforge-deploy`).
3. Work through the **readiness steps** the page shows, which verify your Git and
   Backup‑and‑Migrate/S3 configuration.
4. Select a **Git branch** and a **backup**.
5. Click **Deploy** — the module generates the Drupal Forge launch URL from the
   backup and repository metadata so you can launch the copy.
