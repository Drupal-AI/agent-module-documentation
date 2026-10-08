# Push Framework — manual setup guide

**Push Framework** (`push_framework`) is a framework for handling and orchestrating
notifications from your Drupal site across many channels. Sites that notify people
tend to accumulate a mess of one-off senders — a hook that mails on publish, a
service that calls a push provider, a third thing for SMS — each with its own retry
behavior and its own idea of a template. Push Framework replaces that with a single
path: a message arrives, is queued, and each configured channel delivers its own
version of it. Retry, logging, rate limiting, and delivery reporting are solved
once rather than per integration.

Crucially, **Push Framework does not send anything by itself.** It is a plugin
framework: channel modules install on top of it to do the actual delivery.
Maintainer-listed channels include **Alerta, Email, Mattermost, OneSignal, Slack,
and Twilio**, with more emerging over time. Separately, source/recipient plugins
supply *what* gets pushed and *to whom* — the maintainers' **DANSE** module is the
recommended companion for that, and there is an **`eca_push_framework`** submodule
so ECA models can emit messages without code. Users can also configure their own
preferences for which notifications they receive on which channels, and the
framework can avoid "spamming" someone across multiple channels at once.

It leans on the **Advanced Queue** module (`advancedqueue`) for durable jobs with
retry, backoff, and a visible job list — a deliberate and significant design
choice over core's much simpler queue API. It also depends on core **Node**,
**Text**, and **User**, and runs on Drupal `^10 || ^11`.

Three things are worth planning before you rely on it. **Queues need a runner** —
jobs sit until something processes them, so decide whether that is cron or a
dedicated worker; a notification framework that only delivers on the next cron run
is not a "push" system. **Channel credentials** (provider keys for push or SMS)
belong in environment variables behind Key entities, never in exported config.
And **consent and preference** — who agreed to receive what, on which channel, and
how they opt out — is a policy question the framework will faithfully ignore unless
you model it.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable the
   framework and its Advanced Queue dependency, and add channel modules.
2. [Configuration](configuration/index.md) — the settings form, the queue runner,
   channels, and where credentials belong.

## Where it lives in the admin menu

The settings form sits at **Configuration → System → Push Framework**
(`/admin/config/system/push_framework`), behind the **Administer site
configuration** permission.
