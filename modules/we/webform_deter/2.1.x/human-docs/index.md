# Webform Deter — manual setup guide

**Webform Deter** (`webform_deter`) adds a client‑side safety net to your
Webform submissions. You give it a list of regular expressions that describe
"sensitive" data — Social Security numbers, credit card numbers, dates of
birth, and so on — and whenever a visitor submits a webform, the module tests
every text field against those patterns in the browser. If something looks like
sensitive data, the visitor gets a pop‑up confirmation warning them not to send
it. They can cancel and fix the field, or acknowledge the warning and proceed.

It is important to understand what this module is and is not. It is a **soft
deterrent**: all the checking happens in JavaScript, in the visitor's browser,
and the visitor is always free to click through the warning. It does not block
submissions on the server, and it does not validate or reject anything. Think of
it as a friendly "are you sure?" nudge that discourages people from accidentally
pasting a credit card number into a general‑purpose contact form — not as a hard
security control. For real enforcement, pair it with server‑side Webform
validation.

The module depends on the **Webform** module and works across every webform on
your site at once — the same set of patterns applies everywhere. Out of the box
it ships with a helpful default warning message and an *empty* pattern list, so
nothing triggers until you add at least one pattern on the settings form.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it alongside Webform.
2. [Configuration](configuration/index.md) — the settings form, the warning
   message, and how to write the detection patterns.

## Where it lives in the admin menu

Once enabled, Webform Deter adds a settings form at **Configuration → System →
Webform Deter settings** (`/admin/config/system/webform_deter/settings`). Only
users with the **Administer webform_deter** permission can open it.

## How to use it

1. Enable the module (see [Installation](installation/index.md)).
2. Open the [settings form](configuration/index.md) and add one or more regular
   expressions describing the data you want to catch (for example `\d{3}-\d{2}-\d{4}`
   for an SSN‑shaped value).
3. Optionally reword the warning message that appears in the confirmation dialog.
4. Save, then submit one of your webforms with a matching value to see the
   warning fire.
