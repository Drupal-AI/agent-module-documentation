<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Cloudflare Turnstile adds Turnstile as a challenge type for the CAPTCHA module, as an alternative to reCAPTCHA and image challenges.

---

CAPTCHA has always been a trade between stopping automation and punishing people, and image-grid challenges settled that trade badly: they are slow, they fail for anyone with a visual impairment, they are solved commercially for fractions of a cent, and they have measurably reduced form completion wherever they have been measured. Turnstile takes the other approach — it verifies in the background from browser signals and only presents an interaction when something looks wrong, so most visitors see a box that ticks itself. The other reason organisations move to it is regulatory: Google's reCAPTCHA sends visitor data to Google and has been a recurring finding in European privacy assessments, and Turnstile is marketed on not doing that. This module supplies the Drupal integration, requiring `captcha` and — notably — **`key`**, so the secret comes from a Key entity rather than a settings field and never reaches exported configuration. Version **1.2.0**, with a core requirement of **`^10.6 || ^11 || ^12`** that is unusually forward-looking. Three things worth stating. **Turnstile is still a third-party request** to Cloudflare on every protected form, so it belongs in the privacy notice even though it collects less. **An invisible challenge is not a permission check**: it raises the cost of automation and does not authorise anything, so a form that must not be submitted by the wrong person needs a permission as well. And **flood control remains necessary**, because a challenge solved once does not stop a slow, patient script, and core's flood service is the thing that limits repetition.

---

- Add Turnstile to a contact form.
- Replace reCAPTCHA on a site.
- Reduce spam on user registration.
- Protect a comment form.
- Meet a privacy assessment's requirement.
- Reduce form abandonment from CAPTCHA.
- Add an invisible challenge.
- Protect a webform from bots.
- Store the Turnstile secret in a Key entity.
- Improve accessibility of spam protection.
- Protect a password reset form.
- Reduce automated signups.
- Replace an image CAPTCHA.
- Protect a search form from abuse.
- Add spam control to a booking form.
- Meet a GDPR position on third parties.
- Protect a newsletter signup.
- Reduce moderation workload.
