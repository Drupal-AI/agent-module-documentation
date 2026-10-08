# Drupal Improvements — manual setup guide

**Drupal Improvements** (`improvements`) is a grab‑bag of small enhancements to
Drupal's usability and developer experience, bundled into a single module. Rather
than doing one thing, it collects a number of little refinements — field widgets
and formatters, Views plugins, cache contexts, and other small tweaks — that
smooth over rough edges in day‑to‑day site building and theming. It is built on the
**Druhels** helper library.

Because it is a collection of assorted improvements rather than a single feature,
what it does on your site depends on which of its pieces are relevant to you. It has
no content model or access‑control role of its own. The maintainer offers a candid
warning worth heeding: this module is **not recommended for thoughtless use** —
enable it deliberately, and understand which behaviors it changes before relying on
them in production.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it alongside its Druhels dependency.

This module is a bundle of assorted enhancements and does not center on a single
settings form, so there is no standalone configuration page to document. Its
individual improvements surface in the field, Views, and theming tools they extend.

## Where it lives in the admin menu

Drupal Improvements does not add one central admin page. Its enhancements appear in
context — for example new field widget/formatter options on **Manage form
display** / **Manage display**, and extra plugins in the Views UI — wherever the
particular improvement applies.
