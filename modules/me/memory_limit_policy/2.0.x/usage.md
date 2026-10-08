<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Memory Limit Policy overrides PHP's `memory_limit` at runtime for specific requests, based on configurable policies. Each policy sets a target memory value and a set of constraints; when every constraint matches the current request the policy's memory value is applied via `ini_set('memory_limit', ...)`.

---

The module provides a `memory_limit_policy` configuration entity and a `MemoryLimitConstraint` plugin type. A policy has a `memory` value (e.g. `256M`, `512M`, `1G`), a `weight`, a `status`, and an ordered list of `policy_constraints` (plugin instances). On every request a high-priority event subscriber (`MemoryLimitPolicySubscriber`, on `KernelEvents::REQUEST` at priority -1) loads all enabled policies, sorts them by weight ascending, and evaluates each: a policy applies only when **all** its constraints pass (logical AND), where each constraint may be individually negated. Every applying policy calls `ini_set('memory_limit', ...)`, and because the loop does not break, the **last** matching policy in weight order wins. The base module ships no constraint plugins itself — the actual conditions come from submodules (role, path, route, HTTP method, HTTP header, query param, domain, environment variable, drush) and any custom plugin. A settings toggle (`memory_limit_policy.settings:header`) makes the response emit debug headers (`X-Memory-Limit-Memory`, `X-Memory-Limit-Override`, `X-Memory-Limit-Policy-Name`). Everything is managed from a non-developer UI at `/admin/config/performance/memory-limit-policy/list`, gated by the `administer memory limit policies` permission.

---

- Raise `memory_limit` only for a heavy admin listing (e.g. a large views page) instead of globally in php.ini.
- Give editors a higher memory limit on node edit forms with many fields or media without slowing anonymous traffic.
- Bump memory for a specific report path such as `/admin/reports/*` where entity aggregation is expensive.
- Apply extra memory only to authenticated users with a given role (e.g. `content_editor`) via the role submodule.
- Override memory for a single route name (e.g. `system.batch_page`) using the route submodule.
- Apply a blanket higher limit to all admin routes with the `admin_route` constraint.
- Raise memory only for `POST`/`PUT` requests (API writes) with the HTTP method submodule.
- Increase memory for requests carrying a specific HTTP header (e.g. `X-Consumer: importer`) using the HTTP header submodule.
- Bump memory only when a debug/query parameter like `?export=1` is present via the query param submodule.
- Set a per-domain memory limit on a multisite/domain setup using the domain submodule.
- Drive the memory limit from an environment variable (e.g. `APP_ENV=migration`) with the env variable submodule.
- Raise memory only for specific long-running Drush commands (e.g. `migrate:import`) with the drush submodule.
- Combine constraints so a policy applies only for one path AND a specific query argument AND a specific role.
- Use the `negate` flag on a constraint to mean "everywhere except" a path/role/route.
- Order overlapping policies with `weight` so a broad low-limit policy is superseded by a targeted high-limit one.
- Temporarily disable a policy (`status: false`) without deleting it while diagnosing an out-of-memory issue.
- Emit `X-Memory-Limit-*` response headers to confirm which policy applied to a given request while debugging.
- Export policies as config (`memory_limit_policy.memory_limit_policy.<id>.yml`) and deploy them across environments.
- Write a custom `MemoryLimitConstraint` plugin for a project-specific condition (e.g. current workspace).
- Manage policies programmatically or via natural language using the AI Agents submodule.
- Prevent OOM fatals on a specific bulk operation without over-provisioning PHP-FPM for every worker.
- Cap memory low on public pages while allowing more on a narrowly targeted internal tool.
- Reproduce and confirm a fix for "Allowed memory size exhausted" errors scoped to one interface.
- Keep memory tuning in the site's tracked configuration instead of server-managed ini files.
- Apply different limits to CLI (drush) versus web requests for the same site.
