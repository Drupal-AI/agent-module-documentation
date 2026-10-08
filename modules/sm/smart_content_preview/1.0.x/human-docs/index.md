# Smart Content Preview — manual setup guide

**Smart Content Preview** (`smart_content_preview`) is a small companion submodule
for [Smart Content](../../smart_content/3.1.x/human-docs/index.md) that makes it
easy to review personalized content. When you add or edit a segment set, it adds a
**Preview** checkbox next to each segment; tick it and that segment always
evaluates as *true*, regardless of whether its real conditions (device, location,
cookies, and so on) are actually met.

That means content editors and QA staff can see exactly what each segment's
variation will look like without having to physically be on a mobile device, in a
particular country, or carrying a particular cookie. It's an "easy button" for
validating that every personalization variation renders correctly before it goes
live.

The module adds **no dedicated admin pages or permissions** — it simply hooks into
Smart Content's decision-settings pipeline and injects the preview state into the
decision JavaScript, so the selected segments are forced true for the viewer. It
depends only on Smart Content and supports Drupal 8 through 11. It pairs well with
the Smart Content SSR and block submodules.

This guide is written for a **human** working through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

> **Keep it self-scoped:** preview only changes which client-side variation *the
> current viewer* sees — it doesn't bypass any server-side access control. It's
> meant for content and QA staff reviewing personalized output, so during a review
> confirm the preview controls aren't exposed to ordinary visitors on production.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable it.

## How to use it

Once enabled, edit any Smart Content segment set. Next to each segment you'll see a
new **Preview** checkbox. Tick the segments you want to preview and that segment's
conditions are treated as satisfied, so the page renders that segment's variation.
Work through them one at a time to verify each variation's markup, then untick them
when you're done reviewing.
