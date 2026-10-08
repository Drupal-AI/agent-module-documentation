# AhaSend — manual setup guide

**AhaSend** (`ahasend`) routes your site's outbound email through the
[AhaSend](https://ahasend.com/) email-delivery service instead of sending it
straight from your server. Delivery services like AhaSend generally improve
deliverability (fewer messages landing in spam) and give you tracking of what was
sent. AhaSend does this by providing a **Mail System plugin**, so once it is
selected, Drupal hands its outgoing mail to AhaSend's API for delivery.

It depends on the [Mail System](https://www.drupal.org/project/mailsystem)
module, which is what lets you choose AhaSend as the mail handler for your site (or
for specific mail). Administration is gated by the module's own **administer
ahasend** permission.

**A note on credentials.** AhaSend needs an API credential to send on your behalf.
Store it securely — in an environment variable rather than committed configuration
— so the secret never ends up in version control. See
[Configuration](configuration/index.md) for how.

This guide is written for a **human** setting the module up through the admin UI.
If you want terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it alongside Mail System.
2. [Configuration](configuration/index.md) — store the API credential, grant the
   permission, and select AhaSend in Mail System.

## Where it lives in the admin menu

You select AhaSend as the mail handler through **Mail System**, at
**Configuration → System → Mail System** (`/admin/config/system/mailsystem`). The
module's own settings are controlled by the **administer ahasend** permission,
assigned under **People → Permissions**.
