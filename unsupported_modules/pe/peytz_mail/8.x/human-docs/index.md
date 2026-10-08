# Peytz Mail — manual setup guide

**Peytz Mail** (`peytz_mail`) connects your Drupal site to the **Peytz Mail**
newsletter platform. Its main job is to let visitors **sign up to newsletter
lists** held in your Peytz Mail account: once configured, the module provides a
**block** you can place anywhere, configured to let people subscribe to the lists
you choose. It also ships helpers for calling the Peytz Mail API functions, so
other modules and your own code can work with Peytz Mail's services, and other
modules can add extra fields to the signup form through a hook.

Setup is straightforward — point the module at your Peytz Mail account, enter your
API key, and then place and configure the signup block. There are no unusual
system requirements.

Your **Peytz Mail API key** is a credential: configure it through the admin form,
but treat the value as a **secret** — supply it from the environment rather than
committing it to your repository. The module has no access‑control role of its own
on your Drupal site.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer,
   enable it, and set up its permissions.
2. [Configuration](configuration/index.md) — connect your Peytz Mail account and
   place the newsletter signup block.

## Where it lives in the admin menu

The settings form is at **Configuration → Peytz Mail → Settings**
(`/admin/config/peytz_mail/settings`), where you enter the service URL and API
key. The visitor‑facing signup block is placed and configured from **Structure →
Block layout**. See [Configuration](configuration/index.md).
