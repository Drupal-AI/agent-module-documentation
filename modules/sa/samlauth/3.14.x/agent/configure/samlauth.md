# Configure SAML SP/IdP, endpoints & user mapping

Everything is stored in one config object: **`samlauth.authentication`** (schema:
`config/schema/samlauth.schema.yml`). Edit via two admin forms or `drush cset`.

## Admin forms & routes

| Route | Path | Purpose | Permission |
|---|---|---|---|
| `samlauth.samlauth_configure_form` (the `configure` route) | `/admin/config/people/saml` | Login/logout behavior, Drupal-login-using-SAML-data, user create/link/sync | `configure saml` |
| `samlauth.saml_configure_form` | `/admin/config/people/saml/saml` | SP & IdP entity IDs, endpoint URLs, certificates, message signing/validation | `configure saml` |

## The `/saml/*` endpoints (fixed paths, from `samlauth.routing.yml`)

| Route | Path | What it does |
|---|---|---|
| `samlauth.saml_controller_login` | `/saml/login` | Start SP-initiated login (redirects to IdP). Anonymous only. Supports `?destination=…`. |
| `samlauth.saml_controller_reauth` | `/saml/reauth` | Force a fresh IdP login screen (ForceAuthn), bypassing an existing IdP session. |
| `samlauth.saml_controller_acs` | `/saml/acs` | **Assertion Consumer Service** — receives & validates the IdP response, logs the user in. |
| `samlauth.saml_controller_sls` | `/saml/sls` | Single Logout Service — handles IdP-initiated / response logout. |
| `samlauth.saml_controller_logout` | `/saml/logout` | Start SP-initiated logout. |
| `samlauth.saml_controller_metadata` | `/saml/metadata` | Publish SP metadata XML for the IdP. Gated by `view sp metadata`. |
| `samlauth.saml_controller_changepw` | `/saml/changepw` | Redirect to the IdP change-password URL. Logged-in users only. |

Give the IdP administrator your **Entity ID**, the **ACS URL** (`…/saml/acs`) and **SLS URL**
(`…/saml/sls`), or just the metadata URL. Endpoint URLs are hardcoded by the module (not
configurable). The php-saml toolkit needs the IdP's SSO endpoint to offer the **HTTP-Redirect**
binding (POST binding is unsupported).

## Key config groups in `samlauth.authentication`

**Service Provider** — `sp_entity_id` (may contain `[site:base-url]`), `sp_name_id_format`,
`sp_x509_certificate`, `sp_private_key`, `sp_new_certificate` (for cert rotation). The private
key/cert can live in config, in a filesystem path, or (recommended) be referenced from a **Key**
entity (the `key.repository` service is injected optionally into `SamlService`).

**Identity Provider** — `idp_entity_id`, `idp_single_sign_on_service`,
`idp_single_log_out_service`, `idp_change_password_service`, `idp_certs` (sequence),
`idp_cert_encryption`. Copy these from the IdP's metadata XML (the module has no XML parser yet).

**Unique ID & user mapping** — `unique_id_attribute` (the stable NameID or attribute that
identifies a login — **set once, never change**), `create_users`, `map_users` /
`map_users_name` / `map_users_mail` / `map_users_roles` (link existing accounts by
name/email/role), `sync_name` / `sync_mail`, `user_name_attribute`, `user_mail_attribute`,
`request_set_name_id_policy`. Links are stored in externalauth's `authmap` table (provider
`samlauth`); manage/delete them at `/admin/people/authmap/samlauth`.

**Login/logout behavior** — `login_auto_redirect` (send the Drupal login form straight to SAML),
`login_redirect_url`, `logout_redirect_url`, `error_redirect_url`, `drupal_login_roles` (roles
still allowed to use local Drupal login when linked to SAML), `logout_drupal_idp` (log out of the
IdP when logging out of Drupal), `local_login_saml_error`, `login_error_keep_session`,
`login_menu_item_title` / `logout_menu_item_title` / `login_link_title`.

**Message construction / validation (security)** — booleans such as `strict`,
`security_authn_requests_sign`, `security_logout_requests_sign`, `security_logout_responses_sign`,
`security_messages_sign` (require incoming to be signed), `security_assertions_signed`,
`security_assertions_encrypt`, `security_nameid_encrypt`, `security_want_name_id`,
`security_request_authn_context`, plus `security_signature_algorithm` /
`security_encryption_algorithm`. Defaults (`config/install/samlauth.authentication.yml`) enable
signing and `strict: true`.

**Debugging** — `debug_log_in`, `debug_log_saml_in` (log incoming SAML messages to discover
attribute names), `debug_log_saml_out`, `debug_phpsaml`, `debug_display_error_details`.

## Drush examples

```
drush cset samlauth.authentication login_auto_redirect 0           # stop auto-redirect to SAML
drush cset samlauth.authentication unique_id_attribute email       # use 'email' as the unique ID
drush cset --input-format=yaml samlauth.authentication drupal_login_roles '["authenticated"]'
```

Config is a plain config object, so it exports/deploys with `drush config:export`.
