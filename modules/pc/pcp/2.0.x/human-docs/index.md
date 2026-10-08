# Profile Complete Percentage — manual setup guide

**Profile Complete Percentage** (`pcp`) shows a user how complete their profile is,
as a percentage, and nudges them to fill in the rest. It is an add-on to Drupal's
profile fields: an administrator chooses which fields **count** toward completeness,
and the module provides a **block** that displays the current logged-in user's
completion percentage. As the user fills out more of the chosen fields, the number
climbs — and a "next tip" link points them straight at the exact field that will
raise their score, so finishing the profile feels like completing a task rather than
facing a page of empty boxes.

Sites usually want this data for two different reasons, and it helps to keep them
separate. **For the user**, the percentage is a *prompt* — a friendly push toward
adding a photo, a bio, or their interests. **For the organisation**, it is a
*metric* — how many members have supplied the information the site was built around,
which tells you whether a directory, a matching feature, or an email segmentation
will actually work.

Three things are worth keeping in mind when you configure it, because they are
genuine judgement calls:

- **What counts as "complete" is a value judgement you encode as configuration.**
  If you include *every* field, 100% becomes unreachable and the bar loses meaning.
  Choose the fields that genuinely matter — a shorter list than the profile has.
- **A completion bar creates pressure to fill fields.** Asking for a date of birth,
  a phone number, or a photo through the bar can extract data a user might otherwise
  decline. That is fine when the fields are truly needed and a dark pattern when
  they are not.
- **The percentage is derived data about a person.** Showing one member's
  completion score to others (say, in a directory) reveals something they did not
  choose to publish, so be thoughtful about where you display it.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable it.
2. [Configuration](configuration/index.md) — choose which fields count toward
   completeness, then place the block.

## Where it lives in the admin menu

The settings form lives under **Configuration** (route `pcp.pcp`). That is where you
select which profile fields count toward the 100% total. The completion percentage
itself is shown through a **block** you place via **Structure → Block layout**.
