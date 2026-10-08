# Let's Encrypt Challenge — manual setup guide

**Let's Encrypt Challenge** (`letsencrypt_challenge`) helps you complete the
ACME **HTTP-01** validation that Let's Encrypt uses to prove you control a
domain — but from *inside* Drupal, on a host where you cannot simply drop a file
into the web root. It is a small, focused module for the **manual** certificate
workflow.

Here is the situation it solves. When Let's Encrypt issues or renews a
certificate, it fetches a token from a URL like
`http://www.example.com/.well-known/acme-challenge/FILENAME` and checks that the
value it finds matches what it expects. Normally the ACME client (certbot, lego,
and friends) writes that little file itself — which needs filesystem access to
the docroot. On a platform-as-a-service host, a read-only container image, or a
site whose docroot is rebuilt on every deploy, that access simply isn't
available. This module lets you paste the challenge value into an admin form
instead, and Drupal then serves it back at the exact path the validation server
asks for.

As a convenience, it will also serve the contents of a real file placed at
`public://letsencrypt_challenge/FILENAME` if one exists there — useful with
clients (such as lego) that can write the challenge file into that directory for
you. The challenge value is stored in Drupal's **state**, not in configuration,
so it is a short-lived token that never ends up in a config export.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable it, and
   (for Apache) tweak `.htaccess` so the challenge path is reachable.
2. [Configuration](configuration/index.md) — the challenge form, where you paste
   the validation value.

## Where it lives in the admin menu

Once enabled, the challenge form lives at **Configuration →
Let's Encrypt Challenge** (`/admin/config/letsencrypt_challenge/challenge`),
behind the **Administer Let's Encrypt challenge** permission. The two public
routes it adds — `/.well-known/acme-challenge` and
`/.well-known/acme-challenge/{key}` — are intentionally open to everyone,
because the Let's Encrypt validation server is unauthenticated by protocol
design and the challenge value is a public token, not a secret.

## How to use it

1. Run your ACME client in **manual** mode (for example `certbot certonly
   --manual --preferred-challenges http`). It prints a challenge value and the
   filename it expects to be served.
2. Open the challenge form (above) and paste the value in.
3. Let the client continue — Let's Encrypt fetches the token from your site,
   Drupal returns the stored value, and validation completes.
4. Finish the client's flow to obtain or renew the certificate.

Note that this module serves the **single** stored value for any requested
filename, so it fits the one-challenge-at-a-time manual flow rather than several
concurrent multi-domain challenges. If you are running an automated client that
*can* write into the docroot, you do not need this module — and the two would
compete over the same path.
