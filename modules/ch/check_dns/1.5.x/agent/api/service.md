# check_dns.service — validating email domains

The whole module is one hook + one service. Total source is ~50 lines.

## Registration hook (automatic)

`check_dns.module`:

- `check_dns_form_user_register_form_alter(&$form, $form_state)` adds
  `check_dns_user_register_validate` to `$form['#validate']`.
- `check_dns_user_register_validate($form, &$form_state)` reads
  `$form_state->getValue('mail')`, calls
  `\Drupal::service('check_dns.service')->validateEmail($mail)`, and on `FALSE` calls
  `$form_state->setErrorByName('mail', t('Your email domain is not recognised. Please enter a valid email id.'))`.

This runs only on the **core user registration form** (`user_register_form`). It does not touch
the admin "add user" form's flow beyond that form ID, profile edits, or any other form.

## The service — `Drupal\check_dns\CheckDnsService` (id `check_dns.service`)

Stateless, no constructor dependencies. Two public methods:

```php
$svc = \Drupal::service('check_dns.service');

// TRUE only when $mail is a syntactically valid address AND its domain resolves.
$ok = $svc->validateEmail('user@drupal.org');   // bool

// TRUE when the bare host has a DNS record.
$ok = $svc->validateHost('drupal.org');         // bool
```

- `validateEmail($mail)`: returns `FALSE` immediately if `filter_var($mail, FILTER_VALIDATE_EMAIL)`
  fails; otherwise takes the part after `@` and delegates to `validateHost()`.
- `validateHost($host)`: returns `dns_check_record($host)` — an alias of PHP's
  `checkdnsrr($host)`, whose **default record type is `MX`**. So a domain that resolves but has no
  MX record can still return TRUE for non-MX record types only if you change it — as shipped it uses
  the default (`MX`, with PHP falling back through record types per its implementation). In practice
  real mail domains (drupal.org, gmail.com) return TRUE; reserved/unregistered domains
  (`*.invalid`) return FALSE.

## Reusing it

Call the service from any custom validation (a webform handler, a REST registration endpoint, a
batch that screens imported users). There is no allow/deny list and nothing to configure —
behavior is entirely "does this domain resolve in DNS right now". Requires outbound DNS from the
web server; if DNS is unreachable the check will fail (return FALSE) for every domain.
