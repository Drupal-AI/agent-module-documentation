# Mida A/B Testing — manual setup guide

**Mida A/B Testing** (`mida`) connects your Drupal site to
[Mida](https://www.drupal.org/project/mida), a lightweight third‑party A/B
testing platform. The module's job is simple: it injects the Mida JavaScript
snippet into your pages so the Mida service can run visual and code‑based
experiments, measure variants, and (via Mida's own tooling) integrate with GA4.
You design and run the experiments in Mida; Drupal's part is to load the script
reliably and only where you want it.

The problem it solves is getting an experimentation tag onto the site cleanly —
with your API key, sensible visibility rules, and without the "content flash"
that plagues naive A/B snippets. Mida loads its script **asynchronously** for
performance and includes **anti‑flickering** support so visitors don't briefly
see the original content before a test variant swaps in.

The module needs a small amount of configuration before it does anything: you
must supply your **Mida API key** and choose where the script should load. It has
no third‑party module dependencies and runs on **Drupal 10.2 or 11**.

> **Privacy note.** Mida loads a **third‑party experimentation script** that can
> modify page content on the client and may set cookies or collect visitor data.
> Disclose it in your privacy policy and gate it behind your consent tooling where
> that is required in your jurisdiction.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.
2. [Configuration](configuration/index.md) — enter your Mida API key and set the
   visibility conditions.

## Where it lives in the admin menu

After enabling, open the module's **Mida settings** form (under
**Configuration**) to paste your API key and choose the visibility conditions.
The [Configuration](configuration/index.md) guide walks through each setting.
