# Configuration

You manage everything from the policy UI. First make sure you've enabled at least
one **constraint submodule** (see [Installation](../installation/index.md)) —
without one, a policy has no conditions to match on.

## Step 1 — Grant the permission

All the policy screens are gated by the **Administer memory limit policies**
(`administer memory limit policies`) permission. Grant it at **People →
Permissions** to the roles that should manage memory tuning (typically just
administrators). Treat it as sensitive — it lets someone change PHP's memory limit
for site requests.

## Step 2 — Open the policy list

Under **Configuration**, navigate to
`/admin/config/performance/memory-limit-policy/list`. This page lists your
policies, lets you reorder them, and has an **Add policy** action.

## Step 3 — Add a policy

Click **Add policy**. It's a short multi-step form:

1. **Label** — a human-readable name (e.g. "Heavy reports").
2. **Memory** — the limit to apply when the policy matches, as a PHP memory string:
   `256M`, `512M`, `1G`, and so on. This value is passed straight to
   `ini_set('memory_limit', …)`, so use the same format you'd put in `php.ini`.
3. **Weight** — the evaluation order (see "How matching works" below).
4. **Status** — whether the policy is enabled. A disabled policy is skipped
   entirely, which is handy for temporarily turning a policy off while diagnosing
   an issue without deleting it.

Save, then add constraints.

## Step 4 — Add constraints

A policy without constraints never matches usefully — the constraints are what say
"apply this policy *when…*". On the policy's edit screen, add one or more
constraints. The types available depend on which submodules you enabled; each
constraint has its own small config, for example:

- **Path** — one or more paths, wildcards allowed (e.g. `/admin/reports/*`).
- **Role** — one or more roles (e.g. *Content editor*).
- **Route** — a specific route name, or the built-in "admin route" match.
- **HTTP method** — e.g. only `POST`/`PUT` (API writes).
- **HTTP header**, **Query parameter**, **Domain**, **Environment variable**,
  **Drush command** — as provided by their respective submodules.

Two things to know about how constraints combine:

- **All constraints must pass (AND).** A policy applies only when *every* one of its
  constraints matches the request. So "path is `/admin/reports/*` **and** role is
  *Content editor*" is one policy with two constraints.
- **Negate** — each constraint has a *negate* flag that flips its meaning to
  "everywhere except." For example, a path constraint on `/user/*` with negate on
  means "any request that is **not** under `/user/`."

## How matching works (weight and "last match wins")

On every request the module evaluates all **enabled** policies in **weight order,
ascending**. Every policy whose constraints all pass applies its memory value — and
because evaluation doesn't stop at the first match, the **last matching policy (the
one with the highest weight) wins**.

Use this to layer policies: give a broad, low-limit policy a low weight and a
narrow, high-limit policy a higher weight, so the targeted policy overrides the
broad one exactly where it applies. Reorder policies by dragging them on the policy
list (which sets their weight).

## Step 5 — (Optional) Turn on debug headers

To confirm which policy actually applied to a given request, go to the settings
form at `/admin/config/performance/memory-limit-policy/settings` and enable the
**header** option. With it on, responses carry debug headers:

- `X-Memory-Limit-Memory` — the memory value applied,
- `X-Memory-Limit-Override` — whether an override happened,
- `X-Memory-Limit-Policy-Name` — which policy matched.

Inspect them with your browser's network tab or `curl -I`. Turn this off again once
you've finished debugging — you generally don't want to advertise your memory
tuning on production responses. From the command line:

```bash
drush config:set memory_limit_policy.settings header true -y   # on
drush config:set memory_limit_policy.settings header false -y  # off
```

## Deploying policies as config

Policies are configuration entities
(`memory_limit_policy.memory_limit_policy.<id>`), so they export with your
configuration and deploy between environments like anything else. There's no
dedicated Drush command for creating them, but you can manage them through the
standard entity API if you prefer scripting — see the
[`agent/`](../agent/start.md) docs for an example, and for writing a custom
constraint plugin for a project-specific condition.
