# Pirate filter — manual setup guide

**Pirate filter** (`pirate`) is a fun, novelty **text-format filter** that translates
ordinary English into pirate speak — turning appropriate words and phrases into
pirate lingo ("Avast ye scurvy dogs!"). It was created with **International Talk Like
a Pirate Day** (September 19th) in mind, and it is based on Dougal Campbell's Pirate
filter from his Text Suite plugin suite for WordPress. Yarr!

Because it works as a text filter, it plugs into Drupal's normal text-format pipeline:
you enable it on whichever text format(s) you want, and text run through that format
is rewritten on output. That makes it easy to switch on for a day — apply it to a
format your content uses — and switch off again afterwards.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

There is **no dedicated settings page** — the filter is turned on and ordered per
text format, described below.

## How to use it

The filter is configured on your text formats, not on a module settings page:

1. Go to **Configuration → Content authoring → Text formats and editors**
   (`/admin/config/content/formats`).
2. Choose the text format you want to piratify (for example *Basic HTML* or a
   dedicated format) and click **Configure**.
3. In the **Enabled filters** list, tick the **Pirate** filter.
4. Under **Filter processing order**, place the Pirate filter where it makes sense
   relative to your other filters — generally after filters that produce the final
   text but in a position that doesn't interfere with HTML handling.
5. Click **Save configuration**.

Any content rendered through that text format will now come out in pirate speak. To
stop the effect (for example the day after Talk Like a Pirate Day), return to the
format and untick the filter. If you want the effect on some content but not all,
apply the filter to a separate text format and use that format only where you want the
pirate treatment.
