# Configuration

Simple Klaro keeps configuration deliberately simple: a **single settings form** where
you edit Klaro's own configuration. Because the module does not try to wrap Klaro in a
rich UI, you are working directly with Klaro's configuration model — its services,
their purposes, texts, styling, and translations — but from a Drupal form whose values
are stored in exportable config.

## Open the settings form

1. Log in as a user with the **administer simple klaro** permission (a *restricted*
   permission — grant it only to trusted administrators).
2. Go to **Configuration → System → Simple Klaro**, or navigate directly to
   `/admin/config/system/simple-klaro`.

## What you configure

From the settings form you can control:

- **Services and their purposes** — the third‑party services (analytics, pixels,
  embedded video, and so on) that consent gates, grouped by purpose in the dialog.
- **All texts and translations** — the wording shown to visitors. Translations are
  displayed based on the `lang` attribute of the page's `html` element, so a
  multilingual site shows the right language automatically.
- **Appearance** — you can use Klaro's default styling, or turn styling off so the
  dialog inherits your theme's design.
- **Script handling** — by default, execution of gated scripts is controlled by
  switching the script type from `text/plain` to `application/javascript` when the
  matching consent is toggled on. You can additionally invoke custom callback
  functions, and when consent is revoked you can delete cookies using regular
  expressions.

When you save, all caches are cleared and the updated settings take effect across
every page immediately.

## Let visitors re‑open the dialog

After a visitor has made their choices, you will want a way for them to change their
mind. The module provides a **block** containing a link that opens the consent
settings dialog — place it (for example in the footer) through **Structure → Block
layout**. More generally, **any HTML element with the id `klaro-preferences`** opens
the dialog, so you can add your own "Cookie preferences" link or button anywhere in
your theme.

## The bypass permission — grant it deliberately

The module defines a second, *restricted* permission: **bypass simple klaro**, which
lets a role use the site with no consent gating at all. It is useful for editors, but
grant it deliberately: a user who bypasses consent sees a page that is **not** what an
ordinary visitor sees. In particular, if you are testing "does the tracker actually
fire only after consent?", do that test as a user **without** the bypass permission —
otherwise you will get a misleading answer.

## A note on scope

Consent gating works by neutralising script tags until opt‑in. That means any script a
visitor's browser loads through Klaro's control is properly gated — but if some other
module injects its own tracking script outside Klaro's control, that script bypasses
the consent gate. If you rely on Simple Klaro for compliance, cross‑check anything else
on the site that emits tracking scripts directly.
