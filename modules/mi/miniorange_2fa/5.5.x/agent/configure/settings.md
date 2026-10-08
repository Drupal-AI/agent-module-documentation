# Configure miniOrange 2FA

All admin screens live under `/admin/config/people/miniorange_2fa/*` and persist to the config object
`miniorange_2fa.settings`. The `configure` route (`miniorange_2fa.customer_setup`) is the **Account &
License** tab. **A miniOrange (Xecurify) account is required** — most method setup and OTP
challenge/validate are delegated to the miniOrange cloud API using the stored customer credentials.

## Admin tabs (routes → forms)

| Route | Path | Permission | Purpose |
|---|---|---|---|
| `miniorange_2fa.customer_setup` | `/customer_setup` | `miniorange 2fa customer setup` | Register/login the miniOrange customer account; deregister; disable 2FA for all users. |
| `miniorange_2fa.setup_twofactor` | `/setup_twofactor` | `administer site configuration` | Configure 2FA for the primary admin. |
| `miniorange_2fa.login_settings` | `/login_settings` | `miniorange 2fa login settings` | The 2FA policy for end users (see keys below). |
| `miniorange_2fa.user_management` | `/user_management` | `miniorange 2fa user management` | Reset / enable / disable 2FA per user. |
| `miniorange_2fa.headless` | `/headlesSsetup` | `miniorange 2fa headless` | Headless / API 2FA setup. |
| `miniorange_2fa.licensing` | `/licensing` | `miniorange 2fa licensing` | Upgrade plan / license. |
| `miniorange_2fa.addons` | `/addons` | `administer site configuration` | Advanced security add-ons. |
| `miniorange_2fa.configure_admin_2fa` | `/configure_admin_2fa` | `administer site configuration` | Choose the admin's authentication method. |

State-changing user-management endpoints (`reset/{user}`, `update_status/{user}/{enabled}`,
`activate_2fa_method/{method_name}`, `delete-logs`) require the relevant `restrict access: true`
permission **and** a `_csrf_token`.

## Key policy settings (`miniorange_2fa.settings`, set on the Login Settings tab)

| Key | Meaning |
|---|---|
| `mo_auth_enable_two_factor` | **Master switch** — 2FA is enforced at login only when TRUE. |
| `mo_auth_enable_allowed_2fa_methods` / allowed-methods config | Restrict which methods users may use. |
| `mo_auth_2fa_allow_reconfigure_2fa` | Allow users to re-configure their method. |
| `mo_auth_2fa_allow_recovery_codes` | Enable recovery codes (gates the `/user/{user}/recovery-codes` routes). |
| `mo_auth_enable_role_based_2fa` + `mo_auth_role_based_2fa_roles` | Enforce 2FA only for chosen roles. |
| `mo_auth_enable_domain_based_2fa` + `mo_auth_domain_based_2fa_domains` | Enforce 2FA only for chosen email domains. |
| `mo_auth_enable_trusted_IPs` + `mo_auth_trusted_IP_address` | Skip 2FA for trusted IPs. |
| `mo_auth_enable_whitelist_IPs` + `mo_auth_whitelisted_IP_address` | IP whitelist. |
| `mo_auth_use_only_2nd_factor` / `mo_auth_2fa_use_pass` | Passwordless (second-factor-only) login. |
| `mo_auth_enable_login_with_email` / `mo_auth_enable_login_with_phone` | Log in by email/phone instead of username. |
| `mo_auth_enable_2fa_for_password_reset` | Require 2FA during the password-reset link flow (`InitSubscriber`). |
| `mo_auth_2fa_for_apis` | Gate Basic-Auth API requests behind completed 2FA (`TfaBasicAuthDecorator`). |
| `mo_auth_2fa_drush` | Allow the Drush command to change a user's 2FA status (off = command refuses). |
| `mo_auth_flood_control_otp` / `mo_auth_number_of_otp_attempts*` | OTP flood control & attempt limits. |
| `mo_auth_rba` / `rba_allowed_devices` | Remember-device (risk-based auth). |
| `mo_auth_enable_headless_two_factor` / `mo_auth_headless_2fa_method` | Headless 2FA API. |
| `mo_auth_customer_id` / `mo_auth_customer_api_key` / `mo_auth_customer_token_key` | miniOrange cloud credentials (populated by the customer-setup registration; used for all API calls). |

## Emergency backdoor URL (security-relevant — off by default)

The Login Settings tab exposes `mo_auth_enable_backdoor`. When enabled, an emergency URL
`/user/login?skip_2fa=<mo_auth_customer_api_key>` lets a user **bypass the second factor**:
`MoAuthUtilities::moBackdoorLogin()` skips 2FA only if the `skip_2fa` query value equals the stored
customer API key **and** the user holds role `administrator` or `admin`.

- It is **disabled by default** (`mo_auth_enable_backdoor` unset/false).
- It still requires valid primary credentials (password) and an admin role; the query value acts as a
  shared secret (the customer API key).
- Caveat to flag to operators: enabling it puts a bypass secret in a **GET query string** (recorded in
  server access logs, browser history, and `Referer` headers). Treat it as break-glass only, and disable
  it once recovered. (This is by-design emergency access, not a default weakness.)

## Setting config with Drush

```bash
ddev drush cget miniorange_2fa.settings mo_auth_enable_two_factor
# The customer_id/api_key/token_key are populated by registering on the Account & License tab;
# do not hand-edit them.
```
