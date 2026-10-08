# Blind Carbon Copy — manual setup guide

**Blind Carbon Copy** (`bcc`) adds a hidden BCC recipient to every email your
Drupal site sends. Whatever the site mails out — registration confirmations,
order receipts, contact-form messages, password resets — a blind copy also goes
to the address you configure, without the original recipients being told.

People turn this on for a few honest reasons: to keep an **archive** of what was
sent so a support conversation can be reconstructed; to feed a **shared inbox**
that sees confirmations so someone notices when they stop arriving; to satisfy a
**records-retention** requirement; or simply for **debugging**, because "did that
email actually go out?" is otherwise hard to answer from inside Drupal.

**Treat this as a data-protection decision before a configuration one.** A
blanket BCC copies things people did not expect to be copied. Every **password
reset link** the site sends now also lands in the BCC mailbox — and a reset link
is a credential, so that mailbox becomes able to take over any account on the
site. The same is true of one-time login links and account-activation emails, and
every message that carries personal data or an order address goes there too.
Three things follow from that:

- **The BCC mailbox needs the protection of the most sensitive thing in it** —
  which is account takeover. Make it a controlled address with restricted access,
  not a team alias people casually forward from.
- **Exclusions matter more than the feature.** If you can exempt password resets
  and other credential-bearing mail, do; if you cannot, weigh whether the archive
  is worth what it collects.
- **Recipients are not told** — that is what "blind" means. If the copy is kept
  for compliance, your privacy notice must say correspondence is retained, and
  the retention period must be real, not "forever in a mailbox".

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — set the BCC address and review the
   privacy implications before you turn it on.

## Where it lives in the admin menu

Once enabled, Blind Carbon Copy is configured at its own settings form
(**`bcc.settings`**, under Configuration). Set the BCC address there; see
[Configuration](configuration/index.md).
