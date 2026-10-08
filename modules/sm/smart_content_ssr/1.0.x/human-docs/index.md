# Smart Content SSR — manual setup guide

**Smart Content SSR** (`smart_content_ssr`) adds **server-side rendering** to
[Smart Content](../../smart_content/3.1.x/human-docs/index.md). The standard Smart
Content flow renders a placeholder that a client-side AJAX call later swaps for the
matching content. This submodule instead provides an **SSR Decision block** that
resolves the winning segment *on the server* and renders its content directly into
the page — no JavaScript round-trip.

The payoff is that personalized content is present in the initial HTML, which helps
with SEO, works for no-JS or limited-JS clients, and avoids the brief "content
flash" that happens when a client-side swap replaces the placeholder. A
decision-evaluator service does the server-side evaluation and the SSR Decision
block renders the matching block instance during the page build.

There's a trade-off to plan for: because the decision is evaluated on the server,
each segment produces different output, so your caching/`Vary` strategy needs to
account for per-segment variation — the **Smart Content CDN** submodule is the
natural partner for that on Pantheon's edge. Note also that, at this release, only
**basic conditions** are handled server-side; support for other conditions can be
added through API hooks.

The module adds **no admin pages or permissions of its own** — you simply use the
SSR Decision block in place of (or alongside) the standard client-side Decision
block. It depends only on Smart Content and supports Drupal 8 through 11.

This guide is written for a **human** working through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable it.

## How to use it

Once enabled, place an **SSR Decision block** where you would normally place a
Smart Content Decision block, and author its segments and reactions in the usual
way. When the page is built, the decision-evaluator service picks the matching
segment on the server and renders that reaction's block instance straight into the
HTML. Because the output now varies per segment, review your caching and `Vary`
handling (see Smart Content CDN for edge `Vary` support) so each visitor still gets
the right cached variant.
