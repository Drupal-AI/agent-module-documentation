# Google Credentials — manual setup guide

**Google Credentials** (`google_credentials`) is a small base module that gives your
site one central, secure place to store **Google Cloud service‑account
credentials**. You upload the service‑account JSON once, and other Google Cloud
integration modules (Storage, Pub/Sub, and similar) can reuse those stored
credentials instead of each managing their own copy.

Its whole reason for existing is to avoid credential sprawl: rather than pasting the
same service‑account key into several modules — and risking one of them
misconfiguring or leaking it — you configure it here and let the rest of your Google
Cloud suite share it. On its own it does nothing user‑facing; it's plumbing for
other modules.

Because it handles a genuine secret, follow good practice for the JSON key: keep it
out of version control and prefer an environment‑backed or mounted‑file approach
over committing it into configuration.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.
2. [Configuration](configuration/index.md) — upload and store your Google Cloud
   service‑account credentials.

## Where it lives in the admin menu

Once enabled, its configuration page is at **Configuration → Google → Google Cloud
Credentials**. That's where you upload and manage the service‑account JSON that other
modules will draw on.
