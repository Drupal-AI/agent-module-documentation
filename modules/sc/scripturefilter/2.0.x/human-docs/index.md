# Scripture Filter — manual setup guide

**Scripture Filter** (`scripturefilter`) is a simple text-format filter that spots
Scripture (Bible) references in your content and turns them into clickable links to
an online Bible. Write "John 3:16" in a filtered field and it becomes a link that
opens the passage for readers — handy for faith, church or study sites where you
reference Scripture often and would rather not build every link by hand.

By default it links to the **NIV** (English) on
[biblegateway.com](https://www.biblegateway.com/), and it can also use several
other English translations from Bible Gateway, the **ESV** online Bible, and the
**NET** Bible. Because it is a text filter, it works purely on output — it rewrites
references into links when content is displayed and has no bearing on access or
stored data.

To use it you enable the filter on a **text format** (such as *Basic HTML* or *Full
HTML*) and pick which Bible it should link to. Any content created with that format
then gets its Scripture references auto-linked. The module has no other
dependencies, supports **Drupal 10 and 11**, and carries official
security-advisory coverage.

This guide is written for a **human** setting the module up through the admin UI.
If you want terse, token-cheap references for an AI coding agent, read the
sibling [`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — requirements, installing with Composer,
   and enabling the module.
2. [Configuration](configuration/index.md) — turning on the filter in a text format
   and choosing which online Bible it links to.

## Where it lives in the admin menu

Scripture Filter has no settings page of its own. You configure it as part of a text
format, under **Configuration → Content authoring → Text formats and editors**
(`/admin/config/content/formats`).
