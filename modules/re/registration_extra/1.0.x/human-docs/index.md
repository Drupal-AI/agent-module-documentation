# Registration Extra — manual setup guide

**Registration Extra** (`registration_extra`) adds convenience features on top of
the contributed **Registration** module (the one that lets people sign up to
attend events or register against any entity). It doesn't replace anything in
Registration — it fills in the small, repetitive gaps around it: default messages,
organizer notifications, a reminder template, a token that renders everything a
registrant submitted, and a way to download registrations.

Specifically, for each **registration type** it lets you set:

- a **default confirmation message** shown to people after they register,
- **default organizer email addresses**,
- a **default reminder email template**, and
- an option to **email the organizers** whenever a new registration comes in.

It also provides a token, `[registration_extra:registration_data]`, that outputs
**all the data a user submitted** on a registration (handy inside confirmation or
notification emails), and it adds the ability to **download all registrations** for
a form.

Because it depends on Registration, everything it does happens through Registration
types and forms. It has no admin settings page of its own — its options live on
each registration type's configuration.

> **A note on data and access.** Registration involves things that matter —
> capacity, approval, and per-registrant personal data. When you turn on organizer
> notifications or use the "all submitted data" token, you're moving registrant
> information (potentially PII) into emails. Make sure the behavior you configure
> preserves your registration access controls (who may register, any approval
> requirement) and that you handle registrant data in line with your privacy
> policy.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it alongside Registration.
2. [Configuration](configuration/index.md) — the per-registration-type defaults,
   the data token, and downloading registrations.

## Where it lives in the admin menu

Registration Extra has no dedicated settings page. Its options attach to the
**Registration types** you already manage under **Structure → Registration types**
(part of the Registration module), and its features surface on registration forms
and in tokens. See [Configuration](configuration/index.md) for where each one
lives.
