# IntlDate — manual setup guide

**IntlDate** (`intl_date`) formats dates the way each language actually writes
them, using PHP's **intl** extension (ICU) rather than the fixed `date()` patterns
Drupal core uses. Core's date formats are strings like `d/m/Y` that produce the
same shape in every language — fine for one locale, but wrong for a multilingual
site where "March 5, 2026", "5 mars 2026" and "2026年3月5日" are all the correct
rendering of the same moment, and no single pattern produces them all. ICU encodes
those per‑locale rules — month names, ordering, even non‑Gregorian calendars — and
IntlDate brings them to Drupal.

It gives you three things: an **`intl_date_format` configuration entity** with a
full admin UI, so you can define named, reusable date patterns; a **field
formatter** so date fields render with an ICU format; and a **Twig function** so
templates can format dates directly. Because the formats are config entities, they
export and deploy exactly like core's date formats.

One requirement is worth checking before you commit to it: IntlDate needs the PHP
**`ext-intl`** extension, which is not enabled on every PHP install, plus PHP 8.0
or newer. Where it earns its place is precisely the multilingual case — on a
single‑language site, core's date formats are usually simpler and sufficient.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — check `ext-intl`, install with Composer,
   and enable it.
2. [Configuration](configuration/index.md) — create ICU date formats and apply
   them.

## Where it lives in the admin menu

The date‑format admin UI is at **Configuration → Regional and language → IntlDate**
(`/admin/config/regional/intl-date-time`). All its routes are gated by the
**Administer site configuration** permission. See
[Configuration](configuration/index.md).
