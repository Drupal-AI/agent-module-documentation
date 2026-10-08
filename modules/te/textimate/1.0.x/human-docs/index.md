# Textimate — manual setup guide

**Textimate** (`textimate`) turns ordinary text on your site into animated text —
per-character and per-word reveals, transitions, and other eye-catching effects.
It builds on the **Splitting** library, which breaks a piece of text into its
individual words and characters so each one can be animated in turn, and it pairs
that with CSS animation effects to bring your headings and content to life.

The idea is to take static text — a node title, a slideshow caption, the words in
a block — and give it movement without you having to write any JavaScript or CSS
by hand. You pick the effect, choose whether it runs letter-by-letter or
word-by-word, decide which JavaScript event triggers it, and tune the timing and
delay. Textimate then applies the animation to the text you target.

Textimate is a theming and presentation feature: it changes only how text
*appears* and animates, never the content itself or who can see it. It depends on
the **Splitting** module and provides its own permissions. Before you can create
effects you need to configure them, so this is a module that needs a little setup
rather than one that does everything the moment it is switched on.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module (and the Splitting
   dependency) with Composer and enable it.
2. [Configuration](configuration/index.md) — where the effects management screen
   lives and the kinds of options it offers.

## Where it lives in the admin menu

Once enabled, Textimate's management screen lives under **Structure → Textimate**
(`/admin/structure/textimate`). That is where you add effects and set the handful
of options that control how each animation behaves.

## How to use it

After you have created one or more effects on the Textimate screen, they can be
applied to the text you want animated — node titles, block content, slideshow
captions, and other content output. A gentle word of caution from the module's
own notes: animation can improve the experience of an interface, but it can also
get in a user's way, so use it where it adds value rather than everywhere at once.
