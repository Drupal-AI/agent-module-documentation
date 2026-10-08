# Supermailer — manual setup guide

**Supermailer** (`supermailer`) provides double opt-in newsletter **subscribe** and
**unsubscribe** forms and blocks for a Drupal site, integrating with the Supermailer
newsletter software. When a visitor subscribes, the module emails them a
confirmation link; only after they click it does the module notify a configured
back-office recipient address that a new subscriber has confirmed.

The double opt-in flow is the whole point: it is an anti-spam measure that makes
sure nobody is signed up — and no recipient contacted — until the person actually
owning the email address confirms. A visitor submits the subscribe block or form,
the module stores a per-address token and emails a confirmation link. Visiting that
link validates the token and, if a recipient address is configured, sends a
plain-text control mail (recording the email, IP and timestamp) to that recipient,
then removes the token. Optional **CAPTCHA** protection can be switched on for both
the subscribe and unsubscribe forms, and a cron job automatically purges expired
tokens.

A note on the confirmation link, since it is deliberately reachable without logging
in (the person confirming is not a logged-in user): the security of that route is
sound. The confirmation link carries a per-address HMAC token keyed on the site's
private key and hash salt, stored server-side and matched by an exact database
lookup with an expiry window — so it cannot be guessed or forged without the site's
secrets. Confirmation only ever triggers a notification mail to the address you
configured; there is no other public action.

The module has **no admin settings UI yet**. Its behaviour is driven by the
`supermailer.settings` configuration, which you set through configuration management
(CMI) or by editing `supermailer.settings.yml` directly. It has no module
dependencies beyond core, and ships no submodules (the CAPTCHA integration is
optional config).

This guide is written for a **human** setting the module up through the admin UI and
configuration files. If you are an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

## How to use it

1. **Place the blocks.** Under **Structure → Block layout** you will find a
   **Supermailer subscribe** block and a **Supermailer unsubscribe** block. Place
   whichever you need into a region, with the usual visibility rules.
2. **Set the configuration.** Because there is no settings form yet, edit the
   `supermailer.settings` configuration (via CMI or the YAML file). The key values
   are the **recipient** address that receives the control mail, the **subscribe OK**
   page a visitor is redirected to after confirming, and the **token expiry
   interval** (in days) after which unconfirmed tokens lapse.
3. **Optionally enable CAPTCHA.** Optional CAPTCHA points ship for both forms; enable
   them (they live under the module's optional config) if you want to protect the
   forms from bots.
4. **Let cron run.** A cron job purges expired confirmation tokens automatically, so
   keep cron running on a normal schedule.

The confirmation email can be themed through the `supermailer_confirmation_mail`
template and is localised to the visitor's current language.
