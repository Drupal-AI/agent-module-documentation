Encrypted Login encrypts the Drupal login password in the browser (RSA-2048 + AES-256-CBC) before the form is submitted and decrypts it server-side during login validation.

---

Once enabled, the module transparently changes the standard user login form (`user_login_form`). At install time it generates an RSA-2048 key pair and stores it in Drupal's State API. When the login page loads, an attached JavaScript behavior requests the RSA public key from `/encrypted_login/getPublicKey`, generates a fresh random AES-256 key and initialization vector for that attempt, encrypts the typed password with AES-256-CBC, and encrypts the AES key with the RSA public key. The two ciphertexts are written into hidden fields (`encrypted_aes_key`, `encrypted_password`), the visible password field is cleared, and the form is submitted. On the server a first validation handler RSA-decrypts the AES key, AES-decrypts the password, restores it as the normal `pass` value, and then Drupal's usual authentication and flood control run unchanged. The module ships no settings form, permissions, or config schema, so operation is limited to enabling it; it should be run over HTTPS and requires a browser with the Web Crypto API and PHP built with the OpenSSL extension.

---

- Add browser-side password encryption to the standard Drupal login form without writing custom code.
- Keep using Drupal's native login form, users, and roles while the password is encrypted before transmission.
- Complement HTTPS with an additional client-side encryption layer on the login page.
- Encrypt each login attempt with a fresh, per-attempt AES-256 key and random IV generated in the browser.
- Use hybrid encryption (RSA-2048 for the key, AES-256-CBC for the password) so only the key is asymmetrically encrypted.
- Deploy on sites that require login credentials to be encrypted at the application layer for policy or compliance reasons.
- Serve the RSA public key to the browser through a dedicated JSON endpoint (`/encrypted_login/getPublicKey`).
- Auto-generate the RSA key pair on module install with no manual key setup.
- Store the RSA key pair in Drupal's State API rather than in exportable configuration.
- Clean up the stored RSA keys automatically on module uninstall.
- Integrate with sites that need the password removed from the plaintext `pass` field before it is posted.
- Support Drupal 10 and Drupal 11 installations.
- Run on multilingual or multisite installs since it hooks the core login form, not site-specific config.
- Provide a drop-in "encrypt the login" capability for security-focused site builds.
- Pair with brute-force / flood protection, which continues to operate because native validation still runs.
- Use on intranet or admin portals where an extra credential-encryption step is desired.
- Attach the crypto-js and jsencrypt libraries only on the login form, not site-wide.
- Log decryption failures to the `encrypted_login` logger channel for troubleshooting login issues.
- Remove the legacy key-storage database table automatically via the module's update hook when upgrading.
- Offer a lightweight alternative to writing a custom form_alter + OpenSSL implementation for login encryption.
