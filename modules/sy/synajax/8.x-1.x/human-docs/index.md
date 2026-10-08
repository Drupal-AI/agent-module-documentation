# SynAjax — manual setup guide

**SynAjax** (`synajax`) is a lightweight anti-spam measure for contact forms: it
makes the form submit only via **AJAX** (JavaScript). Because many simple spam
bots POST directly to a form's URL without running any JavaScript, requiring an
AJAX submission quietly blocks that whole class of naive automated spam.

That is the entire idea — it is a spam-control feature, not an access-control
one. It is worth being clear-eyed about what it does and does not stop: it
defeats bots that never run JavaScript, but a determined spammer using a headless
browser *can* run JavaScript and get through, so treat SynAjax as **one layer**
and pair it with stronger measures such as CAPTCHA, Honeypot or flood control
where you need real protection. Also remember that requiring JavaScript to submit
can affect legitimate visitors who have JavaScript disabled — an accessibility
and no-JS consideration to weigh for your audience.

The module has a small settings form and is meant to be applied to your contact
forms. It supports Drupal 8, 9, 10 and 11, has no other module dependencies, and
is covered by Drupal's security advisory policy.

This guide is written for a **human** setting the module up through the admin UI.
If you want terse, token-cheap references for an AI coding agent, read the
sibling [`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.
2. [Configuration](configuration/index.md) — the settings form and how to apply
   AJAX-only submission to your contact forms.

## Where it lives in the admin menu

SynAjax provides a settings form at the `synajax.config` route. After enabling
the module, open that settings page to turn on and adjust the AJAX-only behaviour
for your contact forms — see [Configuration](configuration/index.md).
