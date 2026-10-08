# No 404 Log — manual setup guide

**No 404 Log** (`no_404_log`) keeps your logs readable by stopping "Page not
found" (404) events from being written to Drupal's log. On a public site, bots
and scanners constantly probe for WordPress endpoints, leaked-secret files, PHP
diagnostic pages, and database admin panels — every miss becomes a 404 log entry,
and those entries can bury the real errors you actually want to see. This module
suppresses that noise across every PSR-3 logging channel (Database Logging,
Syslog, Monolog, and so on).

Importantly, it is a **log-cleanup utility, not a security or access-control
tool**. It never blocks a request or changes how a 404 page is rendered or
served — if a URL matches a pattern and the resource exists, it is still served
normally. The only thing that changes is whether the 404 gets written to the
log. Because 404s can genuinely signal an attack in progress, filter narrowly
and keep the signal you rely on for security monitoring.

You can run it in two modes. **Ignore all 404 logs** silences every 404 entry
with a single checkbox. **Regex pattern filtering** suppresses only entries whose
URI matches one of your PCRE patterns (one per line), and the module ships with a
curated default set covering common bot probes. Invalid patterns are flagged when
you save and silently skipped at runtime. There is also an optional hard override
you can drop into `settings.php` for local/dev environments (see "How to use it"
below). The module has **no dependencies beyond Drupal core** and adds no content
types, fields, or blocks — it only affects logging behaviour.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

## Where it lives in the admin menu

After enabling the module, its settings live at **Administration →
Configuration → Development → No 404 Log**
(`/admin/config/development/no_404_log`).

## How to use it

1. Go to `/admin/config/development/no_404_log`.
2. Choose a mode:
   - **Ignore all 404 logs** — tick this to suppress every 404 entry
     unconditionally.
   - **Regex pattern filtering** — leave the "ignore all" box unticked and enter
     one PCRE pattern per line. Only 404s whose URI matches a pattern are
     suppressed; everything else is still logged. The form ships with sensible
     defaults for common bot probes, which you can keep, edit, or remove.
3. Save. Invalid regex patterns are reported on save and ignored at runtime.

**Optional infrastructure-level override.** To suppress *all* 404 logs before
any configuration is even loaded — handy on local development environments — add
this line to `settings.php`:

```php
$settings['no404log_enabled'] = TRUE;
```

This setting always takes priority over the admin UI.
