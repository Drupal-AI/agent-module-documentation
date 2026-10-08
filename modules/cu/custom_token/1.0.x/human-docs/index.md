# Custom Token — manual setup guide

**Custom Token** (`custom_token`) lets administrators define dynamic
`[custom_token:*]` tokens from the Drupal backend — no code, no editing
configuration files for sensitive values. Its clever twist is a **two-store
model** that keeps environment-specific data out of your repository:

- **Token keys** (machine names like `general_email` or `events_email`) are stored
  in Drupal's **Config** system. You export them with `drush config:export` and
  commit them, so the *structure* of your tokens is identical across every
  environment.
- **Token values** (the actual email addresses or other environment-specific
  strings) are stored in Drupal's **State** system. State is **never exported** and
  never committed — so each environment (development, QA, production) holds its own
  values, set independently.

This solves a real deployment hazard: hard-coding client email addresses into
Webform configuration means those addresses end up in the repo and get deployed to
QA, where test submissions can reach real recipients. Custom Token keeps the
sensitive values out of the codebase entirely. Once defined, a token is available
site-wide as `[custom_token:key]` and works in Webform email handler fields (To,
CC, BCC, options mapping), in email subject lines and bodies, and in any other
token-enabled field.

The module needs a small amount of setup — you define keys and values on its
settings form — and it requires the **Webform** module. Managing the tokens is
guarded by a restricted admin permission, so it's meant for trusted
administrators.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — define token keys and per-environment
   values, and deploy them safely.

## Where it lives in the admin menu

Once enabled, the settings form is at **Configuration → System → Custom Token**
(`/admin/config/system/custom_token`). See [Configuration](configuration/index.md)
for how to add tokens and roll them out across environments.
