# Nyan cat progress bars — manual setup guide

**Nyan cat progress bars** (`nyan`) replaces Drupal's standard progress bar — the
one you see during batch operations, imports, migrations, module updates and AJAX
throbbers — with an animated **Nyan‑cat‑themed** bar. The animation is pure CSS,
and it comes with optional background audio (mp3/ogg, played via HTML5 audio tags)
for the full effect.

The "problem" it solves is morale, not function: long‑running batch screens are
dull, and this module makes them fun. Enable it and every core Drupal progress bar
switches to the Nyan cat animation out of the box — including update checks and VBO
batch screens. It is purely cosmetic: no data handling, no external calls, no
content routes.

There is a settings form for tuning the experience — most usefully the audio,
including the initial volume and an option to turn the sound off entirely — but the
module works the moment you enable it, so configuring it is optional. It works on
Drupal 9.3+ and 10, and has no dependencies.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

The settings form is optional and is described in "How to use it" below.

## Where it lives in the admin menu

Once enabled, the Nyan cat bar is active site‑wide immediately. Its optional
settings form sits at **Configuration → System → Nyan** (`/admin/config/system/nyan`),
gated by the **Administer nyan** permission.

## How to use it

1. Enable the module — that is all that is required. Every Drupal progress bar now
   uses the Nyan cat animation.
2. *(Optional)* Visit **Configuration → System → Nyan** to customise the bar. The
   most useful options control the **audio**: set the initial volume, or remove the
   sound entirely if you would rather keep things quiet. Defaults are stored in the
   `nyan.nyansettings` configuration.
3. *(Optional, Drupal 8+)* Use the module's preview screen to simulate a
   long‑running batch — handy for demos, or just for a dose of Nyan cat on demand.

> **Tip.** Enabling and removing the module is intentionally simple. If a serious
> tone is required on a particular site, disable the module (or restrict the
> **Administer nyan** permission) rather than trying to style around it.
