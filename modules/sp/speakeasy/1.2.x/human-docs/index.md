# Speakeasy — manual setup guide

**Speakeasy** (`speakeasy`) adds text-to-speech controls to your site so visitors
can **listen** to your content, using the **browser's own Speech Synthesis API**
and the voices the visitor's operating system provides.

The design decision that defines this module is that speech happens **on the
visitor's device**. Nothing is sent to a cloud service: no per-character billing,
no third-party processing of your page content, no cookies and no consent
question. The trade-off is quality and consistency — system voices vary from good
to robotic across platforms and browsers, and a visitor on an older device gets
whatever it has. For a read-aloud convenience that is a fair trade; for narration
meant to be listened to at length it is not.

You place a **Speakeasy block** that compiles readable text from the fields your
audience can view and presents it as a button set, a media player, or a simple
link — with an optional voice picker, custom labels and per-block speed. Optional
**sentence highlighting** wraps each sentence, tracks playback and gently scrolls
the page as words are spoken. Administrators set global defaults (theme, whether
visitors can pick voices, default rate, voice whitelisting per browser, language
restrictions), and visitors who have permission can save their own voice and
speed on a personal preferences page. The front-end handles the accessibility
niceties too: it announces when speech synthesis is unavailable, updates ARIA
state as controls change, and offers keyboard shortcuts (Space to toggle, S to
stop).

**Be clear about what this is and is not.** A read-aloud button genuinely helps
people who find reading tiring, are reading in a second language, or are
multitasking — a real and underserved group. It is **not** a substitute for
accessibility: someone using a screen reader already has speech, better integrated
than a page-level button provides. A site that adds a read-aloud widget and
considers accessibility "handled" has done the opposite of the work.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — the global settings, placing the
   block, and the per-user preferences page.

## Where it lives in the admin menu

Global defaults are configured at **Configuration → Speakeasy**
(`/admin/config/speakeasy`), served by the `speakeasy.settings` route. Visitors
with the right permission manage their own voice and speed at
`/user/speakeasy/preferences`.
