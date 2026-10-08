# Stenographer — manual setup guide

**Stenographer** (`stenographer`) is a flexible, developer-oriented logging,
auditing, and reporting engine. You declare "recorders" in YAML that listen for
**triggers** (something happening on the site), capture the **data** you want, and
route the resulting event to a **storage** backend. It is named after the
courtroom stenographer who documents proceedings — the idea being that it quietly
records what happens on your Drupal system.

The problem it solves is capturing an audit trail without hard-coding logging all
over your codebase. Instead of scattering log calls, you describe — declaratively —
what should be recorded (entity create/update/delete, form submissions, exceptions,
or an arbitrary hook firing), what payload to capture, and where it should go.
That makes it well suited to security and compliance use cases such as detecting
suspicious user activity or building breach-notification trails. It ships an
`example.stenographer.yml` with commented sample recorders you can adapt.

The whole thing is extensible: triggers, capture strategies, data adapters, and
storage backends are all plugins (or tagged services), so a developer can add a
custom storage sink (say, an external log service), a new trigger type, or a new
way of shaping the captured data. The module depends on the **Toolshed** module
and supports Drupal 10.2+ and 11 (this is version 1.0.0-beta3).

> **This module has no admin UI.** It is configured entirely in code and YAML, so
> it is aimed at developers rather than site builders clicking through the admin
> menu. There is no settings form to fill in.

This guide is written for a **human** getting the module set up. If you want terse,
token-cheap references for an AI coding agent — including the plugin/extension
points — read the sibling [`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — the Composer command (which pulls in
   Toolshed) and enabling the module.

## How to use it — defining recorders

Because there is no UI, you configure Stenographer by adding a
`<your_module>.stenographer.yml` file to one of your own modules. Each recorder in
that file binds together:

- a **trigger** — one of the built-in ids `hook`, `exception`, `entity`, or `form`,
  deciding *when* an event is captured;
- a **capture strategy** and **data adapters** — deciding *what* data is recorded;
- a **storage** plugin — deciding *where* the event is written.

The quickest way to start is to copy the shipped **`example.stenographer.yml`**
(which demonstrates security/audit recorders with inline comments) into your
module, adapt the recorders to your needs, and run `drush cr` so the definitions
are discovered.

During local development you can send *every* recorder to a single storage target —
for example Drupal's watchdog log — by setting, in `settings.local.php`:

```php
$settings['stenographer.dev'] = [
  'storage' => 'drupal_watchdog',
];
```

## A note on what you capture

Stenographer is an audit tool, so think about the payloads you record: make sure a
recorder does not store sensitive data in a storage backend that is not appropriate
for it. Capture what you need for the audit trail, and no more.
