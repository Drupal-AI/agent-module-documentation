# Webform — manual setup guide

**Webform** (`webform`) is a powerful, comprehensive form builder for Drupal. It
lets site builders create forms, surveys, questionnaires, and contact forms from a
large library of ready-made elements — text fields, select lists, checkboxes, dates,
file uploads, multi-page wizards, and much more — without writing any code. Every
form you build is a reusable, exportable configuration entity, and every response is
stored as a submission you can review, edit, export, or route on to email and
external systems.

This guide is written for a **human** clicking through the admin UI. It walks you,
step by step and with screenshots, from installing the module to building and
publishing your first form. If you are looking for terse, token-cheap references for
an AI coding agent, read the sibling [`agent/`](../agent/start.md) docs instead.

![The Webforms management page listing the available forms with the Add webform button](images/list.png)

## Contents

1. [Installation](installation/index.md) — install the module with Composer, enable
   it, and pick the submodules you need.
2. [Configuration](configuration/index.md) — review the global Webforms settings that
   control how every form on the site behaves.
3. [Creating a webform](creating-a-webform/index.md) — add a form, build it up with
   elements, and view the submissions that come in.

## Where it lives in the admin menu

Everything in this guide sits under **Structure → Webforms**
(`/admin/structure/webform`):

- Forms list: **Structure → Webforms** (`/admin/structure/webform`)
- Add a form: `/admin/structure/webform/add`
- Global settings: **Configuration** tab (`/admin/structure/webform/config`)
