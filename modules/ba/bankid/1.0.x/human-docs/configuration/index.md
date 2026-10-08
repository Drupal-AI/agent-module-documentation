# Configuration

Configuring BankID is mostly about connecting the module to your BankID client
**certificate/credentials** — stored via the Key module — and pointing it at the
right BankID environment. Because this is national-identity authentication, do
the secret handling carefully.

## 1. Store the BankID credential as a Key

The module reads its BankID API credentials through the **Key** module rather
than from plain configuration. Create a Key entity that holds the credential
(certificate passphrase, or the credential value your BankID setup uses):

- Use an **environment** key provider (reading the variable you set during
  [Installation](../installation/index.md)) or a **file** provider pointing at a
  certificate stored outside the web root.
- Do **not** paste the raw secret into a configuration form whose value ends up in
  a Git export or database dump.

For example, with the environment provider from the command line:

```bash
ddev drush key:save bankid_cert_passphrase \
  --label='BankID certificate passphrase' --key-type=authentication \
  --key-provider=env \
  --key-provider-settings='{"env_variable":"BANKID_CERT_PASSPHRASE","base64_encoded":false,"strip_line_breaks":true}' \
  --key-input=none -y
```

## 2. Connect the Key and the BankID environment to the module

In the module's settings, select the **Key** you created for the credential and
provide the path to your BankID client certificate. Point the module at the
correct BankID endpoint — the **test** environment while you integrate, the
**production** environment only when you go live. (The agent docs confirm the
credentials are held via Key and the flow runs against BankID's mutual-TLS API;
follow the module's own settings screen for the exact fields, and the project
page if a field is unclear.)

## 3. Security checklist before going live

- **Secure the client certificate/credentials.** They authenticate your
  organisation to BankID — keep them out of Git, config exports and database
  dumps, and readable only by the web server.
- **Bind the order to the session.** Confirm that an authentication order started
  by one visitor cannot be completed by another — the `orderRef` returned from
  BankID must only be collectable by the session that started it, so no one can
  hijack another user's login.
- **HTTPS everywhere.** Serve the whole login flow over HTTPS.
- **Test the full flow** against BankID's test environment (start an order,
  approve it in the app, confirm the right Drupal user is logged in) before
  switching to production.
