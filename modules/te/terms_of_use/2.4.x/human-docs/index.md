# Terms of Use — manual setup guide

**Terms of Use** (`terms_of_use`) adds a required "I agree" checkbox to Drupal's user
registration form, so new visitors must accept your terms and conditions before their
account is created. The text of the agreement comes from a node you designate, and
you can either show the full terms inline on the form or show just a link to them.

It is a lightweight, focused module — a single settings form plus a small alteration
to the registration form. On the settings page you pick the node that holds your
terms, then set a few labels: the title of the fieldset that wraps the terms, the
checkbox label the user must tick, and whether the terms start expanded or collapsed.
Because the terms come from a node, you can update the wording site-wide just by
editing that one page, with no configuration redeploy.

A couple of behaviours are worth knowing. If your checkbox label contains the special
`@link` token, the module shows a link to the terms node (optionally opening in a new
tab) instead of the full body text. And administrators creating accounts at
**People → Add user** are skipped entirely — the terms only ever block public
self-registration, never admin-created accounts. The displayed terms are also
translation-aware: if the terms node has a translation for the current interface
language, that translation is shown.

Common uses include capturing explicit consent for a privacy policy (GDPR), an
age-verification gate ("I certify that I am over 18"), or any signup checkbox that
must be ticked before an account is made.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.
2. [Configuration](configuration/index.md) — the settings form field by field, plus
   the full setup checklist.

## Where it lives in the admin menu

The settings form is at **Configuration → People → Terms of Use**
(`/admin/config/people/terms-of-use`), reachable by anyone with the **Administer
account settings** permission.
