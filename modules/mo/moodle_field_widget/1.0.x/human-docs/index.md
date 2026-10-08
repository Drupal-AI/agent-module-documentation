# Moodle Field Widget — manual setup guide

**Moodle Field Widget** (`moodle_field_widget`) lets a content editor pick a
course from a connected **Moodle** LMS and store a reference to it, using a field
widget on ordinary string fields. Under the hood it connects to the Moodle API
with an admin-configured token and offers a select/autocomplete widget so editors
choose a real Moodle course instead of typing an identifier by hand — a simple
way to link Drupal content to Moodle courses.

It depends only on Drupal core's **Field** module and supports **Drupal 10 and
11**. The one thing you must set up before it works is the **Moodle API
connection**: the module reads a Moodle web-service token from its settings, and
the course-select widget then becomes available for string fields.

> **Security-advisory note:** this module is **not covered** by Drupal's security
> advisory policy, and it is minimally maintained. Evaluate it accordingly before
> using it on a production site.

The Moodle API token is a **secret** — it grants access to your Moodle
installation's web services. Store it securely (environment-backed), never commit
it to version control, and connect over HTTPS. See "Connect to Moodle" below.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

There is no dedicated configuration section in this guide — the only setup is
entering the Moodle API token, folded into "Connect to Moodle" below.

## Where it lives in the admin menu

After enabling, visit **Configuration → Web services → Moodle**
(`/admin/config/services/moodle`) to enter the Moodle API token. Once that is
set, the course-select widget is available on the **Manage form display** screen
for any string field.

## Connect to Moodle

1. In Moodle, enable web services and create a **web-service token** for a user
   with sufficient permissions (this is the standard Moodle external-services
   setup — see Moodle's own documentation).
2. In Drupal, go to `/admin/config/services/moodle` and paste the token, along
   with your Moodle site URL if the form asks for it. Because the token is a
   secret, prefer supplying it from an environment variable rather than typing it
   directly where it would end up in exported configuration. With DDEV you can
   store it with `ddev dotenv set .ddev/.env --moodle-api-token=<value>`
   (restart DDEV afterwards) and reference the environment value.
3. Save. The connection is now available to the field widget.

## How to use the widget

1. Add or edit a **string** (text) field on your content type (or other
   fieldable entity).
2. On the bundle's **Manage form display**, set that field's widget to the
   **Moodle course** widget provided by this module.
3. When editing content, the field now offers a course picker that lists courses
   from your connected Moodle site; selecting one stores the reference.
