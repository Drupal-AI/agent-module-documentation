# TMGMT for Layout Builder Asymmetric Block — manual setup guide

**TMGMT for Layout Builder Asymmetric Block** (`tmgmt_asymmetric_block`) lets you
translate the inline blocks you place in Layout Builder through the
[Translation Management Tool](https://www.drupal.org/project/tmgmt) (TMGMT)
workflow — and it does so by creating a **new, separate block for each
translation** rather than translating one shared block in place.

That "new block per translation" approach is the whole point. It means each
language gets its own (asymmetric) block, so translated layouts can diverge
structurally from the source instead of being locked to the same set of blocks.
Practically, it also sidesteps the patches that other approaches need: it works
without the TMGMT inline-translation patch and without the core Layout Builder
translation patch, because a fresh block is created for each translation.

Because translating a block routes its content through TMGMT, the block content
may be **sent to whichever translation provider you have configured** in TMGMT —
an external machine-translation or human-translation service, depending on your
setup. Keep that data-handling reality in mind for sensitive content, and store
any provider credentials as secrets. The module itself does not add any access
control of its own; it relies on TMGMT and Layout Builder.

There is no dedicated settings form for this module — it slots into the existing
TMGMT translation workflow and the actual configuration you care about (which
translation provider to use, credentials, languages) lives in TMGMT. It depends on
TMGMT, core Block, Layout Builder Asymmetric Translation (`layout_builder_at`) and
Entity Reference Revisions, and supports Drupal 9, 10, and 11.

This guide is written for a **human** setting the module up by hand. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, pull in TMGMT and
   Layout Builder Asymmetric Translation, and enable the module.

## How to use it

Once enabled, translate Layout Builder blocks through the normal TMGMT flow. Rather
than translating a block in place, the module creates a new block for each target
language, so each language's layout can hold its own version of the block. Set up
your translation provider, languages, and credentials in TMGMT itself; this module
simply makes asymmetric per-language blocks the result of that translation.
