<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# REST Invalidate Cache — agent index

A **REST endpoint that invalidates specific cache tags** (external targeted cache clearing). Depends on core
`rest`. Version **1.0.x** (dev). Core `^9||^10||^11||^12`.

Performance/integration — **REST-permission-gated** (not anonymous), but cache invalidation is **privileged/
abusable** (forces expensive rebuilds — DoS lever): grant only to trusted machine accounts, authenticate, rate-
limit. No access role beyond permission.
