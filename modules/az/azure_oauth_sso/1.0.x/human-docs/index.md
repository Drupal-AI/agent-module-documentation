# Azure OAuth Client SSO — manual setup guide

**Azure OAuth Client SSO** (`azure_oauth_sso`) lets people sign in to Drupal with
their **Microsoft Entra ID (Azure AD)** account — the Microsoft 365 identity most
organisations already have — instead of a separate Drupal password. It implements the
OAuth authorization‑code flow directly against `login.microsoftonline.com` and can map
directory fields (name, job title, department, photo) and directory groups onto the
Drupal user and its roles. It runs on Drupal 9, 10 and 11.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable it.
2. [Configuration](configuration/index.md) — register the Azure app, enter the client
   credentials, and set up field/role mapping.

## Where it lives in the admin menu

Configuration is at the module's customer‑setup form (route
`azure_oauth_sso.customerSetup`). The login route is `/oauth/login`, which redirects
the visitor to Microsoft and receives the callback.
