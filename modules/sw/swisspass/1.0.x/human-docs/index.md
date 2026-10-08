# SwissPass — manual setup guide

**SwissPass** (`swisspass`) adds a specialised **SwissPass Number** input element
to Drupal forms and Webforms. A SwissPass number is the identifier on the Swiss
public‑transport customer card, and this element makes collecting one reliable:
it auto‑formats the input as you type (`XXX-XXX-XXX-X`) and validates the format
both in the browser and on the server, so submissions come in clean and
consistent.

The problem it solves is data quality. Left to a plain text field, SwissPass
numbers get entered in all sorts of inconsistent ways. This element enforces the
expected pattern, gives editors a familiar formatted input, and cuts down on
errors for the people processing the submissions.

It works by adding a new element type rather than through a settings page — once
enabled, a **SwissPass Number** element becomes available when you build or edit a
Webform, and you configure it per form like any other Webform element. It depends
on the **Webform** module and needs Drupal 10.3 or above. There are no submodules.

An important data‑handling note: a SwissPass number is a **personal identifier
(PII)**. Collect it only when you genuinely need it, store and transmit it
securely, and handle it in line with your site's privacy policy. This module is a
form element for *entering* the number — it is not an authentication mechanism and
has no access‑control role. Note also that the released branch is a beta
(`1.0.0-beta5`) and the project is **not covered by Drupal's security advisory
policy**.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — add the SwissPass Number element to a
   Webform.

## How to use it

The feature surfaces as a **Webform element**. After enabling the module, edit a
Webform, add a new element, and choose **SwissPass Number** from the element type
list. See [Configuration](configuration/index.md) for the steps.
