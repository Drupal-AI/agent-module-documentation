# Context Inject — manual setup guide

**Context Inject** (`context_inject`) extends the **Context** module with two new
**reactions** so a site builder can attach extra markup or assets to any page
selected by a context's conditions — no theme edits required. The **Inject HTML
snippet** reaction outputs a free‑form snippet (placed at the top or bottom of the
page), and the **Attach library** reaction attaches a named Drupal asset library.
Both are configured as reactions inside the normal Context UI, which means all the
scoping — which paths, roles, content types, and so on — is handled by the parent
Context module's conditions.

This is the tidy way to do the everyday jobs teams otherwise hack into templates:
adding an analytics or tag‑manager script, a chat widget, a verification meta or
script tag, JSON‑LD structured data, a cookie‑consent snippet, or A/B‑testing
code — scoped to exactly the pages you want, and toggled simply by enabling or
disabling the context.

**Read this before you use the snippet reaction.** The *Inject HTML snippet*
reaction outputs its configured snippet as **trusted, unfiltered markup** —
including any `<script>` you put in it. That is entirely by design (injecting raw
HTML/JS is the whole point), but it means the reaction can place **arbitrary
JavaScript site‑wide**. The ability to add or edit these reactions is gated behind
the Context module's **administer contexts** permission, which is already an
effectively site‑scripting‑level privilege. Grant that permission **only to fully
trusted roles**, and where you can, prefer the **Attach library** reaction over an
inline snippet so assets go through Drupal's library and aggregation pipeline.

The module depends only on the **Context** module, requires **PHP 8.1**, and runs
on Drupal 10 and 11. It defines no routes, services, or permissions of its own and
makes no outbound HTTP calls. It is minimally maintained (maintenance fixes only)
and this version is **not covered** by Drupal's security advisory policy.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable it
   (Context is a required dependency).

There is **no settings form of its own** — everything is configured as reactions
inside the Context UI, described below.

## How to use it

Both reactions are added to a context, so start by creating or editing a context
(this requires the Context module's **administer contexts** permission).

### Inject HTML snippet

1. Create or edit a context.
2. Add the **Inject HTML snippet** reaction.
3. Paste the full HTML/JS into the **HTML Snippet** textarea.
4. Choose the **Position**: **Bottom** (default) or **Top** of the page.
5. Save. The snippet is rendered on every page the context's conditions match —
   including any `<script>` you included, output exactly as entered.

### Attach library

1. Create or edit a context and add the **Attach library** reaction.
2. Enter the machine name of a Drupal asset library, in the form
   `module_or_theme/library_name` (a comma‑separated list is accepted for
   several).
3. Save. The library (its CSS/JS) is attached on the pages the context matches.

### Scoping

Which pages actually receive the injection is controlled by the **context's own
conditions** — path, role, content type, and so on. This module only contributes
the two reactions; the targeting comes from Context.

> **Security reminder:** the snippet is output unescaped, so anyone who can edit a
> context can inject site‑wide JavaScript. Keep **administer contexts** with fully
> trusted roles, and reach for **Attach library** instead of an inline snippet
> whenever you can.
