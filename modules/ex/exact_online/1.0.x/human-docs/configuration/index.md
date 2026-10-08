# Configuration

Connecting to Exact Online is an OAuth flow: you register an application in Exact
Online, give Drupal that application's **Client ID** and **Client Secret**, and then
authorize the connection so the module can obtain and store OAuth tokens.

## 1. Create an Exact Online application

In your Exact Online account, create an application. Exact Online gives you a **Client
ID** and a **Client Secret** for it. You will also configure the app's redirect URI to
point back at your Drupal site (the module's OAuth callback).

## 2. How the module stores the credentials

You enter the Client ID and Client Secret on the settings form (next step). The module
saves the **Client ID** into its configuration object (`exact_online.settings`) and keeps
the **Client Secret** in Drupal's State store (the State key `exact_online.client_secret`),
which is not part of exported configuration. There is no separate environment-variable
setup step — the settings form is where these values live.

## 3. Enter the settings

Go to **Configuration → Web services → Exact Online → Settings**
(`/admin/config/services/exact-online/settings`) and provide:

- **Client ID** — the identifier from your Exact Online application.
- **Client Secret** — the secret from your Exact Online application.

Save the form.

## 4. Authorize the connection

Complete the OAuth authorization so Drupal receives and stores its access/refresh
tokens. Once connected, the **dashboard** shows the connection status, and the **log
view** records connection-related entries you can check if anything goes wrong.

## Building the actual sync

Remember this module only establishes the connection. To move data between Drupal and
Exact Online (invoices, customers, and so on), you write custom code against the
connected `picqer/exact-php-client` client — the specifics depend on your business
logic.
