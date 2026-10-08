Log Drupal users in with Swedish BankID (BankID.com e-ID) instead of a username and password, matching or provisioning a Drupal account against the authenticated personal number.

---

The BankID module connects a Drupal site to the BankID.com relying-party API (v6.0) and gives visitors a "Login with BankID" button rendered as a block or embeddable form. Clicking it opens a modal that starts an authentication order, shows an animated QR code (and a same-device app link), and polls the order until the user completes it in the BankID app. On completion the module hashes the returned personal number, looks up (or, optionally, creates) a Drupal user through the externalauth `authmap`, and logs that user in — then redirects to a configured path, the request's destination, or the user profile. It requires the Key module (to hold the relying-party client certificate, its passphrase, and the CA/issuer certificate as Key entities) and the externalauth module (to own the account mapping). Separate test and production environments are configured on one settings form, and the login behaviour is pluggable through `@Integration` plugins that implement `getUser()` and `createUser()`, so the account model can be adapted to a CRM or custom logic. Users provisioned via BankID have no Drupal password, so the module hides the password fields on their user-edit form and relaxes core's ProtectedUserField constraint for them.

---

- Add passwordless "Login with BankID" to a Swedish public-sector or municipal Drupal site.
- Authenticate citizens/customers with their national e-ID for e-services, self-service portals, or member areas.
- Place the BankID Authenticate block (`bankid_authenticate_block`) in a region via Block layout (`/admin/structure/block`).
- Embed the login button anywhere with Twig Tweak: `{{ drupal_form('Drupal\\bankid\\Form\\BankIDAuthenticateForm') }}`.
- Offer a modal, animated-QR "Mobile BankID" login for users scanning with their phone.
- Offer a same-device "Open BankID app on this device" `autostarttoken` app link for desktop-with-app or mobile users.
- Auto-provision a new Drupal account on first successful BankID login (optional "Create user" setting).
- Match returning users to their existing Drupal account by the hashed personal number via externalauth.
- Redirect users to a configured landing path (e.g. `/user/dashboard`) after a successful login.
- Honour a `destination` on the login request to return users to where they started.
- Keep relying-party certificate and passphrase out of config/code by storing them as Key entities (File / Config providers).
- Run against BankID's test environment (`appapi2.test.bankid.com`) with the bundled test certificates for development.
- Switch to BankID production (`appapi2.bankid.com`) by pointing the config at bank-issued production certificates.
- Toggle between test and production BankID environments from one settings form without code changes.
- Build a custom `@Integration` plugin (in `src/Plugin/BankID/`) to map BankID identities into an external CRM or bespoke user model.
- Select which integration plugin drives login on the settings form when several are installed.
- Let BankID-provisioned users edit their profile without being asked for a Drupal password (which they don't have).
- Prevent BankID-provisioned users from being blocked from changing protected fields (e.g. email) that normally require a current password.
- Localize / re-map BankID recommended user-message texts (RFA codes) shown during the flow via `BankIDUserMessages`.
- Provide the low-level relying-party API endpoints (`authenticate`, `collect`, `cancel`) for the front-end polling flow.
- Use `hook_bankid_integration_info` alter to adjust or add integration plugin definitions from another module.
