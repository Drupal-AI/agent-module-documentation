# Pigeon Paywall — manual setup guide

**Pigeon Paywall** (`pigeon_paywall`) integrates the hosted **Pigeon** paywall
service from [Sabramedia](https://sabramedia.com) into Drupal. You flag individual
content items with a boolean field, apply the module's field formatter, and the
Pigeon JavaScript then presents a subscription paywall to non‑subscribers while
letting subscribers read the full content.

Mechanically, the **Pigeon Paywall controller** formatter (`pigeon_paywall_checkbox`)
attaches Pigeon's remote `pigeon.js` script (loaded from the subdomain you
configure) and a small `drupalSettings.pigeon` payload identifying the entity. The
Pigeon script hides the parts of the page you mark with the `pigeon-remove` CSS
class from non‑subscribers and reveals a teaser you mark with
`pigeon-context-promotion`. It ships in the *Commerce* package and provides an
**administer pigeon paywall** permission for its settings.

**Understand the access model before you rely on it.** Pigeon is a *client‑side,
"soft" paywall*. The full protected content is rendered into the page HTML that is
delivered to every visitor, including anonymous ones — `pigeon.js` merely
hides or removes it in the browser. That means anyone who views page source,
disables JavaScript, or reads the raw markup can bypass the gate. There is also an
intentional per‑entity **bypass code** feature (a plain‑text field matched against
a URL query argument). Treat Pigeon as engagement/soft gating and monetisation
support — **not** as server‑side protection for genuinely restricted content. If
you need content to be truly inaccessible to non‑subscribers, this is not the
right tool.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.
2. [Configuration](configuration/index.md) — enter your Pigeon account subdomain,
   the global paywall options, and set up the boolean flag field and formatter on
   your content.

## Where it lives in the admin menu

Global settings sit at **Configuration → Web services → Pigeon Paywall**
(`/admin/config/services/pigeon-paywall`), behind the **administer pigeon
paywall** permission. Per‑content setup happens on your content type's **Manage
fields** and **Manage display** tabs. See
[Configuration](configuration/index.md).
