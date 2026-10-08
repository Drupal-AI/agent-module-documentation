# SharpSpring Webforms — manual setup guide

**SharpSpring Webforms** (`sharpspring_webforms`) adds SharpSpring tracking to the
specific Webforms you choose. When a visitor submits one of the selected forms, the
submission is tracked and linked in SharpSpring, associating that form activity with
your SharpSpring leads. It is a focused companion to the base **SharpSpring** module:
where SharpSpring adds tracking to every page, this module ties chosen webform
submissions into that same tracking.

It depends on both the **Webform** module and the base **SharpSpring** module, and it
provides its own permission. It sits in the SharpSpring package and supports Drupal 9,
10, and 11. There are no submodules.

You use it by selecting which webforms should be tracked — only the forms you pick
feed their submissions into SharpSpring. Beyond that permission, the module has no
access-control role of its own.

As with the base SharpSpring integration, this is a privacy/consent consideration:
form data flows to a third-party marketing platform. Disclose the data flow, gate it
behind your consent mechanism where required (GDPR, CCPA, and similar), and be mindful
of any personal data your forms collect before it is sent to SharpSpring.

This guide is written for a **human** setting the module up. If you want terse,
token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module and its dependencies.

## How to use it

Once enabled (alongside its Webform and SharpSpring dependencies), choose which
webforms should be tracked in SharpSpring. Submissions of those selected forms are
then linked to SharpSpring leads. Make sure the base SharpSpring module is configured
with your account first, and honor visitor consent for the data being sent.
