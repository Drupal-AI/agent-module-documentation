# Register with OTP — manual setup guide

**Register with OTP** (`register_with_otp`) adds an **email one-time-password
verification step** to Drupal's core user-registration form. When an anonymous
visitor tries to create an account, they must first prove they control the email
address they typed: the module emails them a short code, they enter it, and only
then can the account be created. It's a free, dependency-light way to cut down on
bot sign-ups without adding a CAPTCHA or a third-party service.

> **Note:** despite what "OTP" sometimes implies, this module sends the code by
> **email**, not by SMS. There is no SMS gateway and no credentials to store.

Here's the flow the module builds on top of the normal registration form (for
**anonymous** users only): a **Verify email** button appears alongside a hidden OTP
field. Clicking it generates a 5-digit code, emails it to the address entered, and
the final **Create account** button stays hidden until the code is verified. The
code is valid for **5 minutes**; if the user changes their email after verifying,
they have to verify again. Because the code is bound to the entered address and only
sent there, nobody can verify an address they don't control.

The module has **no settings form, route or permission of its own** — it simply
takes over the registration form once enabled. Its only hard requirement is a
working mail system (see Installation), because the code is delivered by email.

If stronger bot/abuse resistance is the goal, consider pairing it with core's flood
protection or a CAPTCHA on the registration form.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer, enable
   it, and confirm mail and account settings.

There is **no configuration page** for this module — it has no settings form. Its
setup is entirely about mail delivery and core account settings, described below.

## Where it lives in the admin menu

Register with OTP adds no admin page. It attaches itself to the core registration
form at `/user/register`. The settings that make it work live in core:
**Configuration → System → Basic site settings** / your SMTP module for mail, and
**Configuration → People → Account settings**
(`/admin/config/people/accounts`) for who may register.

## How to use it

1. Make sure your site can **send email reliably** — an SMTP module or a working
   mail transport. The OTP is delivered only by email, so if mail doesn't go out,
   nobody can register.
2. Under **Configuration → People → Account settings**, make sure **Visitors can
   register accounts** is enabled — otherwise the anonymous registration flow (and
   this module) is never reached.
3. That's it. Visit `/user/register` as an anonymous user: you'll see a **Verify
   email** button, enter your email, receive a code, type it in, and then the
   **Create account** button becomes available.

To customize the look of things, themers can override the `mail--otp-validate`
email template for the message body and the module's `validator_styles` CSS library
for the verification widget.
