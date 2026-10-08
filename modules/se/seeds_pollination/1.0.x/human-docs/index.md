# Seeds Pollination — manual setup guide

**Seeds Pollination** (`seeds_pollination`) provides miscellaneous enhancements
for the Seeds distribution, tying its various components together. It is a "glue"
module: a collection of small integrations and refinements that make the other
Seeds modules work smoothly as a whole.

Like other distribution glue, Seeds Pollination is written for Seeds sites and
carries the distribution's assumptions. On a site that is not built on Seeds it is
unlikely to be useful on its own — its value is in how it connects the pieces of
the distribution rather than in any standalone feature. It has no notable security
surface of its own, and no configuration screen: it simply applies its
enhancements once enabled.

This guide is written for a **human** working through the admin UI. If you want
terse references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

## How to use it

There is nothing to configure. Enable Seeds Pollination on a Seeds distribution
site and its enhancements take effect automatically. Document why it was added so
future maintainers understand its role as distribution glue.
