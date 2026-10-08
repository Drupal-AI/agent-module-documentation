# Ecomail — manual setup guide

**Ecomail** (`ecomail`) connects your Drupal site to the
[Ecomail](https://www.drupal.org/project/ecomail) email‑marketing platform. It
provides the API integration layer — authenticating to Ecomail and letting your
site sync subscribers and contacts and trigger campaigns through Ecomail's API.
It is deliberately a *foundation* module: it is "meant to be extended by other
modules providing user‑facing features," so on its own it wires up the connection
rather than adding forms your visitors see.

The one thing you must set up is the **Ecomail API key**. Ecomail stores that
credential through the [Key](https://www.drupal.org/project/key) module
(`key`) rather than in plain configuration, which is the right way to keep a
secret out of your exported config and version control. Once the key is in place,
the integration can talk to Ecomail on your behalf.

Two things are worth knowing before you go live. First, this module **sends
contact and subscriber data (personal information) out to the Ecomail API** — that
is an egress of PII to a third party, so make sure your site's privacy policy
discloses it. Second, always run the site over **HTTPS** so the key and the data
in transit stay protected. The module provides its own permissions but has no
access‑control role beyond that.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable the
   module, and its Key dependency.
2. [Configuration](configuration/index.md) — store your Ecomail API key with the
   Key module and connect the integration.

## Where it lives in the admin menu

Ecomail has no public‑facing pages of its own — it is the plumbing that other
modules build on. Your main task is providing the Ecomail API key as a **Key**
entity, which lives under **Configuration → System → Keys**
(`/admin/config/system/keys`). See [Configuration](configuration/index.md) for
the full walkthrough.
