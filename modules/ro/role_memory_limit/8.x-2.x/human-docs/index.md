# Role Memory Limit — manual setup guide

**Role Memory Limit** (`role_memory_limit`) lets you raise (or lower) PHP's
`memory_limit` for specific user roles, so heavy administrative work gets more memory
without raising the global limit for everyone — including anonymous traffic.

The typical situation: your server's PHP memory limit is 128&nbsp;MB, and an
administrator opening a big listing page (say the block layout page, or a bulk
operation) runs out of memory and the page crashes. Rather than bumping the limit
for the entire site — which would let every anonymous request consume that much
memory — you give the administrator role a higher limit and leave everyone else on
the safe default.

Under the hood the module runs very early in each request: an event subscriber reads
the current user's roles, finds the memory limits you configured for them, and
applies the **highest** one for that request. User&nbsp;1 uses the `administrator`
value, and a value of `-1` means unlimited. Because it runs at the start of the
request, the right limit is in place before most work happens.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.
2. [Configuration](configuration/index.md) — set a memory limit per role.

## Where it lives in the admin menu

Once enabled, configure the per-role limits at **Configuration → System → Role
memory limit** (`/admin/config/system/role-memory-limit`), which is gated by the
**Administer site configuration** permission.

## Requirements worth knowing up front

The module works by calling `ini_set('memory_limit', …)`, so your hosting must allow
PHP to change the memory limit at runtime. It has no effect where PHP is built
without that ability. See [Installation](installation/index.md) for details.
