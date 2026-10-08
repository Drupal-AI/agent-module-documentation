# Configuration

Configuring ePayco has three parts: creating one or more ePayco **settings
entities** that hold your account credentials, keeping those credentials out of
public version control, and (if you use Commerce) attaching ePayco as a payment
gateway.

## Where the API keys are stored

You enter your ePayco keys (client id, key, public key, private key) directly into
the settings‑entity form (see below). The module stores them as part of its Drupal
**configuration** — it does not have a built‑in Key‑module or environment‑variable
integration, so the values live in config. Because of that:

- Do **not** commit exported configuration that contains these values to a public
  repository, and restrict access to config exports.
- Grant the ePayco administration permission only to trusted roles.
- Serve the site over **HTTPS** so credentials and payment traffic are encrypted.

## Create an ePayco settings entity

Go to **Configuration** and create an ePayco **settings** configuration entity.
Each entity is a named set of ePayco account settings — its credentials, test/live
mode, and options — and you can create several. This is what lets you keep, say, a
default set for the site and per‑store overrides so different sellers can use their
own ePayco accounts. Enter the credential values ePayco issued you into the form
fields.

## Test mode vs. live mode

ePayco distinguishes a **test** mode from **live** processing. Do all of your
initial setup and verification in test mode and only switch a settings entity to
live once you have confirmed an end‑to‑end transaction. Double‑check which mode each
settings entity is in before taking real payments — a settings entity left in test
mode will not charge real money, and one switched to live too early will.

## Attach ePayco to Drupal Commerce (if used)

With the **Commerce ePayco** submodule enabled, add a payment gateway at
**Commerce → Configuration → Payment gateways → Add payment gateway**, choose the
ePayco gateway (Standard checkout or One page checkout), and point it at your
settings entity. You can override the pre‑defined settings per store where you want
individual stores to use their own ePayco account.

Make sure the credentials in the settings entity are correct so the outbound
checkout request signs and the pending‑payment reconciliation (cron / the
`drush commerce_epayco:check_pending_payments` command) can look transactions up on
ePayco. Serve the site over **HTTPS**.

## Control who can administer it

The module provides its own permissions. At **People → Permissions**
(`/admin/people/permissions`), grant ePayco administration only to trusted roles.

## Save

Save each settings entity (and the Commerce gateway, if used). Run a full test
transaction in test mode and confirm the order and its payment are recorded as you
expect before switching to live.
