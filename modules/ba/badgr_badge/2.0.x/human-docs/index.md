# Badgr Badge — manual setup guide

**Badgr Badge** (`badgr_badge`) connects your Drupal site to the
[Badgr](https://badgr.com) open-badge service so you can issue, store and manage
digital badges — [Open Badges](https://openbadges.org) — for your users. It is
aimed at e-learning, certifications and community recognition: someone completes
a course or reaches a milestone, and you award them a verifiable badge. Badges
are attached to content and files within Drupal.

The module separates two jobs with two permissions: **Administer badgr badge**
for setting the integration up, and **Create badgr badge** for actually issuing
badges. Keep issuance restricted to trusted roles. It depends on core's **Node**
and **File** modules and runs on Drupal 10 and 11.

Talking to Badgr means holding **API credentials**, and those are secrets. Do not
paste them into configuration that gets exported to Git or captured in a database
dump. Store them in an environment variable and read them from there — see
[Installation](installation/index.md) for how to do that with DDEV and Drupal's
Key module.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

> **Note on these docs.** The available agent documentation for this module is
> thin — it confirms the two permissions, the Badgr integration and the
> node/file dependencies, but does not spell out the exact admin path of the
> connection settings form. Once enabled, look under the site's Configuration
> area (or the module's own admin section) for where to enter the Badgr
> connection details, and consult the project page if in doubt.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable it, and
   handle the API credentials securely.

## How to use it

After enabling the module and giving your administrator role the **Administer
badgr badge** permission, enter your Badgr connection details (with the API
credentials sourced from the environment, not committed config). Then grant
**Create badgr badge** to the roles that should be allowed to issue badges. From
there you issue Open Badges to users and attach them to content or files. Because
badge issuance is a trust-sensitive action, keep the *create* permission on a
small set of roles.
