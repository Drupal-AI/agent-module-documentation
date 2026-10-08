# autotagger — manual setup guide

**autotagger** (`autotagger`) automates the job of tagging content with taxonomy
terms. Instead of an editor hand‑picking categories on every node, autotagger
lets you configure **actions** that assign taxonomy terms to content
automatically, based on rules.

Importantly, autotagger on its own is only the **core framework**. It provides the
plumbing for automatic tagging but not the actual "how do I decide which tag
applies" logic. That logic comes from a submodule or a custom plugin — for example
simple keyword/text matching, or an AI‑based classifier. So the base module is
something you build on rather than a finished, turn‑key feature. It depends on
core's Taxonomy module.

Because the tags it applies are derived from the content itself, treat the results
as a helpful first pass rather than a guarantee: review auto‑assigned terms for
accuracy, especially early on while you are tuning the rules. The module has no
access‑control role — it only writes taxonomy references onto content.

This guide is written for a **human** setting the module up. If you want terse,
token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

## How to use it

There is no single settings page that does everything; autotagger works by way of
Drupal's **actions** together with a tagging plugin:

1. Enable autotagger and a tagging plugin — either a submodule that supplies
   matching logic (for example a search‑in‑text keyword matcher) or a custom
   plugin you write.
2. Configure an auto‑tagging action: choose which plugin does the tagging and
   which vocabulary (or vocabularies) its terms come from.
3. Let it run when content is saved. The action assigns matching terms to the
   content automatically.
4. **Review the results.** Because tags are inferred from the content, spot‑check
   them for accuracy and adjust your rules or vocabularies as needed.
