# Configuration

Setting up the 1.0.x release of Email Validator (EVA) is a short, three‑step
process: create an e‑va.io account, generate an API key, and enter that key in the
module's settings.

## 1. Create an account and get an API key

Go to **https://e‑va.io**, create an account, and generate an **API key** in your
e‑va.io dashboard. This key is what lets your Drupal site call the e‑va.io
validation service. Keep it private.

## 2. Enter the API key in Drupal

1. Log in as a user with the permission to administer the EVA settings.
2. Open the module's settings form under **Configuration**.
3. Paste your e‑va.io **API key** into the key field and save.

That's the essential setup — with a valid key in place, EVA validates email
addresses against the service and rejects those it reports as fake or
undeliverable.

## Security and privacy notes

- **Third‑party data egress.** EVA sends the email addresses being validated to
  the external e‑va.io service. Confirm this is acceptable for your site and
  disclose it in your privacy policy where required.
- **Protect the API key.** Treat the key as a secret. Avoid committing it into
  version control, and make sure the site talks to e‑va.io over HTTPS.

> **Looking for more control?** The later 3.0.x release adds a much richer
> settings form — targeting specific forms and fields, choosing which
> deliverability states to accept, a fail‑open vs fail‑closed policy for when the
> service is unreachable, logging, and per‑address result caching. If you need
> those options, consider upgrading and see the 3.0.x guide.
