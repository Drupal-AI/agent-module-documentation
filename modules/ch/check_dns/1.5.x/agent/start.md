# Check DNS — agent index

Adds a `#validate` handler to the **core user registration form** that rejects an email whose
**domain has no DNS record**. Zero configuration: no settings form (`configure=null`), no
permissions, no config schema, no Drush, no plugins. One reusable service does the work.

- **How registration validation works + the `check_dns.service` API (`validateEmail`, `validateHost`)** →
  [api/service.md](api/service.md)

Key facts:
- Hook: `check_dns_form_user_register_form_alter()` appends `check_dns_user_register_validate` to `$form['#validate']`.
- Service: `check_dns.service` = `Drupal\check_dns\CheckDnsService`.
  - `validateEmail($mail)` — `FILTER_VALIDATE_EMAIL`, then checks the domain.
  - `validateHost($host)` — `dns_check_record($host)` (PHP `checkdnsrr`, default record type `MX`).
- On failure the form error is set on `mail`: "Your email domain is not recognised. Please enter a valid email id."
- It only validates the **domain's** DNS existence, not the specific mailbox.
