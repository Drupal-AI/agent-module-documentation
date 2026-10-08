# SecKit CSP Nonce — manual setup guide

**SecKit CSP Nonce** (`seckit_csp_nonce`) automatically adds a Content Security
Policy (CSP) **nonce** to the inline scripts on your site, so you can run a strict
CSP without resorting to `'unsafe-inline'`. A nonce is a "number used once": on
every page request the module generates a fresh, cryptographically random value,
stamps it onto each inline `<script>` tag, and includes the same value in your
CSP `script-src` header. The browser then executes only scripts carrying the
correct per-request nonce and blocks everything else.

The problem it solves is a genuine tension in web security. Modern CSP is meant to
stop cross-site scripting (XSS), but by default it blocks *all* inline JavaScript.
The tempting workaround, `'unsafe-inline'`, allows legitimate inline scripts —
and also any malicious script an attacker manages to inject, defeating the whole
point. A nonce-based policy lets your own inline scripts run while an injected
inline script, lacking the current nonce, will not execute. The module aims to
catch inline scripts from everywhere they appear: Drupal core and contrib,
theme Twig templates, raw `#markup`, Google Tag Manager container snippets, and
other third-party widgets.

This is a **positive security** feature — it strengthens your defenses rather than
gating access, and it has no access-control role. Two things matter when you adopt
it: your CSP must actually be configured to **require** the nonce (that is, you
must drop `'unsafe-inline'` from `script-src`, or the nonce buys you nothing), and
**every** legitimate inline script must receive the nonce, or those scripts will
break. The module can run standalone, generating and enforcing its own CSP header,
or it can integrate with the **Security Kit (SecKit)** module and add the nonce to
SecKit's existing CSP. It has no module dependencies of its own and supports
Drupal 9, 10, and 11.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.
2. [Configuration](configuration/index.md) — choose the operation mode, decide
   how it interacts with SecKit, and confirm your CSP requires the nonce.

## How to use it

Once enabled and configured, the module works automatically on every page — you
do not tag scripts by hand. It generates the per-request nonce, applies it to
inline scripts across core, contrib, your theme, and third-party integrations,
and adds it to the CSP header. Your job is to make sure the resulting CSP is
strict (no `'unsafe-inline'`) so the nonce is what actually authorizes inline
scripts.
