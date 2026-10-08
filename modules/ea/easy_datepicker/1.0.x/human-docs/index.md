# Easy Datepicker — manual setup guide

**Easy Datepicker** (`easy_datepicker`) is a lightweight, **dependency‑free** date
picker for Drupal that fixes one specific, common annoyance: picking a date that's
far in the past (or future) with the native HTML5 date input is painful. Choosing a
birthdate from decades ago means scrolling a tiny calendar back a month at a time,
or wrestling the browser's year spinner. Easy Datepicker replaces that with a
calendar you can drill straight from **days → months → years**, paging **12 years at
a time** — so reaching 1957 is a couple of clicks, not sixty. You can also just
**type** the date straight in (e.g. `08082026`) and it auto‑formats as you go.

It's deliberately self‑contained: **no jQuery, no jQuery UI, no external library** —
a single small JavaScript file that progressively enhances a plain text field and
degrades gracefully to a normal text input if JavaScript is unavailable. It's built
to be **WCAG 2.1 AA accessible** (proper contrast, ARIA state, a live region
announcing changes, and arrow‑key navigation in the calendar), and it's themeable
through CSS custom properties so you don't have to override its stylesheet directly.
Submitted values are always stored as `Y-m-d` regardless of the display format, so
CSV exports and conditional logic keep working. It runs on Drupal 10.2+ and 11 with
no dependencies.

There are **three ways to use it**: as a Form API element (`#type =>
'easy_datepicker'`) in any custom form; on a **Webform** "Text field" by adding the
CSS class `js-easy-datepicker` to it (Webform's own Date element is left completely
untouched); or via a public API (`easy_datepicker_attach()`) and an options‑alter
hook for developers. A demo page at `/easy-datepicker/demo` lets you try the widget
immediately. It also has a **site‑wide settings form** for default behaviour, which
individual fields can override.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — set the site‑wide date defaults, field
   by field.

## Where it lives in the admin menu

Site‑wide defaults live at **Configuration → Content authoring → Easy Datepicker**
(`/admin/config/content/easy-datepicker`), behind the **Administer easy_datepicker
settings** permission. To try the widget straight away, visit
`/easy-datepicker/demo`.
