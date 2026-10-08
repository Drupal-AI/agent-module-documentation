# Monitoring — Heart Rate Monitor — manual setup guide

**Monitoring — Heart Rate Monitor** (`monitoring_hrm`) adds a single health-check
endpoint — **`/healthz`** — whose HTTP status code tells you, in one number,
whether any of the [Monitoring](https://www.drupal.org/project/monitoring)
module's sensors is failing. It is built for the infrastructure that keeps your
site running: load balancers, Kubernetes liveness probes, and uptime checkers like
Pingdom or StatusCake, which cannot read a dashboard but can act on a status code.

The design is deliberately minimal. Reducing your whole set of Monitoring sensors
to a single healthy/unhealthy signal is exactly what lets orchestration tooling
take an unhealthy instance out of rotation. And `/healthz` is the conventional
path such tooling already defaults to, so the endpoint usually works with existing
probe configuration rather than needing a custom definition.

There is **no settings form** — the endpoint exists once the module is enabled.
What does need your attention is **who can reach `/healthz`**, which is a
deployment decision rather than a click in the UI (see below). The module depends
on the Monitoring module and requires PHP 8.1.

This guide is written for a **human**. If you want terse, token‑cheap references
for an AI coding agent, read the sibling [`agent/`](../agent/start.md) docs
instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

There is **no configuration page** for this module. The one thing to get right —
access to the endpoint — is described below.

## How to use it

Once enabled, point your health-checking infrastructure at `/healthz`:

- A **load balancer** health check or **Kubernetes liveness probe** targeting
  `https://your-site.example/healthz`.
- An **uptime checker** (Pingdom, StatusCake, …) polling the same URL.

The endpoint returns a failing HTTP status when at least one Monitoring sensor is
failing, so the probe can pull the instance out of rotation or raise an alert.

## Get the access right before deploying

The `/healthz` route uses a **custom access check** rather than a Drupal
permission — the right call, because the caller is a machine with no session, and
a permission check would either fail or force the probe to authenticate.

Review what that access check allows in your deployment, because the two failure
modes are opposite and both bad:

- An endpoint that **requires authentication** makes the probe always report
  unhealthy.
- An endpoint **open to the whole internet** tells anyone who asks whether your
  site's internals are degraded — useful reconnaissance for an attacker.

The usual arrangement is to **restrict `/healthz` at the network layer** to your
probing infrastructure (load balancer, cluster network, monitoring service IPs),
and to be explicit in your deployment configuration about who can reach it. Serve
it over HTTPS.
