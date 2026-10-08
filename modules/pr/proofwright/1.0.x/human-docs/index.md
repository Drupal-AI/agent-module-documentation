# Proofwright CRA Evidence — manual setup guide

**Proofwright CRA Evidence** (`proofwright`) builds a CycloneDX software bill of
materials (SBOM) of your Drupal site — core plus every installed module and theme —
and sends it to a Proofwright console over HTTPS, so you have current, machine‑readable
evidence of the site's software composition. It is aimed at teams preparing for the EU
Cyber Resilience Act (CRA), whose reporting obligations begin phasing in from
September 2026.

The SBOM maps every component to a Composer package URL (for example, Token 8.x‑1.15
becomes `pkg:composer/drupal/token@8.x-1.15`). Those are the same identifiers the
Drupal security advisories and OSV feeds use, so once your SBOM reaches the console,
known vulnerabilities in your inventory can be recognised automatically.

Nothing leaves your site until you enter a licence key and a console URL. There is no
telemetry and no phone‑home. The module sends an inventory of extension names and
versions only — it does not read content, user data, or any configuration beyond its
own settings. It is not legal advice; verify your CRA obligations with qualified
counsel. Sending is opt‑in and can run on cron or on demand from the settings form,
and the module refuses to send to any console URL that is not `https://` (a
`localhost`/`127.0.0.1` loopback is the only exception, for local testing), so your
licence key and inventory never travel in clear text.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — enter your console URL and licence key,
   and send the SBOM.

## Where it lives in the admin menu

Once enabled, the module's settings form sits at **Configuration → System →
Proofwright** (`/admin/config/system/proofwright`). You need the **Administer
Proofwright** (`administer proofwright`) permission — a restricted permission you
should grant only to trusted administrators, since it controls where your software
inventory is sent.
