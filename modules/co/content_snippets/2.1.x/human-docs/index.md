# Content Snippets — manual setup guide

**Content Snippets** (`content_snippets`) gives a proper home to the small
pieces of text that are neither a full page nor code — a strapline, a legal
footnote, a phone number that appears in four places, the sentence above a form,
an out-of-hours notice. Hard-coded in a template, that text needs a deployment
to change; scattered across custom blocks it is heavy for one sentence and easy
to lose track of; duplicated by hand it eventually disagrees with itself.
Content Snippets stores each one as configuration and lets the right people edit
it in the admin UI.

Its distinguishing feature is a deliberate **split of permissions**.
*Administer content snippets* decides *which* snippets exist — a structural
decision that belongs to a site builder — while *edit content snippets*
(described by the module as "generally for content editors") changes *what they
say* — an editorial decision. Keeping those two apart is exactly the point:
conflating them is why the custom-block workaround tends to go wrong. Snippets
are also exposed as **global tokens** and are available in **Twig templates**,
so a developer can drop a snippet into a template once and hand the wording over
to editors.

There is one trade-off to settle before you adopt it, because snippets are
stored as **configuration**. That means they travel with the codebase — they
show up in a config diff and are reviewable — but it also means a configuration
import can overwrite them. If a snippet's wording is really a design decision,
that is exactly what you want. If it is genuinely editorial and editors change
it on production, be aware the change can be lost at the next deployment unless
your workflow accounts for it. Decide which kind of text each snippet is.

The module is minimally maintained (maintenance fixes only) but has security
advisory coverage, runs on Drupal 8 through 11, and has no dependencies beyond
core. It works the moment you enable it — there is nothing you *must* configure
first; you simply start creating snippets.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

There is **no dedicated settings form** for this module. Setup is a matter of
granting the two permissions and then creating and editing snippets, described
in "How to use it" below.

## How to use it

1. Grant the permissions that fit your team at **People → Permissions**
   (`/admin/people/permissions`). Give **Administer content snippets** to the
   site builders who decide which snippets should exist, and **Edit content
   snippets** to the content editors who maintain the wording.
2. As an administrator, create the snippets you need and give each a clear label
   and machine name.
3. Editors can then update the text of any existing snippet without touching
   structure or code.
4. In templates, output a snippet through its **global token** or from **Twig**,
   so the same wording can appear anywhere you reference it.

> **Tip:** If you find you need much richer configuration — new configuration
> pages and fields beyond simple text snippets — the maintainers point to
> [Config Pages](https://www.drupal.org/project/config_pages) as a more powerful
> alternative.
