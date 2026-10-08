# Reading Rating — manual setup guide

**Reading Rating** (`reading_rating`) scores the **readability** of a long-text
field and shows the result to the editor **as they write**, updating in real time.
It uses the **Flesch–Kincaid** readability algorithm, works with both CKEditor 5
and plain (non-WYSIWYG) text fields, and is configured **per field**. It can also
show grade-level ratings, and supports translatable, configurable ratings.

Readability formulas estimate how hard a passage is from sentence length and
syllable counts. They are crude by design, but they are also the most *actionable*
editorial feedback available, because the two things they measure — sentence
length and word length — are the two things a writer can directly fix. For
public-sector, health, and accessibility-focused sites, a target reading age is
often an explicit requirement, and a live score turns that abstract standard into
a number that moves while you type.

Three things worth being honest about when you use it:

1. **The formulas are English-specific.** Syllable counting assumes English
   orthography, so a score on German, Finnish, or Welsh text is arithmetic without
   meaning. A multilingual site needs a per-language answer or none.
2. **They measure form, not sense.** A passage of short sentences full of
   undefined jargon scores well and communicates nothing — the exact failure mode
   of writing to a score.
3. **A target is guidance, not a gate.** The module shows the score and leaves the
   judgement with the writer, which is the healthy way to use it; blocking
   submission on a readability number tends to produce text contorted to satisfy
   the arithmetic.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable it.
2. [Configuration](configuration/index.md) — turn Reading Rating on for a specific
   field, step by step.

## Where it lives in the admin menu

Reading Rating adds no central settings page. It is enabled **per field**, from a
field's settings on the entity's **Manage form display** (the gear icon next to
the field). A **Manage reading rating** permission governs who can change those
settings, and the score itself appears on the content edit form beneath the field.

## How to use it

1. Enable the module (see [Installation](installation/index.md)).
2. On the **Manage form display** of a content type, block type, paragraph, etc.,
   open the field's settings and enable Reading Rating for that field (see
   [Configuration](configuration/index.md)).
3. Grant the **Manage reading rating** permission to the roles that should manage
   these settings.
4. Edit a piece of that content — a **Reading Rating** section now appears below
   the text field, updating the score live as the editor types.
