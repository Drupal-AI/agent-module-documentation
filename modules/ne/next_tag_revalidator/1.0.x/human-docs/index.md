# Next.js Tag Revalidator — manual setup guide

**Next.js Tag Revalidator** (`next_tag_revalidator`) gives a headless Drupal +
Next.js site **precise, cache‑tag‑based revalidation**. When content is created,
updated, or deleted in Drupal, it tells your Next.js application exactly which
pages to refresh — based on cache tags — instead of rebuilding the whole site.
It plugs into the **Next.js** (`next`) module as an additional "revalidator" you
attach to a Next.js site.

Compared with the base Next.js module's built‑in Cache Tag revalidator, this one
adds granular control: you choose which tags to revalidate (individual entities
such as `node:123`, entity‑list tags such as `node_list:article`, or custom tags),
it generates the proper list tags Next.js applications need, its forms show
context‑aware examples based on your content types, and it sends **one HTTP request
per cache tag** so revalidation is easy to debug. You then tag your Next.js
`fetch()` calls with the matching cache tags so the right pages refresh.

> **Important — this module is deprecated.** Its changes have been ported into the
> latest Drupal **Next.js** module, and the project is marked *Unsupported /
> Obsolete*. For new work, prefer the revalidation features now built into the
> `next` module. This guide documents the module as it stands for existing
> installations.

Because it talks to your Next.js app's revalidation endpoint, its "configuration"
lives on your **Next.js site** entity — see [Configuration](configuration/index.md).
That endpoint is normally protected by a shared secret, which you should store
securely. The module has no access‑control role of its own and supports Drupal 10
and 11.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module and the Next.js dependency.
2. [Configuration](configuration/index.md) — attach the revalidator to a Next.js
   site, choose which tags to revalidate, and store the shared secret safely.

## How to use it

At a high level: enable the module, add its **Next.js Cache Tag** revalidator to
your Next.js site, choose which cache tags to send, and then tag your Next.js
pages with those same cache tags. The step‑by‑step is on the
[Configuration](configuration/index.md) page.
