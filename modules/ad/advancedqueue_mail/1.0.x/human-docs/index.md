# Advanced Queue Mail — manual setup guide

**Advanced Queue Mail** (`advancedqueue_mail`) sends **email notifications for
Advanced Queue jobs**. Advanced Queue is a module for running background jobs
(processing tasks off the main request), and this add-on emails you when those
jobs reach certain events — for example on success or failure — so operators are
kept informed about background processing without having to watch the queue
themselves.

It depends on the **Advanced Queue** module and lives in the Mail package. An
optional submodule, **Advanced Queue Mail Symfony Mailer**
(`advancedqueue_mail_symfony_mailer`), integrates the notifications with the
Symfony Mailer module if you use that for sending mail.

Because it sends **automated email**, a couple of operational points matter: point
the notifications at trusted operator addresses, keep the message templates from
leaking sensitive job data, and — as with any automated mailer — make sure it does
not become a source of noise or a relay. It has no access-control role.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer,
   enable it alongside Advanced Queue, and note the Symfony Mailer submodule.

## Where it lives in the admin menu

Advanced Queue Mail works with the **Advanced Queue** module, so its options sit
with that module's configuration under **Configuration** rather than as a separate
top-level section. There is no standalone settings page beyond configuring which
job events send mail and to whom.

## How to use it

1. Make sure the **Advanced Queue** module is installed and you have one or more
   queues/jobs running.
2. Enable Advanced Queue Mail (see [Installation](installation/index.md)).
3. Configure the **recipients** — the operator email addresses that should be
   notified — and the **job events** that should trigger a message (such as job
   completion or failure).
4. If you send mail through **Symfony Mailer**, also enable the
   `advancedqueue_mail_symfony_mailer` submodule so the notifications integrate
   with it.
5. Review the message templates so they do not include sensitive job data, and
   keep the recipient list to trusted operators to avoid unwanted noise.
