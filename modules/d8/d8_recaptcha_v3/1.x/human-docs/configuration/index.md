# Configuration

reCAPTCHA v3 needs three things to work: your Google **keys**, a **score
threshold**, and a choice of which **forms** to protect. You configure all of this
on the module's settings form in the **Configuration** area (you'll need the
*Administer site configuration* permission, an administrator by default).

## Get your Google keys first

In the [Google reCAPTCHA admin console](https://www.google.com/recaptcha/admin),
register your site and choose **reCAPTCHA v3**. Google gives you a **site key**
(used in the page's JavaScript, public) and a **secret key** (used server‑side to
verify the score — this is a credential). Keep your list of allowed domains
accurate, and include your local/DDEV domain if you test there.

## The settings

- **Site key** — the public key Google issued. It's embedded in the page so the
  reCAPTCHA script can score interactions.
- **Secret key** — the private key used server‑side to verify each score. **Treat
  this as a secret:** keep it out of version control. Where your workflow allows,
  supply it from an environment variable rather than committing it in a config
  export (for DDEV, `ddev dotenv set .ddev/.env …` then reference the variable).
- **Score threshold** — reCAPTCHA v3 returns a score from 0.0 (very likely a bot)
  to 1.0 (very likely a human). Submissions scoring **below** your threshold are
  treated as suspect. Start around the middle and adjust: raise it if spam gets
  through, lower it if legitimate users are being blocked.
- **Protected forms** — choose which Drupal forms the check applies to (for
  example the contact, user registration, or comment forms).

Save the form when done.

## Privacy and limits

- reCAPTCHA **sends interaction data to Google**. Disclose this third‑party
  processing in your site's privacy policy.
- The check is **probabilistic**, not a guarantee. For high‑value forms, pair it
  with other controls (rate limiting, honeypots, moderation) rather than relying
  on the score alone.
- Because it's invisible, test after enabling — submit the protected forms
  yourself to confirm real users aren't being rejected at your chosen threshold.
