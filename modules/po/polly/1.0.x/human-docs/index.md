# Polly — manual setup guide

**Polly** (`polly`) integrates Drupal with **Amazon Polly**, Amazon Web Services'
text-to-speech service. It converts text — for example an article's body — into
natural-sounding speech audio, so a site can offer a "listen to this page" feature
for accessibility and convenience.

The base module is the integration layer: it connects to Amazon Polly through the
Drupal **AWS** module (which manages your AWS credentials) and lets you configure
your preferred **engine**, **voices** and **countries/languages**. On its own it
does not add a site-builder-facing feature — to actually generate and store audio
you enable one of its submodules or add custom code:

- **Polly Synthesis Task** provides a content entity that stores Polly synthesis
  tasks and processes them on cron, turning queued text into audio in the
  background.
- **Polly Media** provides a media source built on a synthesis-task entity, and can
  adapt media widgets so an editor can synthesize speech for an entity instead of
  manually uploading an audio file.

Because Polly is a paid AWS service reached over the network, using this module
means your site sends text to AWS and incurs AWS charges. Treat your AWS
credentials as secrets and be mindful of what content you send.

Note that this module is **not covered by Drupal's security advisory policy**
(`security_advisory_coverage: not-covered`).

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module and the AWS module
   with Composer, and enable the pieces you need.
2. [Configuration](configuration/index.md) — connect your AWS credentials and set
   your engine, voices and countries.

## Where it lives in the admin menu

Polly's own preferences (engine, voices, countries) live under **Configuration**,
and your AWS credentials are configured through the **AWS** module's settings — see
[Configuration](configuration/index.md) for the details of both.
