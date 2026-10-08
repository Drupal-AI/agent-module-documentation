# Licenses vocabulary — manual setup guide

**Licenses vocabulary** (`licenses_vocabulary`) gives you a ready‑made **taxonomy
of licences** — each licence is a taxonomy term — so you can tag any content or
entity with a standard licence. It's inspired by the Media Attribution module but
isn't limited to media: because it simply creates the vocabulary, you're free to
attach a term‑reference field to whatever content types or entities you like.

On install it imports a starter set of licences: the basic **Creative Commons
4.0** licences and **CC0**. From there you can add more, either by hand in the
taxonomy UI or by pasting additional licence definitions into a textarea in the
module's settings. Licence logos are drawn from Creative Commons' own downloads.
Importing terms is gated by an **Import licenses** permission, so only trusted
users can bulk‑load the vocabulary.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable it
   alongside core Taxonomy.
2. [Configuration](configuration/index.md) — importing licence terms and the
   permission that controls it.

## Where it lives in the admin menu

The licence terms live under **Structure → Taxonomy** like any other vocabulary,
where you can view and edit them. The module's import settings — where you can
paste additional licence definitions — are gated by the **Import licenses**
permission.

## How to use it

1. Enable the module; the Creative Commons 4.0 and CC0 licences are imported for
   you.
2. If you need more licences, add terms in the taxonomy UI or import them via the
   settings textarea (see [Configuration](configuration/index.md)).
3. Add a **term‑reference field** pointing at the licences vocabulary to any
   content type or entity you want to be able to tag with a licence.
4. When creating content, editors select the applicable licence, and you can then
   display it (with its logo) wherever you render the entity.
