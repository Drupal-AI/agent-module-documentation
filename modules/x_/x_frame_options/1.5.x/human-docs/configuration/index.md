# Configuration

The module has a single settings form where you pick the framing policy. Remember
that the module ships no default config, so you **must save this form once** for
the header to carry a real value.

## Open the settings form

1. Log in as a user with the **Administer site configuration** permission.
2. Go to **Configuration → System → X-frame-options Configuration**, or navigate
   directly to `/admin/config/system/x_frame_options_configuration/settings`.

## Choose a directive

Pick one of the **Directive** radio options:

- **DENY** — sends `X-Frame-Options: DENY`. The site can never be framed anywhere,
  not even by itself. Good for admin/back-office sites that should never be
  embedded.
- **SAMEORIGIN** — sends `X-Frame-Options: SAMEORIGIN`. Only pages on your own
  domain may frame the site. This is the safe default for most sites, since it
  blocks third-party framing while still allowing your own iframes.
- **ALLOW-FROM** — sends `X-Frame-Options: ALLOW-FROM <uri>`, permitting one
  specific site to frame yours. Selecting this reveals a second **Uri** field
  where you enter the partner URL (for example
  `https://partner.example.com/`). **Caveat:** the `ALLOW-FROM` directive is
  obsolete and ignored by modern Chromium and Safari — for those browsers use a
  Content-Security-Policy `frame-ancestors` directive instead.
- **ALLOW-ALL** — **removes** the `X-Frame-Options` header from responses
  entirely. Choose this only when another layer (a reverse proxy, CDN, or CSP)
  already sets an appropriate framing policy and you don't want this module to
  interfere.

## The Uri field

The **Uri** field appears only when you select **ALLOW-FROM**. Enter the full URL
of the single site you want to permit to frame your pages. It is passed through
Drupal's dangerous-protocol stripping for safety.

## Save

Click **Save configuration**. Because a response subscriber applies the header to
every response, the change takes effect on the next request (dynamic-page cache
aside). During a security incident you can switch from, say, SAMEORIGIN to DENY
with a single save. To confirm the live header, run:

```bash
curl -sI https://your-site.example/ | grep -i x-frame-options
```
