# Configuration

There are two layers to configuring Mautic Audiences: the **settings form**, where
you secure the webhook and choose how visitors are identified and what is exposed to
the browser; and the **audience‑aware features** you then place around the site
(block/Layout Builder conditions, a Views filter, Twig, tokens, JavaScript).

## Open the settings form

Log in as an administrator and go to **Configuration → Web services → Mautic
Audiences** (`/admin/config/services/mautic-audiences`).

## Set the webhook secret (do this first)

The module exposes a webhook at `/mautic-audiences/webhook` that Mautic calls to
keep audiences fresh. When a **webhook secret** is configured, the module verifies
the request's HMAC signature with a constant‑time comparison — good. But **as
shipped, if no secret is set (the default), the check is bypassed and the request is
accepted**, so anonymous callers could trigger contact‑refresh work. The impact is
bounded — it only causes Drupal to re‑fetch from Mautic, with no direct data
injection — but you should close it regardless.

Set the secret in one of two ways:

- Enter it on the settings form, or
- Define it in `settings.php` as `$settings['mautic_audiences.webhook_secret']`,
  which keeps the secret out of exported configuration and git. With DDEV you can
  store the value with `ddev dotenv set .ddev/.env --mautic-webhook-secret=<value>`
  (keep `.ddev/.env` out of version control), `ddev restart`, and read it via
  `getenv()` in `settings.php`.

Configure the same secret on the Mautic side so its webhook signs requests
correctly.

## Pick an identity strategy

Choose how the resolver identifies a visitor — for authenticated users it can read
from `user.data`; for anonymous visitors it keys on the `mtc_id` cookie. Select the
strategy that matches how your site tracks visitors.

## Configure the client‑side exposure allowlist

Some features can reveal segment/tag names to the browser — the JavaScript API, the
`/mautic-audiences/me` endpoint, and joined‑string tokens used in metatag patterns.
For privacy, **enumeration is allowlisted**: only the segment names you explicitly
list are ever emitted client‑side, so sensitive segments (coupon codes, risk‑scoring
tags) stay server‑side unless you opt them in. Populate this allowlist with only the
audiences that are safe to expose to the browser.

## Consent gating (optional)

A `consent_callback` hook lets you gate the resolver on the visitor's consent state.
If you use the Klaro consent manager, enabling the `mautic_audiences_klaro`
sub‑module wires this up for you.

## Place the audience‑aware features

Once the settings are in place, use audiences around the site — no code required for
most of it:

- **Block / Layout Builder visibility** — when placing a block (classic placement or
  inside a Layout Builder section), add a **Mautic segment** or **Mautic tag**
  condition, list the aliases one per line, choose *any* / *all*, and optionally
  negate.
- **Global Views filter** — add the *Visitor Mautic audience matches* filter to hide
  a view's results unless the visitor's audience matches.
- **Twig functions** — `is_in_segment(name|names, mode)`, `has_tag(name|names,
  mode)`, `current_audiences()`.
- **Tokens** — such as `[mautic-audience:in-segment-X]` and
  `[mautic-audience:has-tag-Y]`.
- **JavaScript API** — `Drupal.mauticAudiences.hasSegment(name)` /
  `.hasTag(name)`.
- **Preview as audience** — editors with the right permission can append
  `?ma_preview_segments=vip,newsletter&ma_preview_tags=lead` to any URL to see the
  personalised result.

## Save

Save the settings form. Remember that, as with any personalisation control, the
protection and privacy behaviour depend on getting the webhook secret and the
exposure allowlist right.
