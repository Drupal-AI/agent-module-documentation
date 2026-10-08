# Pathologic — manual setup guide

**Pathologic** (`pathologic`) is a text-format input filter that rewrites and
corrects URLs and paths in your content, so links and images keep working even when
the site's domain, base path, or protocol changes. If you've ever moved a site from
a staging server to production and found broken images or dead links scattered
through the content, Pathologic is the fix: it stores links in a normalized form
and rebuilds them into correct, current URLs every time the content is rendered.

You turn Pathologic on by enabling its filter — **"Correct URLs with Pathologic"** —
on a text format. As content renders, it inspects the `href`, `src`, `srcset`,
`action`, and `longdesc` attributes and corrects the ones it recognizes as local.
It can emit URLs in three styles — full absolute (`http://example.com/foo/bar`),
protocol-relative (`//example.com/foo/bar`), or root-relative (`/foo/bar`) — and you
can list all the base paths the site has ever lived at so links written against an
old host get corrected too. External and non-local URLs are left untouched. It
depends only on core's **Filter** module and has no submodules.

Settings can be **global** (one shared configuration) or **overridden per text
format**. Because Pathologic rewrites finished markup, it should almost always be
the **last** filter in a format's processing order — it ships with a heavy weight to
encourage exactly that. Developers can fine-tune or veto individual rewrites through
`hook_pathologic_alter()`.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead — including the
[hook reference](../agent/hooks/pathologic.md) if you need to alter rewrites in code.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — enable the filter on a text format,
   choose global vs. per-format settings, and set the output style and known base
   paths.

## Where it lives in the admin menu

Two places. You enable and order the filter per text format at **Configuration →
Content authoring → Text formats and editors** (`/admin/config/content/formats`).
The module's global settings form sits at **Configuration → Content authoring →
Pathologic** (`/admin/config/content/pathologic`).

## How to use it

The short version: enable the "Correct URLs with Pathologic" filter on the text
formats your content uses, drag it to the bottom of the filter list so it runs last,
then set the global output style and known base paths on the Pathologic settings
form. The [Configuration](configuration/index.md) page walks through each step and
option.
