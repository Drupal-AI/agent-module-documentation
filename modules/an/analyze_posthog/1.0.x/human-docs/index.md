# Analyze PostHog — manual setup guide

**Analyze PostHog** (`analyze_posthog`) is a submodule of the
[Analyze](https://www.drupal.org/project/analyze) framework that brings your
[PostHog](https://posthog.com/) analytics into Drupal. It displays PostHog metrics —
pageviews, visitors, sessions — for your content inside the Analyze dashboard, so editors
can see how a piece of content is performing without leaving Drupal and logging into
PostHog separately.

The module connects to the PostHog API using credentials stored via the **Key** module,
which is designed to keep secrets out of exported configuration (an environment-variable
backed key is the recommended approach). Access to the analytics display is gated by the
**Access posthog analytics** permission, so you decide which roles can see the numbers.

This guide is written for a **human** clicking through the admin UI. If you want terse,
token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module and its dependencies with
   Composer, then enable it.
2. [Configuration](configuration/index.md) — store your PostHog credentials with the Key
   module and grant the permission.

## Where it lives in the admin menu

PostHog metrics appear in the **Analyze** dashboard/report for your content. Credentials
are managed through the **Key** module (**Configuration → System → Keys**), and access is
controlled by the **Access posthog analytics** permission on the People → Permissions
page.

## How to use it

Once the credentials are stored and the permission is granted, open the Analyze report
for a piece of content to see its PostHog pageviews, visitors, and sessions alongside the
content itself.
