# Random Number Field — manual setup guide

**Random Number Field** (`random_number_field`) adds a new field type to Drupal.
When you add it to a content type (or any fieldable entity) and set a **minimum**
and **maximum**, the field is automatically populated with a random integer within
that range when the entity is created — no code and no data-generation module
required.

It's handy whenever content needs an arbitrary number attached to it: a raffle
number, a sampling weight, a non-sequential identifier, or throwaway test data.

> **Important — this is not for anything security-sensitive.** The randomness is
> ordinary (non-cryptographic), so the value is *not* safe to use as a token,
> password, secret code, or anything an attacker must not be able to guess. For
> raffle numbers, display shuffling, or test data it is perfectly fine; for
> anything that protects access or money, use a proper cryptographic source
> instead.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

There is **no configuration page** for this module. You use it entirely by adding
the field to an entity, as described below.

## How to use it

1. Go to **Structure → Content types → *(your type)* → Manage fields** (or the
   Manage fields screen of any other fieldable entity).
2. Click **Add field** and choose **Random Number Field** as the field type.
3. In the field's settings, set the **minimum** and **maximum** values. The
   random integer generated on each new entity will fall within this range
   (inclusive).
4. Save the field. From now on, every newly created entity of that type gets a
   random number in the field automatically.
