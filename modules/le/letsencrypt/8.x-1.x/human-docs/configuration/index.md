# Configuration

Letsencrypt is configured at **Configuration → System → Letsencrypt**
(`/admin/config/system/letsencrypt`), which requires the **Administer site
configuration** permission. Restrict this page to trusted administrators — it
governs certificate issuance and the handling of private key material.

## Issue a certificate

The core workflow is to prove you control a domain and then issue a certificate
for it:

1. On the settings/demo page, configure the domain(s) you want a certificate for.
2. The module handles the **ACME HTTP‑01 challenge** by writing challenge files to
   `.well-known/acme-challenge`; Let's Encrypt fetches them to confirm you control
   the domain. This is why the web server must be able to serve those files and
   the module must have filesystem write access.
3. Once verification succeeds, the certificate is issued and stored.

You can also drive issuance from code using the module's service:

```php
$domain = 'example.org';
\Drupal::service('letsencrypt')->sign($domain);  // issue / renew
\Drupal::service('letsencrypt')->read($domain);  // read the stored certificate
```

For **wildcard certificates**, use a DNS‑based challenge with a DNS callback (for
example AWS Route 53). A **custom verification callback** is also supported.
Both are covered in the module's README.

## Renewal

Let's Encrypt certificates are short‑lived, so plan to **renew** them on a
schedule (re‑running `sign()` for the domain). Automate renewal so certificates
never lapse.

## Handle the key material safely

This is the part that demands care. The module manages the **ACME account key**
and the **issued private keys**:

- Store them where **only the server can read them** — never inside a
  web‑accessible directory, and never served to the browser.
- Keep the challenge directory writable but treat the certificate/key storage as
  sensitive.
- Restrict the admin configuration page to **trusted administrators** only.

Automating TLS is a security win — encrypted connections without manual
certificate handling — but a leaked private key undermines exactly that, so the
storage location and permissions matter as much as the issuance itself.

## Save

Save the settings, issue a certificate for a domain you control, and confirm the
certificate is issued and stored (for example with the service's `read()` method
or your server's certificate view). Then confirm your renewal automation is in
place.
