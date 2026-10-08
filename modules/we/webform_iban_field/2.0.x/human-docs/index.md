# Webform IBAN Field — manual setup guide

**Webform IBAN Field** (`webform_iban_field`) adds a single new element to the
[Webform](https://www.drupal.org/project/webform) module: a **Webform IBAN field**
that collects a bank account number (IBAN) and validates it server-side. It lives
under Webform's "Advanced elements" category, renders as a normal text input, and
rejects anything that isn't a valid IBAN before the submission is saved.

Validation is done with Symfony's built-in IBAN constraint — the same well-tested
check Symfony uses everywhere — so the format is verified for any country the
constraint supports, entirely in PHP with no external service or API call. Because
the check runs on the server, a visitor can't slip a malformed value past it by
bypassing client-side JavaScript. The element inherits the standard text-element
properties (placeholder, min/max length, size) and supports collecting several
IBANs in one submission via Webform's multi-value option.

The module requires the Webform module (`^6.2`). It has no settings page, no
permissions, and no configuration of its own — enabling it simply makes the new
element available in the Webform builder. It also ships a small demo webform you
can use as a working example.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it alongside Webform.

## Where it lives in the admin menu

There is no admin settings page. The element appears inside the **Webform**
builder — when you edit a form's elements (**Structure → Webforms**, then a
form's *Build* tab) and click **Add element**, search for "IBAN" and pick
**Webform IBAN field** under *Advanced elements*.

## How to use it

1. Edit any webform's elements and choose **Add element → Webform IBAN field**.
2. Give it a title (e.g. "Your IBAN") and, optionally, a placeholder such as
   `NL91ABNA0417164300` to hint at the format. Mark it **required** if you need
   it, and tick **multiple** if the form should collect several IBANs at once.
3. Save. On submission, any value the IBAN check rejects (or a literal `0`) fails
   with a message like *"The value … for element … is not a valid IBAN."*, and
   the form won't save until it's corrected.

You don't have to build a form from scratch to try it: the module installs a demo
webform (`webform_iban_field`) containing one single and one multiple IBAN field.
Note that the demo form's default access lets anyone (including anonymous
visitors) submit it — treat it as a template, and lock it down or remove it on a
production site rather than leaving it public.
