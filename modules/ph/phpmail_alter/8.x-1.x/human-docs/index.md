# PhpMail Alter — manual setup guide

**PhpMail Alter** (`phpmail_alter`) adjusts how Drupal's built‑in PHP mailer sends
outgoing email, letting administrators tweak mail **headers and parameters** through
configuration rather than custom code. It is a small, targeted helper for the common
cases where core's default mail handling doesn't quite suit a particular mail
setup — for example allowing `text/html` mail, making a non‑Latin "From" name work
correctly, or setting the right envelope/header values for deliverability. It also
offers a debug mode to inspect what is being sent. It depends only on Drupal core.

Because it operates on **outbound email**, review any changes carefully: a mis‑set
"From" or envelope header can hurt deliverability or, in the worst case, make mail
appear to come from the wrong sender. The module has no role in content access — it
only shapes mail.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

The module's changes are driven by a small settings form (there is no complex
configuration section); it is covered under "Where it lives" and "How to use it"
below.

## Where it lives in the admin menu

Once enabled, PhpMail Alter provides a **settings form** (config
`phpmail_alter.settings`) in the **Configuration** area of the admin menu, under the
mail‑related settings. Open it as a user with the *Administer site configuration*
permission.

## How to use it

1. Install and enable the module (see [Installation](installation/index.md)).
2. Open the PhpMail Alter settings form from the Configuration area.
3. Adjust the mail options to match your mail infrastructure — for example allowing
   HTML mail or correcting the From/header handling — and, if you are diagnosing a
   problem, turn on the debug output to inspect what is being sent.
4. Save, then send a test email and confirm the headers arrive as you intend.

> **Review before you rely on it.** Test any header/envelope change against your
> real mail provider; incorrect values can reduce deliverability or misrepresent the
> sender. Note also that the module no longer converts mail‑domain punycode for
> you — if you need that, handle it yourself.
