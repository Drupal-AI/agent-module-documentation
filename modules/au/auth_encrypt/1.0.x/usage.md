Auth Encrypt encrypts the password (and login username) fields of Drupal's core authentication forms in the browser and decrypts them on the server, so those fields are not submitted in cleartext form values.

---

Auth Encrypt attaches to the core login, registration, and user-edit forms (`user_login_form`, `user_register_form`, `user_form`). On each form render it generates a per-form, per-session random key server-side, stores it in an expirable key/value store for 5 minutes, and embeds it in the form as a hidden `auth_encrypt_key` field. Client-side JavaScript (using the CryptoJS library) hashes that key with SHA-256 and AES-256-encrypts the relevant fields on submit. A form-validation callback on the server re-derives the same key, decrypts the fields with PHP's OpenSSL, hands plaintext back to core's normal authentication pipeline, and logs any key mismatch or decryption failure. The module requires no configuration, provides no settings form, permission, entity, or Drush command, and has no module dependencies (only the PHP OpenSSL extension and the CryptoJS front-end library). It transparently falls back to accepting plaintext when the JavaScript does not run.

---

- Add browser-side encryption of the password field on the core user login form.
- Encrypt the username as well as the password when users log in.
- Encrypt the current-password and new-password fields on the user-edit / account form.
- Encrypt password fields on the user registration form.
- Deploy credential-form encryption with zero configuration — install and enable, nothing to set up.
- Avoid a settings page or extra permissions to manage — the module wires itself to the auth forms automatically.
- Generate a fresh encryption key for every form render and every session, expiring after 5 minutes.
- Reject stale or tampered submissions when the embedded key no longer matches the server's stored key ("Form session expired. Please try again.").
- Log security-relevant events (key mismatch, decryption failure) to the `auth_encrypt` logger channel for auditing.
- Serve the CryptoJS library from a CDN out of the box, with no local asset install required.
- Optionally self-host CryptoJS by placing it in `/libraries/crypto-js` to avoid the CDN dependency.
- Provide the `auth_encrypt.helper` service (`AuthEncryptHelper::cryptoJsAesDecrypt()`) to decrypt CryptoJS "Salted__" AES payloads from custom code.
- Interoperate with CryptoJS's OpenSSL-compatible `Salted__` envelope format (AES-256-CBC, per-message random salt).
- Keep working when JavaScript is disabled or the CDN is blocked — the form still submits and authenticates with plaintext values.
- Reduce plaintext exposure of credentials in browser dev-tools / form-value inspection during submission.
- Layer an extra client-side transformation on top of HTTPS for login and account forms.
- Apply only to authentication forms, leaving all other site forms untouched.
- Add a runtime requirements check that flags a missing PHP OpenSSL extension on the status report.
- Support Drupal 10 and Drupal 11 sites.
