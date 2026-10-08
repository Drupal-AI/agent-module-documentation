# Structured Data Generator — manual setup guide

**Structured Data Generator** (`structured_data_generator`) adds JSON-LD
Schema.org structured data to your pages, which helps search engines understand
your content and can make it eligible for rich results (such as breadcrumb trails
in search listings). It works through an extensible plugin system: each
"generator" plugin returns a piece of structured data, and the module emits each
one into the page as a `<script type="application/ld+json">` element in the head.

The problem it solves is producing valid, machine-readable structured data without
hand-editing templates. Out of the box it ships one generator, `breadcrumb_sdg`,
which turns your site's breadcrumb trail into a Schema.org `BreadcrumbList` — and
it is enabled by default, so the module does something useful the moment you turn
it on. Beyond that, a developer can add generators for other schema types
(Organization, Article, Product, FAQPage, and so on) by writing a small plugin
class, and you can turn individual generators on or off from the settings form.

The module has no module dependencies but does require **PHP 8.2** and pulls in the
`spatie/schema-org` library (via Composer), which provides a fluent builder for
constructing Schema.org types. Its only route is the admin settings form, and it
has no anonymous or content-changing endpoints.

This guide is written for a **human** working through the admin UI. If you are an
AI coding agent, read the sibling [`agent/`](../agent/start.md) docs instead — they
include an example generator plugin.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.
2. [Configuration](configuration/index.md) — enable or disable individual
   generator plugins.

## Where it lives in the admin menu

The settings form is at **Configuration → Development → Structured Data
Generator** (`/admin/config/development/structured_data_generator`), gated by the
**Administer structured_data_generator** permission.

## How to use it

Enable the module and the built-in breadcrumb generator starts emitting a
`BreadcrumbList` on pages that have a breadcrumb trail. You can confirm the output
with Google's Rich Results Test. To add your own structured data, a developer
writes a generator plugin (see the sibling
[`agent/extend/plugins.md`](../agent/extend/plugins.md) doc for a code example);
each new plugin then appears on the settings form where you can enable or disable
it.
