# Phaxio — manual setup guide

**Phaxio** (`phaxio`) connects Drupal to [Phaxio](https://www.phaxio.com/), an
online fax service with a web API. With it in place your site can send faxes
through Phaxio and receive status callbacks when the state of a fax changes, and
other modules can react to those events through a `hook_phaxio_status` hook.

Think of it as the plumbing between Drupal and Phaxio rather than a finished
feature: the base module sends faxes and fires an event when Phaxio reports back,
and you (or another module) decide what to do with those events. It depends only on
Drupal core.

You will need a Phaxio account and its API credentials (an **API key** and **API
secret**), which you enter on the module's settings form.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — enter your Phaxio API credentials,
   and store them safely.

## How to use it

Once installed and configured with your Phaxio credentials, the module can send
faxes via the Phaxio API and exposes a status‑callback endpoint (`/phaxio/status`)
that Phaxio calls when a fax's status changes. Each callback fires the
`hook_phaxio_status` hook so your custom code can respond — for example logging the
result or updating a record.
