Check DNS blocks user self-registration when the email address's domain has no resolvable DNS record, rejecting obviously fake or mistyped email domains at the registration form.

---

The module is a tiny, zero-configuration validation add-on. On enable it does exactly one thing: `hook_form_user_register_form_alter()` appends a custom `#validate` handler to the core user registration form (`user_register_form`). That handler reads the submitted `mail` value and passes it to the `check_dns.service` service (`Drupal\check_dns\CheckDnsService`). The service first runs the address through PHP's `FILTER_VALIDATE_EMAIL`, then splits off the domain part and calls `dns_check_record()` (PHP's `checkdnsrr`, default record type `MX`) on it. If the address is malformed or the domain has no DNS record, the service returns `FALSE` and the form sets an error on the `mail` field: "Your email domain is not recognised. Please enter a valid email id." There is no settings page, no permission, no config, no allow/deny list, and no Drush command — the only extension point is the reusable `check_dns.service` you can call from your own code. It validates only the domain's existence, not whether the specific mailbox exists.

---

- Reject registrations that use a mistyped email domain (e.g. `user@gmial.com` where the domain does not resolve).
- Cut down on spam/bot signups that use throwaway domains with no DNS records.
- Validate that a registrant's email domain actually exists before an account is created.
- Enforce a basic "real domain" check on the default Drupal registration form without writing custom code.
- Call `check_dns.service`'s `validateEmail($mail)` from custom validation to check any email string.
- Reuse `validateHost($host)` to test whether a bare domain has an MX/DNS record.
- Add a lightweight first line of defense in front of heavier anti-spam modules (Honeypot, CAPTCHA).
- Screen out addresses at domains that were registered but never configured for mail.
- Prevent bounced-email accounts caused by non-existent domains at signup time.
- Improve deliverability of activation/welcome emails by blocking undeliverable domains early.
- Gate a membership site's signups so only addresses at resolvable domains get through.
- Validate email domains in a custom multi-step registration flow by invoking the service.
- Wrap the service in a custom webform or contact-form handler to reject bad domains there too.
- Provide a clear inline error to legitimate users who fat-finger their email domain.
- Reduce manual moderation of new accounts by filtering out impossible email domains.
- Combine with core email verification so both "domain exists" and "user controls mailbox" are checked.
- Use as a teaching example of `hook_form_FORM_ID_alter()` adding a `#validate` callback.
- Programmatically pre-check a list of imported user emails' domains via the service.
- Block signups from reserved/placeholder TLDs (e.g. `.invalid`, `.test`) that never resolve.
- Enforce domain validity on a decoupled/custom registration endpoint by calling the service in code.
