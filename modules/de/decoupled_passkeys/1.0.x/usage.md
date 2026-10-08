Decoupled Passkeys exposes WebAuthn passkey registration and login for a decoupled (headless) Drupal front-end through four JSON:RPC methods.

---

Decoupled Passkeys is a thin JSON:RPC front-door over the WebAuthn framework. It ships no UI, no config, and no HTTP routes of its own — only four `@JsonRpcMethod` plugins (`user.register_device_options`, `user.register_device`, `user.request_options`, `user.authenticate_request`) that a JavaScript/TypeScript client (for example `@simplewebauthn/browser`) calls through the JSON:RPC module's endpoint. Each method delegates the actual WebAuthn work — building creation/request options, verifying attestation and assertion, and storing credentials — to the `public_key_credential_source.webauthn` service provided by the `public_key_credential_source` / `webauthn_framework` dependencies. Registration options and device registration are gated by the `create public key credential source entities` permission (from `public_key_credential_source`) and act on the current authenticated user; login-option retrieval and assertion are gated by this module's own `login by passkey` permission. On a successful assertion the account bound to the verified credential is logged in with core's `user_login_finalize()`. The passkey display name is the Drupal account display name, or the email address when the Email Registration module is enabled.

---

- Add passkey (FIDO2/WebAuthn) sign-in to a decoupled React/Vue/Next.js/mobile front-end backed by Drupal.
- Let an already-logged-in user register a new passkey device from a headless account/security screen.
- Fetch WebAuthn *creation* options for the current user by calling `user.register_device_options` (no parameters).
- Complete device registration by posting the stringified attestation JSON to `user.register_device`.
- Fetch WebAuthn *request* (login) options for a given user handle via `user.request_options`.
- Authenticate a returning user by posting the stringified assertion JSON plus user handle to `user.authenticate_request`.
- Drive the browser side with `@simplewebauthn/browser` (`startRegistration()` / `startAuthentication()`) against these endpoints.
- Replace or supplement password login with a phishing-resistant passkey flow on a JSON:RPC-enabled site.
- Support platform authenticators (Touch ID, Windows Hello, Android biometrics) and roaming security keys for headless logins.
- Establish a Drupal session cookie for a decoupled client after a verified passkey assertion.
- Show the user's email address (via Email Registration) as the passkey handle so their password manager surfaces the right credential.
- Restrict who may register passkeys using the `create public key credential source entities` permission per role.
- Restrict who may log in with passkeys using the `login by passkey` permission per role.
- Log passkey registration/authentication errors to the `decoupled_passkeys` logger channel for debugging.
- Build a progressive-enhancement login where passkeys are offered alongside existing password auth.
- Provide account-recovery-independent second-factor or primary-factor auth for headless apps.
- Prototype passkey support on Drupal 10.3+/11 where a coupled WebAuthn module does not fit a decoupled architecture.
- Integrate passkeys into a mobile app that talks to Drupal over JSON:RPC.
- Centralize WebAuthn relying-party configuration in the `webauthn_framework` layer while this module only exposes the transport.
