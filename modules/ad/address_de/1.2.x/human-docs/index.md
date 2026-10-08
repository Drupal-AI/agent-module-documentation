# Address DE — manual setup guide

**Address DE** (`address_de`) adds Germany's 16 federal states (the *Bundesländer*)
to the **Address** module as a proper state field. The addressing library that
powers Address deliberately leaves German states out, because they aren't used for
postal addressing — but plenty of sites need the Bundesland anyway, for tax,
reporting, filtering, or regional shipping rules. This module fills that gap.

Once enabled, any Address field set to country **Germany** gains a **state**
select listing all 16 federal states, and the state is appended to Germany's
address format so it shows in the rendered address. The list is built into the
module's code — it's static, local data, so there are no external calls.

There's genuinely nothing to configure: the module is a single event subscriber
that reacts to the Address module's format and subdivision events. **Enabling it is
the entire setup.** It has no settings page, routes, permissions, or services of
its own.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

## Where it lives in the admin menu

There is no admin page for this module. It works automatically. To see it, edit any
entity with an **Address** field, set the country to **Germany**, and a **state**
select of the 16 Bundesländer appears.

## How to use it

1. Make sure you have an **Address** field on a content type (or user, profile,
   Commerce customer profile, etc.).
2. Enable Address DE (see [Installation](installation/index.md)).
3. On an address form, choose country **Germany** — the state select now appears.
   Use the captured state for tax rules, filtering, reporting, or shipping zones as
   you need.
