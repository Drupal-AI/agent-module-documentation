# Azure AD Login — manual setup guide

**Azure AD Login** (`azure_ad_login`) lets people sign in to Drupal with their
Microsoft **Entra ID (Azure AD)** account. It adds a *"Login with your Azure AD
account"* link to the standard Drupal login form; clicking it sends the visitor to
Microsoft to authenticate and then back to Drupal, logged in. Use it when your
organization already manages identities in Azure AD and you want staff to reach
Drupal with their corporate credentials instead of a separate Drupal password.

Under the hood it uses the OAuth 2.0 **authorization‑code** flow. When a user
returns from Azure, the module exchanges the code for an access token, reads the
signed‑in user's profile from Microsoft Graph (`/me`), and then matches an existing
Drupal account by the Azure `userPrincipalName` — or **auto‑provisions** a new
Drupal account (with a random password) if none exists. It can also map Azure
security groups to Drupal roles, assigning roles to new users based on their Azure
group membership. It works on Drupal 9.1+ and 10, depends only on core `user`, and
leaves Drupal's local login in place alongside it.

This guide is written for a **human** setting the module up. If you want terse,
token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — register the Azure app, set the
   client ID/secret, tenant and endpoints, and map groups to roles.

## Where it lives in the admin menu

Its settings form sits under **Configuration → Web services** at
`/admin/config/services/azure-ad-login`, behind the **`administer azure_ad_login
configuration`** permission. The login link only appears once at least one
role/group mapping is configured.
