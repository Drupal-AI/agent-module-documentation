# Jitsi — manual setup guide

**Jitsi** (project `jitsi`; the module's machine name is **`ek_jitsi`**, part of
the "ek" suite) integrates **Jitsi Meet** video conferencing into your Drupal
site. It lets users start a new video session or join an existing room directly
from the site, by pointing at a Jitsi Meet server and embedding meeting rooms in
the page.

It gives you a few ways to surface video:

- a **block** for accessing Jitsi videos,
- the ability to **join an existing room** or **create a room with a random
  name**, and
- a **Jitsi video field** you can insert into content pages.

Jitsi itself is a set of open‑source projects for secure video conferencing; this
module is the glue that embeds it in Drupal. It provides its own permission so you
control who can use it.

## A note on privacy and where the video runs

Video calls do **not** run on your Drupal server — they run on a **Jitsi Meet
server**, either the public `meet.jit.si` instance or one you host yourself, and
the module loads Jitsi's **external script** into the page. That has two practical
consequences worth planning for:

- **Prefer a self‑hosted or otherwise trusted Jitsi server for sensitive
  meetings**, rather than the public instance, so your call traffic goes where you
  intend.
- **Watch room‑name guessability.** Jitsi rooms are often reachable simply by URL,
  so a predictable room name can let uninvited people join. Use non‑guessable room
  names (the "random name" option helps) and, where it matters, enable
  authentication on the Jitsi server side.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it (note the `ek_jitsi` machine name).

## How to use it

After enabling the module (remember its machine name is `ek_jitsi`):

1. Grant the module's **permission** to the roles that should be able to start or
   join calls, at **People → Permissions**.
2. Point the integration at your chosen **Jitsi Meet server** — a self‑hosted
   instance for sensitive use, or the public `meet.jit.si` for casual use.
3. Surface video where you need it: place the **Jitsi block** in a region at
   **Structure → Block layout**, and/or add the **Jitsi video field** to a content
   type at **Structure → Content types → *(bundle)* → Manage fields**.
4. Create rooms with non‑guessable names (or use the random‑name option), and join
   existing rooms as needed.
