# Configuration

All of SMS Framework's administration lives under **Configuration → SMS Framework**
(`/admin/config/smsframework`), which requires the **Administer SMS Framework** permission (a
restricted permission — grant it only to trusted admins). There are three areas: global
settings, gateways, and phone-number settings, plus the verification page.

## Global settings

At **Configuration → SMS Framework → Settings**
(`/admin/config/smsframework/settings`) you control:

- **Fallback gateway** *(default: Log)* — the gateway used to send a message when nothing else
  has selected one. On a fresh install this is the built-in **Log** gateway.
- **Verification page path** *(default: `/verify`)* — where the phone-number verification form
  lives. It must start with `/`. Changing it rebuilds the site's routes.
- **Verification flood limit** *(default: 5)* — how many verification attempts are allowed
  within the window, to resist brute-forcing codes.
- **Verification flood window** *(default: 6 hours)* — the time window, in seconds, for that
  limit.

## Gateways

At **Configuration → SMS Framework → Gateways**
(`/admin/config/smsframework/gateways`) you add, edit, and delete gateways. Each gateway is a
configuration entity that pairs a **plugin** (the provider integration) with its **settings**.

The default install ships one gateway, **Log**, which writes messages to Drupal's log and
marks them delivered — perfect for development and testing. To send real texts:

1. Install the provider module for your SMS company (each real gateway is a separate contrib
   module built for SMS Framework).
2. Add a gateway here, select that provider's plugin, and enter its API credentials in the
   plugin settings.

Per-gateway options also include **skip queue** (send immediately instead of queueing), the
**incoming** and **delivery-report** webhook paths (both must start with `/`), and how long to
**retain** incoming/outgoing message entities.

> **Security reminder:** the incoming-message route a gateway creates is public, and the
> delivery-report access check only confirms the gateway supports pushed reports — it is not
> authentication. Providers call these endpoints server-to-server, so the gateway plugin must
> verify each callback (signature or shared secret) before trusting it. Confirm your chosen
> gateway does this. The default Log gateway creates no such endpoints.

## Phone-number settings

At **Configuration → SMS Framework → Phone number**
(`/admin/config/smsframework/phone_number`) you bind an **entity type + bundle** (most
commonly *User*) to a telephone field so those entities can have a verified phone number. For
each binding you set:

- The **telephone field** that stores the number (the form can auto-create one for you).
- The **verification message** sent to the user (it includes the one-time code via a token).
- The **code lifetime** — how long a verification code stays valid.
- Whether to **purge** unverified numbers.

Adding a binding for *User* is the typical setup for verifying your users' phone numbers.

## The verification page

Once phone-number settings exist, users confirm their number at the verification form (default
path **`/verify`**, permission **`sms verify phone number`**). They enter the code they
received by SMS; the form is flood-limited using the settings above, checks the code is valid,
unused, and not expired, and then marks the number verified. Verification codes are generated
and sent automatically when a number needs verifying.

## Drush

There are no SMS-specific Drush commands. Manage the settings and gateway entities with the
standard config commands, for example:

```bash
ddev drush cget sms.settings
ddev drush cr   # rebuild routes after changing the verify path
```
