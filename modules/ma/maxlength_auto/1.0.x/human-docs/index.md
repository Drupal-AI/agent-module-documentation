# MaxLength Auto — manual setup guide

**MaxLength Auto** (`maxlength_auto`) removes a small chore from working with the
[MaxLength](https://www.drupal.org/project/maxlength) module. MaxLength shows a live
character‑count / limit indicator on text fields as editors type, but out of the box
you have to switch it on **per field**. MaxLength Auto does that for you: it
automatically enables the MaxLength counter on **every field widget that already has
a maximum length**, so any length‑limited field gets the live feedback without
individual configuration.

That's the whole feature — there is nothing to configure and no settings form. Once
enabled (alongside its MaxLength dependency), fields with a `#maxlength` gain the
counter automatically.

It's worth being clear about what it does and doesn't do. This is a **content‑editing
/ UX enhancement**: it adds a character counter to the editing widget. The field's
actual maximum‑length constraint is enforced by the field and database regardless of
whether the counter is shown, so the module changes the *experience* of hitting the
limit, not the limit itself. It also has **no access‑control role**.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer along with the
   MaxLength dependency, and enable the module.

There is **no configuration page** — the module has no settings form. Once enabled it
applies the MaxLength counter automatically to fields that have a maximum length.

## Where it lives in the admin menu

MaxLength Auto adds no admin page of its own. Its effect appears on content **edit
forms**, where length‑limited fields now show a live character counter.
