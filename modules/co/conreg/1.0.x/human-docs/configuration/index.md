# Configuration

ConReg needs a few post‑install steps before it can take registrations. Because the
project is at an early beta stage, some of these are rougher than a typical
contrib module — the maintainer has flagged them as things being improved.

## 1. Your convention (event) record

Installing ConReg automatically creates one open **"Default event"** for you, so a
convention already exists to register people against. Manage events — rename the
default one, add more, or clone an existing event's settings — from
**Configuration → ConReg → Events** (`/admin/config/conreg/events`). Each event's
detailed settings are edited at **Configuration → ConReg → Event Configuration**.

## 2. Configure Stripe for payments

ConReg takes membership and add‑on payments through **Stripe**. To accept payments
you must:

- Have the **Stripe PHP library** installed (it comes in via Composer — see
  [Installation](../installation/index.md)).
- Store your **Stripe API keys as Key entities** using the **Key** module (a
  dependency), then select them in each event's **Event Configuration → Payments**
  section (public key, secret key, currency and payment mode). Because keys are held
  by the Key module rather than in ConReg's own config, you can back them with an
  environment variable or file provider and keep the secrets out of exported config.
  The payment settings form can validate the secret key against Stripe and check
  that both keys are in the same test/live mode.

Because this is a real financial flow, treat the keys as secrets and restrict who
can reach the registration management screens.

## 3. Membership types, preferences and add‑ons

ConReg supports several membership‑related settings that shape the registration
form:

- **Membership types** — the different kinds of membership attendees can choose.
- **Membership preferences** — customisable options you collect from each member.
- **Add‑on payments** — extra charges or optional items a member can pay for on
  top of their membership.

Configure these to match how your convention sells memberships.

## 4. Permissions

ConReg provides its own permissions for the management side. At **People →
Permissions** (`/admin/people/permissions`), grant the ConReg management
permissions only to the organiser roles that need them — registration data is
attendee personal data (and, with payments enabled, financial data), so keep it
away from roles that do not need it.

## A note on maturity

ConReg is being actively modernised: its roadmap moves it from custom database
tables toward Drupal entities and, later, integration with the Member Platform /
CRM ecosystem. Expect the setup steps above to keep getting smoother in later
releases — check the project's documentation for the current state before running a
live event.
