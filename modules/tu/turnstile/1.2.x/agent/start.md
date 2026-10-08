<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Cloudflare Turnstile (turnstile) — agent index

**Turnstile** as a challenge type for the **CAPTCHA** module. Requires `captcha` and **`key`**.
Settings behind `administer turnstile`. Version **1.2.0**.
**Core requirement `^10.6 || ^11 || ^12`** — unusually forward-looking.

**The `key` dependency is the right arrangement** — the secret comes from a **Key entity**, not a
settings field, so it never reaches exported configuration.

**Why organisations move to it:**
- image-grid CAPTCHAs are slow, **fail for visually impaired users**, are solved commercially for
  fractions of a cent, and **measurably reduce form completion**;
- Turnstile verifies from browser signals in the background — most visitors see a box that ticks
  itself;
- **regulatory**: reCAPTCHA sends visitor data to Google and is a recurring European
  privacy-assessment finding.

**Three things to state:**
1. **It is still a third-party request** to Cloudflare on every protected form — it belongs in the
   privacy notice even though it collects less.
2. **An invisible challenge is not a permission check.** It raises the cost of automation and
   authorises nothing — a form that must not be submitted by the wrong person needs a **permission**
   too.
3. **Flood control remains necessary.** A challenge solved once does not stop a slow, patient
   script; core's **flood** service limits repetition.

See `turnstile_protect` (same wave) for putting whole **routes** behind it rather than forms.
