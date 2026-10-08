# Push my logs — manual setup guide

**Push my logs** (`push_logs`) forwards your Drupal log entries to an external
system over an HTTP POST call, to help with log centralization and monitoring.
Instead of leaving watchdog entries sitting in the database where you have to log
in and browse them, it ships them off-box to a remote log-aggregation endpoint —
so operators can watch, search, and alert on site logs from wherever they already
collect logs.

It is deliberately simple and flexible. It can be configured for **multiple
hosts**, supports **header-based authorization**, and can send the log data either
as **POST fields** or as a **formatted body with customizable replacement tokens**,
so you can shape the payload to match whatever receiving service you use.

The receiving endpoint and any credentials are admin-configured. Because those are
secrets, they should be stored securely (environment-backed) and never committed to
version control. It has no other module dependencies and supports a very wide range
of Drupal — `^8 || ^9 || ^10 || ^11`.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

The module's setup is small enough to cover here rather than in a separate
configuration page — see "How to use it" below, including how to keep credentials
out of version control.

## Where it lives in the admin menu

Once enabled, the module adds a settings page under **Configuration** where you
define the receiving host(s), authorization, and payload format. (Enable the module
first, then look under **Configuration → System / Development** for the *Push my
logs* settings.)

## How to use it

1. Enable the module and open its settings page under **Configuration**.
2. Configure one or more **receiving hosts** — the external endpoint(s) that should
   receive your logs via HTTP POST.
3. Set **header-based authorization** if your receiver requires it (for example an
   `Authorization` header carrying a token or API key).
4. Choose the **payload format**: send log data as individual **POST fields**, or as
   a **formatted body** using the module's customizable replacement tokens to
   match your receiver's expected shape.
5. Trigger a log entry and confirm it arrives at the external service.

### Keep credentials out of version control

The authorization token or API key for your log receiver is a secret. Do not paste
it anywhere it could be committed. Store it in an environment variable and reference
it from Drupal:

```bash
ddev dotenv set .ddev/.env --push-logs-token=<value>   # do not commit .ddev/.env
ddev restart
```

Confirm the variable is present in the container **without printing its value**:

```bash
ddev exec 'test -n "$PUSH_LOGS_TOKEN"'   # exit status 0 means it is set
```

Then reference the environment variable (via `getenv()` in settings, or a
[Key](https://www.drupal.org/project/key) entity where supported) rather than
storing the raw secret in exported configuration.
