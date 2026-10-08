# Configuration

Setting up Pigeon Paywall has two halves: the **global settings** (your Pigeon
account details and paywall behaviour) and the **per‑content setup** (the boolean
flag field, the formatter, and the CSS classes in your template).

> **Reminder about the access model:** Pigeon enforces the paywall entirely in the
> browser. The protected content is present in the page HTML sent to every
> visitor and is only hidden by `pigeon.js`. Do not use it for content that must
> be genuinely inaccessible to non‑subscribers — see the [overview](../index.md).

## Global settings

Go to **Configuration → Web services → Pigeon Paywall**
(`/admin/config/services/pigeon-paywall`). You need the **administer pigeon
paywall** permission. The form's fields:

- **Subdomain / account** — your Pigeon account hostname. The module rewrites the
  `pigeon.js` script URL to load from `//<subdomain>/c/assets/pigeon.js`, so this
  must match your Pigeon account exactly.
- **Fingerprint** — enable browser fingerprinting to reduce fraud from visitors
  who simply clear their cookies (this is a soft‑paywall mitigation, not a hard
  guarantee).
- **IDP** — enable when your Pigeon subdomain is on a different domain context
  (cross‑domain setups).
- **Only show on published content** — restrict the paywall so it is applied only
  to published entities.
- **Paywall bypass query argument** — the URL query argument used for per‑entity
  bypass codes (default `pigeon`). See "Bypass code" below.

Save the form when done. The settings form also typically links editors to the
Pigeon admin dashboard.

## Per‑content setup

1. **Add a boolean field** to the content type (bundle) you want to gate — this is
   the flag that marks an item as paywalled. Check it on the items that should be
   behind the paywall.
2. On the bundle's **Manage display** tab, for the **full** view mode, set that
   boolean field's format to the **Pigeon Paywall controller**
   (`pigeon_paywall_checkbox`) formatter.
3. In the entity's Twig template, add the `pigeon-remove` CSS class to the region
   of content that should be hidden from non‑subscribers, and add a hidden
   `pigeon-context-promotion` teaser element that Pigeon reveals to them. You can
   optionally add a `pigeon-open` link to open the Pigeon sign‑in modal.

## Bypass code (optional)

You can let editors preview or share paywalled content without a subscription:

1. Add a plain‑text **bypass code** field to the bundle.
2. In the formatter settings (on **Manage display**), select which field holds the
   bypass code.
3. Share a link with the bypass query argument, e.g. `?pigeon=CODE`. When the URL
   carries a code matching the entity's stored code, the formatter skips attaching
   the paywall script for that request.

Because this is a convenience feature on a client‑side gate, treat bypass codes as
low‑security "preview links", not as secrets protecting sensitive material.
