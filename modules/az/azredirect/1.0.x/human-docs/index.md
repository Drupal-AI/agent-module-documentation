# AZRedirect — manual setup guide

**AZRedirect** (`azredirect`) sends users to the Azure AD (Microsoft Entra ID)
login portal for single sign‑on. It works on top of the
[OpenID Connect Windows Azure Active Directory](https://www.drupal.org/project/openid_connect_windows_aad)
module (`openid_connect_windows_aad`), automating the redirect into the Azure OIDC
login flow so visitors are taken straight to Azure to authenticate.

AZRedirect itself is only the redirect layer. All the real authentication work —
talking to Azure, exchanging and validating tokens, and mapping the returned
identity to a Drupal user — is done by the underlying `openid_connect_windows_aad`
module. So AZRedirect is a convenience on top of that module, not a standalone SSO
client. It supports Drupal 9, 10, and 11.

Because the actual OAuth/OIDC client credentials live in the underlying module,
that is where you configure the connection to Azure — and where you must keep the
client secret secure (supplied via an environment variable, never committed).

This guide is written for a **human** setting the module up. If you want terse,
token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it (the OpenID Connect Windows AAD module is required).

## How to use it

1. Install and configure **OpenID Connect Windows Azure Active Directory**
   (`openid_connect_windows_aad`) with your Azure app registration — client ID,
   client secret, tenant, and endpoints. Keep the client secret in an environment
   variable (via a Key entity or `getenv()`), not in committed configuration.
2. Enable AZRedirect. It automates the redirect that sends users into that Azure
   OIDC login flow, so they go straight to the Azure login portal for
   authentication.

There is nothing security‑critical to configure in AZRedirect itself — the
sensitive credentials and token handling all belong to the underlying
`openid_connect_windows_aad` module.
