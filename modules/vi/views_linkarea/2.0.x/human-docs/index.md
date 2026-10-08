# Views Link Area — manual setup guide

**Views Link Area** (`views_linkarea`) adds a single, very handy building block to
Views: a **"Link" area handler** you can drop into a view's **header**, **footer**,
or **no-results (empty)** region. It renders one configurable internal or external
link — think a "Create new content" call-to-action button above a listing, a
"Back to overview" link in the footer, or an "Add the first item" link shown when
a view has no results.

The link is highly configurable. You set the link text and path (a Drupal path,
route, URI, or a full external URL, optionally with a query string and fragment),
and you can style it as a themed **action button** matching core's primary admin
actions, add CSS classes, a `target`, a `rel`, a title tooltip, prefix/suffix
markup, and more. It can append a `destination` parameter so the link brings the
user back to the view, force an absolute URL (useful in RSS feeds or emails), and
pick a language on multilingual sites.

Most of the text options support **Views tokens**, taken from the first result
row — so you can build dynamic text like "See all {{ title }} items" or push a
row's field value into the link path. Routed (internal) links are automatically
**access-checked**: if the current user can't reach the target, the link is hidden
(or replaced with optional fallback text). It depends only on core Views.

This guide is written for a **human** configuring views through the admin UI. If
you want terse, token-cheap references for an AI coding agent (every option, the
tokenization rules, and the access handling), read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

## Where it lives in the admin menu

It has no settings page of its own. You use it entirely inside the **Views UI**
(`/admin/structure/views`), as an area handler on an individual view display.

## How to use it

1. Edit a View and open the display you want.
2. In the **Header**, **Footer**, or **No Results Behavior** section, click
   **Add**.
3. Choose **Link** (it's in the *Global* category, described as "Provide an
   internal or external link").
4. Configure it. The most-used options are:
   - **Link text** — what the link says. Supports tokens.
   - **Path** — a Drupal path, `entity:`/`route:` URI, `<front>`, or a full
     external URL; you can include a query and fragment. Supports tokens.
   - **External** — tick this if the path is an external URL with no scheme, so it
     gets prefixed with `http://`.
   - **Output as action** — renders the link as a themed primary-action button
     (like core's "Add content" buttons).
   - **Include destination** *(on by default)* — appends the current page as a
     `destination` query parameter so the link returns the user to this view.
   - **Prefix / suffix** — markup placed around the link. Also **CSS class**,
     **target**, **rel**, and a **title** tooltip attribute.
   - Advanced options include **absolute URL**, a **rewrite output** template
     (embed the built link via the `{{ views_linkarea }}` token inside arbitrary
     HTML), **access-denied text**, case transforms, space-to-dash replacement,
     and a **language** selector.
5. Apply and save.

**Tokens:** when the base "Use tokens" option is on, the text options are replaced
using values from the **first result row** — useful for header/footer links that
reference the list's context.

**Access:** for routed URLs the handler checks whether the user may reach the
target route; if not, it renders your optional access-denied text (or nothing)
instead of a broken link. External URLs are not access-checked.

> **Admin-only by design.** A few options — *prefix*, *suffix*, and the *rewrite
> output* template — intentionally accept HTML you author. Drupal's admin XSS
> filter blocks scripts but allows rich markup, so whoever configures the view is
> responsible for the safety of that markup and any token values injected. This is
> the same trust model as core's "rewrite results" and Global Text area, not a
> module vulnerability — just keep the *administer views* permission restricted to
> trusted roles.
