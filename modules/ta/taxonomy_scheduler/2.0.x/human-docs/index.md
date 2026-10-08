# Taxonomy Scheduler — manual setup guide

**Taxonomy Scheduler** (`taxonomy_scheduler`) brings future-dated publishing to
taxonomy terms — the same idea as scheduling a node to go live later, but for terms.
You add a *"Publish on"* date-and-time field to a vocabulary, set a date on a term,
and when that time arrives a cron run flips the term from **Unpublished** to
**Published** automatically.

The problem it solves is coordinating term visibility with a timeline. Editorial teams
often want categories, campaign tags, or seasonal terms to appear at a set moment —
the launch of a promotion, the start of a season — without someone remembering to
publish them by hand. Taxonomy Scheduler manages that unpublish/publish lifecycle for
you: a cron event subscriber scans terms and queues those whose scheduled datetime is
due, and a queue worker applies the state change and clears the relevant caches.

The module needs configuration before it does anything: you choose which vocabularies
get the scheduling field, then make sure cron runs regularly so due terms actually get
published. It depends on the contributed **Hook Event Dispatcher**
(`hook_event_dispatcher`) module for its cron and presave hooks, plus core
**Taxonomy** and the core **Datetime** field. All configuration is administrator-only —
there are no public routes and no custom permissions; access is governed by the
**Administer site configuration** permission on the single settings form.

This guide is written for a **human** using the admin UI. If you are an AI coding
agent, read the sibling [`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — pick the vocabularies and confirm cron
   is running.

## Where it lives in the admin menu

The settings form is at `/admin/config/taxonomy_scheduler` (route
`taxonomy_scheduler.admin_form`), gated by the **Administer site configuration**
permission. See [Configuration](configuration/index.md) for the setup.
