# SharpSpring CRM — manual setup guide

**SharpSpring CRM** (`sharpspring_crm`) connects Drupal Webforms to the SharpSpring
marketing CRM. When someone submits a webform you have wired up, the module sends
that submission to SharpSpring — either as a new CRM **lead** or as a subscription to
a SharpSpring email **list** — through SharpSpring's JSON Public API.

It works through two Webform handler plugins that you attach to any webform:

- **SharpSpring Lead Handler** — maps webform fields to SharpSpring lead fields and
  creates a lead in SharpSpring when the form is submitted. If a lead fails to reach
  SharpSpring, the handler emails a backup address with a link to the submission so
  nothing is silently lost.
- **SharpSpring List Handler** — adds the submitter's email address to a SharpSpring
  active list you choose (handy for newsletter or event signups).

You enter your SharpSpring credentials — an account ID, a secret key, and a fallback
backup email — on the module's settings form, which is gated by the **Administer
sharpspring settings** (`administer sharpspring settings`) permission. It supports
Drupal 9 and 10.

**Important security note.** Every SharpSpring API call this module makes goes to
`http://api.sharpspring.com/pubapi/v1/…` over **plain HTTP**, with your `accountID`
and `secretKey` placed directly in the URL's query string. That means the API secret
is transmitted in cleartext and could be read or logged by anything on the network
path between your server and SharpSpring. The secret is also stored in ordinary
module configuration. If you must run this integration, front its outbound traffic
with an HTTPS-terminating egress proxy, treat the secret as exposed on the wire, and
rotate the SharpSpring secret key if you suspect it has leaked.

This guide is written for a **human** setting the module up. If you want terse,
token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.
2. [Configuration](configuration/index.md) — enter your credentials and attach the
   handlers to a webform.

## Where it lives in the admin menu

The settings form is at **Configuration → SharpSpring CRM → settings**
(`/admin/config/sharpspring_crm/settings`). The Lead and List handlers are attached
per webform under each form's **Settings → Handlers** area.
