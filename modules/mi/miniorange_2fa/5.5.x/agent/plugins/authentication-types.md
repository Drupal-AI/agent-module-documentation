# The `authentication_type` plugin type

miniOrange 2FA defines a plugin type for second-factor methods. Manager
`plugin.manager.miniorange_2fa.authentication_type` (`AuthenticationTypeManager`), discovery dir
`src/Plugin/AuthenticationType/`, annotation `\Drupal\miniorange_2fa\Annotation\AuthenticationType`,
alter hook `miniorange_2fa_authentication_type_info`, base class `AuthenticationTypePluginBase`
(+ `OtpAuthenticationTypePluginBase`, `TotpAuthenticationTypePluginBase`, `QrBasedAuthenticationTypePluginBase`).

## Shipped method plugins (id → method)

| Plugin id | Method |
|---|---|
| `google_authenticator` | TOTP authenticator app (Google/Microsoft/Authy/Duo/LastPass/2FAS/Zoho/SecurID label variants). |
| `microsoft_authenticator` | Microsoft Authenticator (TOTP). |
| `miniorange_authenticator` | miniOrange Authenticator (soft token). |
| `generic_authenticator` | Generic TOTP authenticator. |
| `otp-over-email` | OTP over email. |
| `otp-over-sms` | OTP over SMS. |
| `otp-over-sms-and-email` | OTP over SMS **and** email. |
| `otp-over-phone` | OTP over phone call. |
| `push_notifications` | Push notification approve/deny. |
| `qr_code` | QR-code scan authentication. |
| `email_verification` | Out-of-band email verification link. |
| `kba` | Knowledge-based auth (security questions). |
| `hardware-token` | Hardware OTP token (e.g. YubiKey OTP). |
| `grid_pattern` | Grid-pattern challenge. |
| `web-authn` | WebAuthn / security key (see the `miniorange_webauthn` submodule). |

## Base class capabilities (`AuthenticationTypePluginBase`)

Common helpers a plugin inherits: `getName()`, `getCode()`, `getType()`, `getDescription()`,
`getSupportedDevices()`, `requiresChallenge()` (from the `challenge` definition key), `isOutOfBand()`,
`getIosLink()`/`getAndroidLink()`, `toArray()`, plus protected helpers `getCurrentUser()`,
`getUserEmail()`, `getUserPhoneNumber()`, `createCustomerProfile()`, `createAuthApiHandler()`,
`validateUserSession()`, `validatePasscode()`, and messenger shortcuts. OTP/TOTP subclasses add timer/
resend/flood helpers (`OtpAuthenticationTypePluginBase` guards against resend/timer bypass and logs
warnings).

## Implementing a custom method

1. Add a class in your module's `src/Plugin/AuthenticationType/` annotated with
   `@AuthenticationType(id = "my_method", name = ..., code = ..., challenge = TRUE, ...)`, extending
   `AuthenticationTypePluginBase` (or an OTP/TOTP subclass).
2. Implement the challenge/validate behaviour — most shipped methods delegate to the miniOrange cloud via
   `AuthenticationAPIHandler` (`challenge()`, `validate()`, `getAuthStatus()`); a fully local method must
   provide its own verification.
3. Optionally alter existing definitions with `hook_miniorange_2fa_authentication_type_info_alter()`.

The challenge/validate glue that calls these plugins lives in `MiniorangeAuthenticate` and
`Miniorange2faController` — see [../api/login-flow.md](../api/login-flow.md).
