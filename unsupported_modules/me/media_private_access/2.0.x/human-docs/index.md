# Media Private Access — manual setup guide

**Media Private Access** (`media_private_access`) adds an **access‑control handler
for media entities**, so that viewing a media item can be restricted to
administrators, the media's **owner**, and users who hold a per‑type
**`view <type> media`** permission. It's aimed at sites that expect media to behave
the way Drupal core handles access to private files — which, out of the box, media
does not.

Per media type, you choose an **access mode**: permission‑based, inherited from the
top‑level route, or inherited from the immediate parent (each explained on the
[Configuration](configuration/index.md) page). The entity‑level access it enforces
is real and correct — it properly returns "forbidden" — so it's respected by the
standalone media page and by access‑aware paths such as Views results and JSON:API.

> **Two things you must understand before relying on this module.**
>
> 1. **It is experimental — a proof of concept.** Its own maintainers describe it
>    as *not ready for production*, in a very early development stage, and advise
>    doing your own code review and testing before using it. Treat it accordingly.
>
> 2. **It protects the media ENTITY, not the file bytes.** The module governs
>    access to the media *entity* only. It implements no `hook_file_download` and
>    does not require the private file scheme, so a media item whose underlying
>    file sits in **`public://`** (the default) remains **directly downloadable by
>    its file URL**, bypassing this handler entirely. For genuine file protection
>    you must store the files in the **`private://`** scheme, where core's file
>    access and `hook_file_download` apply. Restricting the media entity alone gives
>    a false sense of file privacy for public‑scheme files.

There is also a documented **limitation**: list access control is not implemented —
only individual access control. A forbidden media item can still appear in a View
if that View's own filters don't exclude it. The module depends on core's **Media**
module and provides its own permissions.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — the per‑type access modes and the
   assumptions they all share.

## Where it lives in the admin menu

Its settings page sits at **Configuration → Media → Media Private Access Settings**
(`/admin/config/media/media-private-access`).
