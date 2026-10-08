# Social Auth Microsoft — manual setup guide

**Social Auth Microsoft** (`social_auth_microsoft`) lets people register and sign
in to your Drupal site with their **Microsoft account**. It adds a
`user/login/microsoft` path that redirects the visitor to Microsoft to
authenticate; when Microsoft returns them, the module matches them to an existing
account (by Microsoft user id or email address) or creates a new one, and an
already-logged-in user can link their Microsoft identity to their account.

It is a provider plugin for the **Social Auth** framework, which standardises
"sign in with X" across many providers: Social Auth owns the login flow, the
account matching and the user-mapping settings, while this module contributes the
Microsoft-specific OAuth pieces. It depends on **Social Auth** (`social_auth
^4.1`), the third-party library `stevenmaguire/oauth2-microsoft ^2.0`, PHP 8.1 or
newer, and Drupal core `^9.5 || ^10 || ^11`. There are no submodules.

If you also looked at **Social Auth Entra ID**, keep the two straight: this module
goes through the Social Auth framework and targets Microsoft accounts generally —
the right choice when your site already runs Social Auth for other providers —
whereas Entra ID is a standalone integration aimed at a specific organisational
tenant. The module does nothing until you register an application in the Azure
portal and paste its client ID and secret into Drupal. Treat the client secret
like a password: keep it in an environment variable / site secret rather than in
exported configuration.

This guide is written for a **human** setting the module up through the admin UI.
If you want terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module together with Social Auth.
2. [Configuration](configuration/index.md) — register the Azure application and
   enter the client ID and secret, step by step.

## Where it lives in the admin menu

The settings form sits at **Configuration → User authentication → Microsoft**
(route `social_auth_microsoft.settings_form`). Visitors sign in from the
**Microsoft** button in the Social Auth login block, or from any link you place to
`user/login/microsoft`.
