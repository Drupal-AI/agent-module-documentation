# Public Consultations — manual setup guide

**Public Consultations** (`public_consultations`) gives your site a structured
way to run public consultations — proposals or policies that you open up for
public comment during a defined period. It ships a dedicated **Public
Consultation** content type, ties each consultation to a **Webform** for
collecting structured feedback, and adds tools for viewing and moderating the
submissions that come in.

Each consultation page has a start and end date that frame the consultation
period, a body for describing the proposal, and an attached webform that
visitors fill in to respond. Behind the scenes, submissions can be moderated:
administrators decide which responses are marked "Ready for public display", and
individual webform elements can be redacted so sensitive answers are hidden or
shown as `[REDACTED]` to people viewing the submissions.

Because it builds on **Webform** and **Pathauto**, you get robust form handling
and clean, readable URLs for each consultation out of the box. An optional demo
content submodule can create sample consultations so you can see how everything
fits together before building your own.

A word of caution: consultations collect **public submissions**, which often
include personal data and opinions. Handle that data in line with your privacy
policy, moderate incoming content (it is user‑supplied, so treat it as untrusted
and watch for spam), and be deliberate about who is allowed to view submissions.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable the
   module and its Webform/Pathauto dependencies, and optionally add demo content.
2. [Configuration](configuration/index.md) — the settings page, the content type,
   attaching webforms, redaction, moderation, and the module's permissions.

## Where it lives in the admin menu

- Create consultations at **Content → Add content → Public Consultation**.
- Configure the module at **Administration → Configuration → Content → Public
  Consultations settings**.
- The content type itself is at **Structure → Content types → Public
  Consultation**, and submissions have a dedicated *Public Consultation
  Submissions* view.

See [Configuration](configuration/index.md) for the full walkthrough.
