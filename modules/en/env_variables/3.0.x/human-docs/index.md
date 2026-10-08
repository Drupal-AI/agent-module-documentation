# Environment Variables — manual setup guide

**Environment Variables** (`env_variables`) provides an admin interface for
viewing environment variables loaded from a configured `.env` file, plus a
settings form to point at that file. It reads the file using the `vlucas/phpdotenv`
("PHP dotenv") library, and it also exposes a service so your own custom modules
can load those variables by injecting it into a constructor.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer (required, for
   the PHP dotenv library) and enable the module.
2. [Configuration](configuration/index.md) — pointing at the `.env` file and
   choosing which roles may reach the list page.

## Where it lives in the admin menu

Once enabled, the module adds an **Environment Settings** item under
**Administration → Configuration** (the `env_variables.config.form` settings
form), with child links for the **Settings** form and the **List** page. By
default only the administrator role can reach the list page; you can change which
role holds the **View Environment Variables** permission on the Permissions page.
