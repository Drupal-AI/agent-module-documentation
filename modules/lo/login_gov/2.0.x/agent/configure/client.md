<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configure the Login.gov client

The module has **no settings form of its own**. You configure it by creating an **OpenID Connect
client** entity that uses the `login_gov` plugin. The form fields below come from
`OpenIDConnectLoginGovClient::buildConfigurationForm()`
(`src/Plugin/OpenIDConnectClient/OpenIDConnectLoginGovClient.php:101`).

## Where

- Client entities live at **`/admin/config/people/openid-connect`** (route
  `openid_connect.admin_settings`, provided by `openid_connect`). Add a client, pick plugin
  **"Login.Gov"**.
- The private key is a **Key** entity at `/admin/config/system/keys` (Key + Key Asymmetric modules).

## Step 1 — create the RSA key pair and store the private key in a Key entity

Login.gov authenticates the client with **private-key JWT**, so you need an RSA key pair; the public
cert is uploaded to your Login.gov application profile, the private key stays in Drupal. Generate one
(README example):

```shell
openssl req -nodes -x509 -days 365 -newkey rsa:2048 -keyout private.pem -out public.crt
```

Create a Key of type **Private key** (`asymmetric_private`). Choose a provider that keeps the secret
out of exported config — **File** or **Environment** is preferred over **Configuration** (config
would be captured by `drush cex`). The client form's `key_private_key` field is a `key_select`
filtered to `['type' => ['asymmetric_private']]`, so only asymmetric-private keys appear.

## Step 2 — client settings (config keys)

Schema type `openid_connect.client.plugin.login_gov` (`config/schema/login_gov.schema.yml`). Defaults
come from `defaultConfiguration()` (`:87`).

| Form field | Config key | Notes |
|---|---|---|
| Client ID | `client_id` (string, required) | Login.gov calls this the **Issuer**, e.g. `urn:gov:gsa:openidconnect.profiles:sp:sso:<agency>:<application>`. Used as both `iss` and `sub` in the client assertion. |
| Sandbox Mode | `sandbox_mode` (bool, default **TRUE**) | TRUE → `idp.int.identitysandbox.gov`; FALSE → `secure.login.gov`. **Uncheck for production.** |
| Identity Assurance Level | `ial_level` (default `verified`) | One of `auth-only`, `verified`, `verified-facial-match-preferred`, `verified-facial-match-required`. Feeds the `acr_values`. |
| Authentication Assurance Level | `aal_level` (default `phishing_resistant`) | One of `duo`, `separate`, `phishing_resistant`, `require_hspd12`. Feeds the `acr_values`. |
| User fields | `userinfo_fields` (sequence) | Multi-select of the fields to request; each maps to the required OIDC scope. `sub` (UUID) and `email` are **always** fetched. |
| Key from Key | `key_private_key` (Key id) | The `asymmetric_private` Key that signs the JWT client assertion. |

`userinfo_fields` options and their scopes (`$userinfoFields` `:34`, `$fieldToScopeMap` `:65`):
`all_emails`→`all_emails`, `given_name`/`family_name`→`profile:name`, `address`→`address`,
`phone`→`phone`, `birthdate`→`profile:birthdate`,
`social_security_number`→`social_security_number`, `verified_at`→`profile:verified_at`,
`x509`→`x509`, `x509_subject`→`x509:subject`, `x509_presented`→`x509:presented`. Always-fetched:
`sub`→`openid`, `email`→`email`, `ial`/`aal`→`openid`. Some fields require a minimum IAL/AAL — see
Login.gov's Attributes docs.

## Step 3 — Redirect URL

Register your callback with Login.gov. The redirect URL is the openid_connect callback route
(`openid_connect.redirect_controller_redirect`), an absolute URL of the form
`https://<your-site>/openid-connect/login_gov` — add it to the list of valid redirect URIs in your
Login.gov application profile (Login.gov only redirects back to registered URIs).

## IAL/AAL validation

The chosen `ial_level`/`aal_level` are turned into `acr_values` by `generateAcrValue()` (`:278`),
which throws `LoginGovConfigException('Bad client configuration.')` if either value is not in its
allow-list. `ial_level` becomes `urn:acr.login.gov:<ial_level>`; `aal_level` maps to a URN such as
`http://idmanagement.gov/ns/assurance/aal/2?phishing_resistant=true`.

## Sandbox vs production

Sandbox and production are **separate Login.gov registrations** with separate client IDs, keys, and
endpoints; toggling `sandbox_mode` only switches the endpoint host. A working sandbox integration
proves nothing about production — re-register and re-test.

## Migrating from an older release

If you are upgrading, run `drush updatedb`: `login_gov_update_9001` moves a private key that used to
be stored inline (`private_key`) into a generated Key entity, and `login_gov_update_10001` converts
the removed `acr_level`/`require_piv`/`verified_within*`/`force_reauth` settings into the current
`ial_level` + `aal_level` pair.
