# Symfony Mailer From Filter — manual setup guide

**Symfony Mailer From Filter** (`symfony_mailer_from_filter`) limits the *From*
address on outgoing email to an **allowlist**. When a message tries to send from
an address that is not on the list, the module moves that address out of the
*From* header (to a reply-to / fallback) so the mail actually goes out from an
approved sender.

The main use case is a mail server that will only accept mail *From* a known
address or domain. Many outbound providers — and DMARC/SPF/DKIM alignment —
require that your mail always come from an approved, aligned sender; if some
part of Drupal tries to send from an arbitrary address, delivery fails or the
message is treated as spoofed. This module enforces a single, approved sender
policy so that everything leaves from an address your infrastructure is allowed
to send from, which improves deliverability and stops spoofed sender addresses.

It is an email-hardening enhancement for **Symfony Mailer** (`symfony_mailer`),
which it depends on, and it works on Drupal 10 and 11. It has no content or
access-control role of its own. Note this is an early **alpha** release
(1.0.0-alpha1).

This guide is written for a **human** setting the module up through the admin
UI. If you want terse, token-cheap references for an AI coding agent, read the
sibling [`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

## How to use it

The filter is not a standalone settings page — you apply it through Symfony
Mailer's own policy system:

1. Go to **Configuration → System → Mailer** (`/admin/config/system/mailer`).
2. Edit the **Mail policy** (or policies) you want the filter to apply to.
3. Add **From filter** to that policy, and configure the allowed *From*
   address(es) as needed.
4. Save the policy.

From then on, any mail sent under that policy is checked: an allowed *From*
address passes through unchanged, while an unrecognized one is moved aside so the
message is sent from an approved sender instead. Apply the filter to whichever
policies cover the mail you want to constrain.
