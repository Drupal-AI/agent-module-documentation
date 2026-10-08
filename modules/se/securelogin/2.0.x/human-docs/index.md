# Secure Login — manual setup guide

**Secure Login** (`securelogin`) forces the user login form — and any other forms
you choose — to be submitted over **HTTPS**, and turns any HTTPS login into an
HTTPS‑only secure session. The goal is simple: passwords and authenticated session
cookies should never travel over plain HTTP where they could be sniffed.

On a site that is reachable over both HTTP and HTTPS, the module guarantees that
sensitive forms always POST to the secure address. Depending on your setting, it
either rewrites the form's action to the secure URL or redirects the whole page to
HTTPS so the visitor visibly lands on a secure URL before submitting. Out of the box
it secures the core user forms — login, registration, edit, and the
password‑request/reset forms — and it also re‑secures the login block on every page
and redirects insecure one‑time password‑reset links to their HTTPS equivalent.

You pick which forms are covered on a single settings page. Core and many contrib
forms (node, comment, contact, Webform) can be ticked from a checklist, you can add
arbitrary custom form IDs, or you can flip one switch to submit **every** form over
HTTPS. For sites whose TLS certificate covers only one hostname, you can set an
explicit secure base URL.

> **Prerequisite: HTTPS must already work on your site.** Secure Login does not
> install or terminate TLS — it assumes your server already serves the site over
> `https://` with a valid certificate. If HTTPS isn't set up (or, behind a
> TLS‑terminating reverse proxy, if Drupal's `reverse_proxy` settings aren't
> correct), forcing forms to HTTPS will break logins rather than secure them. Set up
> a working certificate first.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable it, and the
   HTTPS prerequisite.
2. [Configuration](configuration/index.md) — choose which forms to secure and the
   redirect and base‑URL options.

## Where it lives in the admin menu

The settings form is at **Configuration → People → Secure Login**
(`/admin/config/people/securelogin`).

## How to use it

Once HTTPS works, enable the module and it immediately secures the core user forms
with sensible defaults. Visit the settings page to add more forms or tighten the
behavior. See [Configuration](configuration/index.md).
