<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Next.js Tag Revalidator triggers cache-tag-based revalidation of Next.js ISR pages on content change.

---

Next.js Tag Revalidator **revalidates Next.js ISR pages by cache tag** — when Drupal content changes, it calls
the Next.js revalidation endpoint for the affected cache tags so incrementally-static-regenerated pages update. It
depends on the Next.js (Next) module.

Use it to keep a decoupled Next.js front end fresh. It is a decoupled/integration feature. Security/data handling:
it **calls the Next.js app's revalidation webhook** (egress) and that endpoint is typically protected by a **shared
secret** — store that secret securely (env/Key) and serve over HTTPS. It has no access-control role. Configure the
revalidation endpoint and secret.

---

- Revalidate Next.js ISR pages.
- Trigger by cache tag on change.
- Keep decoupled pages fresh.
- Depend on the Next module.
- Serve decoupled/integration.
- Call the revalidation endpoint.
- Call the Next.js revalidation webhook (egress).
- Store the revalidation shared secret securely (env/Key, HTTPS).
- Have no access-control role.
- Configure the endpoint + secret.
- Handle revalidation.
- Revalidate pages.
- Configure the endpoint.
- Trigger revalidation.
- Handle the webhook.
- Refresh pages.
- Configure Next.
- Handle the integration.
- Update ISR.
- Provide tag revalidation.
