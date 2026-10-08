# PHPMailer OAuth2 — manual setup guide

**PHPMailer OAuth2** (`phpmailer_oauth2`) adds a modern OAuth2 (XOAUTH2)
authentication client to the PHPMailer SMTP module, so Drupal can send mail through
Microsoft 365 / Azure AD (Outlook / Office 365) SMTP **without storing a
password**. This matters because Microsoft has deprecated basic‑auth SMTP; OAuth2
is now the supported way to authenticate an Exchange Online mailbox for outbound
mail.

The module ships one concrete OAuth2 provider — Azure AD — plus a settings form and
the authorization flow that obtains and stores the tokens. You register an
application in the Azure portal, enter its Client ID, client secret, and Tenant ID
(along with the mailbox email address) on the settings form, then click **Get auth
token** to run the standard OAuth2 authorization‑code flow: Drupal redirects you to
Microsoft's consent screen (requesting the `SMTP.Send` scope plus `offline_access`
for a long‑lived refresh token), and the callback exchanges the returned code for
an access token and a refresh token, saving them into configuration.

From then on, whenever PHPMailer SMTP sends mail, it asks this module's Azure
provider for the current auth details and mints a fresh access token from the stored
refresh token — so no password lives in the mail configuration. Access to the
settings and the OAuth routes is restricted to a dedicated permission. The provider
is pluggable in principle (the plugin type is defined by PHPMailer SMTP), but this
module supplies only the Azure provider.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module and its Composer
   dependencies, and enable it.
2. [Configuration](configuration/index.md) — register the Azure app, fill in the
   settings form, and run the token‑exchange flow.

## Where it lives in the admin menu

The settings form sits at **Configuration → System → PHPMailer OAuth2**
(`/admin/config/system/phpmailer-oauth2`). All of the module's routes — the
settings page and the OAuth login/callback — require the **Administer phpmailer
oauth2 settings** permission, which is a restricted‑access permission granted to
trusted administrators only.
