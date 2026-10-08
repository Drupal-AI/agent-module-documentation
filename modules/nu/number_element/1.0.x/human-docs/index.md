# Webform Numeric Element Validation — manual setup guide

**Webform Numeric Element Validation** (`number_element`) extends the Webform
**Textfield** element so it can accept and validate numeric input with more
flexibility than Webform's built‑in number elements offer. Core Webform's numeric
inputs give you fairly limited validation; this module adds a numeric element with
richer rules — validation for a numeric value, minimum and maximum, precision, and
leading zeros, including locale‑dependent number handling.

The problem it solves is the awkward gap that appears when a form needs a number
that does not behave like a plain HTML number input — where you care about decimal
precision, want to allow (or forbid) leading zeros, or need validation tuned to how
numbers are written in a given locale. Rather than fighting the standard element,
you reference this one and set its properties.

One practical point to know up front: **there is no UI component for this element
yet**. You add and configure it through the webform's **YAML source**, setting its
properties there. The element depends on the [Webform](https://www.drupal.org/project/webform)
module, and it works on Drupal 10 and 11.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable the
   module, and confirm Webform is present.

There is **no configuration page** for this module. The element is configured
per‑webform in YAML, described in "How to use it" below.

## Where it lives in the admin menu

The module adds no admin settings page. You use it from the webform builder at
**Structure → Webforms → *(your webform)* → Build**, and specifically from that
form's **Source (YAML)** view where you add the element and its properties.

## How to use it

1. Enable the module (see [Installation](installation/index.md)).
2. Edit the webform you want the numeric field on and open its **Source (YAML)**
   editor (Build tab → Edit → Source, depending on your Webform version).
3. Add the numeric element to the YAML and set the properties you need —
   validation for numeric value, min/max, precision, and leading zeros. Because
   the UI component is not yet available, the YAML source is where these are
   defined.
4. Save the webform and submit a test entry to confirm the validation behaves as
   expected.
