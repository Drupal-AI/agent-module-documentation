# Configuration

Microsoft Clarity needs one essential value — your project ID — before it will
track anything. The rest of this page is about doing that responsibly, since Clarity
records visitor behavior.

## Open the settings form

1. Log in as a user with the **Administer site configuration** permission (an
   administrator by default).
2. Go to **Configuration → Web services → Microsoft Clarity**, or navigate directly
   to `/admin/config/services/microsoft_clarity`.

## Settings

- **Project ID** — the identifier from your Clarity project (find it in the Clarity
  dashboard under your project's settings). This is what links the injected script
  to your account. Save the form and the script begins loading on the site.
- **Other options** — set any additional options the form offers as needed for your
  site.

## Privacy, consent, and masking

Session recording raises privacy considerations more sharply than plain page-view
analytics, because it can capture how users move through pages and — unless masked —
what they type and see. Treat the following as part of the setup, not optional
extras:

- **Disclose** Clarity in your site's privacy policy.
- **Gate it behind consent** where your jurisdiction requires it, so the tracking
  script does not run before the visitor agrees. Integrate the module's loading with
  your cookie/consent mechanism.
- **Configure masking** in your Clarity project so sensitive fields (form inputs,
  personal data) are not recorded.

The module places the script; the consent-gating and masking that make it compliant
are configuration you complete as the site operator.

## Save

Click **Save configuration**. Confirm the script loads only when you expect it to —
in particular, that it does **not** fire before a visitor has granted consent — then
watch your Clarity dashboard for incoming heatmap and session data.
