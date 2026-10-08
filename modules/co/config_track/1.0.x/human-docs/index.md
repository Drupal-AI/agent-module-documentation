# Config Track — manual setup guide

**Config Track** (`config_track`) records changes to your site's configuration as
**revisions**, giving you a history of what changed and when — and who changed it.
Configuration in Drupal normally has no history. A view stops returning results, a
permission goes missing, a field display comes out wrong, and there is no way from
inside the site to answer "what changed and when?" On a project that keeps
configuration in version control the answer is in git; on a site where configuration
is edited directly in production — which is most sites — there is no answer at all.

Config Track keeps revisions of both config entities and simple configuration,
across every config collection, preserving the order in which changes happened. It
adds an admin UI listing recent config changes along with the user who triggered
each one, and it can show a **diff** so you can see the exact change. That turns
"what happened to this setting?" from a mystery into a lookup. The value is highest
exactly where configuration management is weakest: a site with several
administrators, no config-export discipline, and changes made straight through the
UI. It complements exported configuration rather than replacing it — it is a
*record*, not a deployment mechanism.

Two things are worth planning for before you rely on it. First, **the revision store
is sensitive.** Configuration includes things that are sensitive by nature — API
keys held in config, mail settings, access rules — and a revision store keeps every
past value of them. Read access to the history is therefore effectively read access
to every configuration value the site has ever held, so decide deliberately who may
see it. Second, **revisions grow.** Configuration changes are small but constant on
an active site, so check whether there is a pruning mechanism and what the storage
looks like after a year. This is an early **alpha** release (1.0.0-alpha4) for core
10 or 11, with no module dependencies — treat it accordingly and test before
production.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

The module presents a change-history report rather than a settings form, so there is
no configuration page — see "How to use it" below.

## How to use it

1. Enable the module (see [Installation](installation/index.md)). From then on it
   records configuration changes as they happen.
2. When you need to investigate, open the module's admin listing of recent config
   changes. Each entry shows what changed and the user who triggered it.
3. Open a change to view its diff and see exactly which values were altered — useful
   for tracing, say, a view that stopped working or a permission that went missing.
4. Restrict access to the history to trusted administrators, since it exposes every
   configuration value the site has ever held (including sensitive ones), and keep an
   eye on storage growth over time.
