# NoBotIQ Spam Protection — manual setup guide

**NoBotIQ Spam Protection** (`nobotiq_spam_protection`) adds AI-powered,
invisible spam filtering to your Drupal forms. When a visitor submits a protected
form, the module sends the submitted text and/or email address to the
**NoBotIQ AI engine at nobotiq.com** in real time, and blocks the request before
it reaches your inbox or database if spam is detected — with no CAPTCHA and no
friction for legitimate users. It can check contact-form messages, comments, user
registrations, and webform submissions, and it can verify email addresses
(catching disposable, temporary, and spam-trap addresses) either on their own or
together with the text in a single "hybrid" call.

Because it is an external service, two things are important to understand up
front. First, this is an **egress integration**: submitted content and email
addresses (and potentially the visitor's IP) leave your server and are sent to
NoBotIQ, so disclose it in your privacy policy and make sure you're comfortable
with what gets sent. Second, it uses **token-based billing** — you sign up at
nobotiq.com (3,000 free credits on registration), and credits are consumed per
API call based on text length. Serve your site over HTTPS and decide how the
module should behave if the API is unreachable (fail-open vs fail-closed) for
your risk tolerance.

The module authenticates with credentials stored securely through the **Key**
module (a good practice this guide leans into below). It depends on **Key**,
**Views**, and **Views Bulk Operations**, and provides its own permissions. It
needs the PHP `curl` extension and outbound HTTPS access to `nobotiq.com`.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer (with its Key /
   Views / VBO dependencies) and enable the module.
2. [Configuration](configuration/index.md) — register with NoBotIQ, store the
   credentials securely, and choose which forms to protect.

## Where it lives in the admin menu

After enabling the module, its settings form is at **Configuration → Web
services → NoBotIQ Spam Protection** (`/admin/config/services/spam-protection`).
