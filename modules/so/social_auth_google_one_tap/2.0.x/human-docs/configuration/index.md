# Configuration

This module has little configuration of its own — it relies almost entirely on the
**Social Auth Google** module's settings, plus one important setting in your Google
Cloud project. There is no separate settings form for One Tap.

## 1. Configure Social Auth Google

Make sure the **Social Auth Google** module is installed and configured correctly,
with a valid **Google Client ID** saved in its settings at
`/admin/config/social-api/social-auth/google`. One Tap reuses that same Client ID,
so you do not enter any credentials a second time. If standard "Sign in with
Google" works, the credential side is already in place.

## 2. Add your site to authorized JavaScript origins

The One Tap prompt is drawn by Google's Identity Services JavaScript running on
your pages, so Google must recognise your site's domain. In the **Google Cloud
Console**:

1. Go to **APIs & Services → Credentials**.
2. Edit your **OAuth 2.0 Client ID** (the same one used for Social Auth Google).
3. Under **Authorized JavaScript origins**, add your site's domain — for example
   `https://example.com`, or `http://localhost:8000` for local development.

This step is essential: without your origin listed, the One Tap UI will not be
displayed or function.

## 3. Verify

Log out (or use a private browser window) so you are anonymous, then load a page.
The Google One Tap prompt should appear, and choosing an account should log you in
to the same Drupal account you would get from the standard Google button. Note that
immediately after an explicit logout the module suppresses automatic One Tap
re‑login, so test from a genuinely fresh anonymous session.

## Security notes

- Serve the whole site over **HTTPS** — Google One Tap requires it in practice.
- The Google **ID token is verified server‑side** against Google's public keys
  (checking signature, audience, issuer, and expiry) before any login, so a forged
  token is rejected. You do not need to configure this — it is how the module works
  — but it is the reason One Tap is safe to use here.
- Keep your Google client credentials stored appropriately rather than in
  committed configuration.
