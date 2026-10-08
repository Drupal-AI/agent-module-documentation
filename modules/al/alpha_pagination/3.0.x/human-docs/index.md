# Alpha Pagination — manual setup guide

**Alpha Pagination** (`alpha_pagination`) adds an alphabetic (A–Z) paginator to
a View. Instead of the usual numbered "1, 2, 3, next" pager, your visitors get a
row of letters they can click to jump straight to the items that start with that
letter — ideal for a glossary, a staff directory, or any long, title-sorted
listing.

The paginator is placed in the **global area** of a View (the header or footer
region that spans the whole listing), and you tell it which field supplies the
first letter to group by. From there it renders the A–Z links automatically. It
only changes navigation — the items shown still respect the View's own access and
filters, so the module has no effect on who can see what.

It depends on core's **Views** module and ships one optional submodule,
**Alpha Pagination Sample View** (`alpha_pagination_sample_view`), which installs
a ready-made example View you can look at to see how the pieces fit together.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer,
   enable it, and optionally turn on the sample View.

## How to use it

Alpha Pagination has no central settings page. You add it to an individual View:

1. Edit (or create) a View at **Structure → Views** that lists the content you
   want to paginate — for example a directory of people sorted by last name.
2. In the View's **Header** or **Footer** section, click **Add** and choose the
   **Global: Alpha pagination** area handler.
3. Configure the handler: point it at the source field that supplies the first
   letter to group by, and save.
4. The A–Z links now appear above (or below) the listing, and clicking a letter
   filters the View down to items beginning with it.

If you enabled the **Alpha Pagination Sample View** submodule, browse to that
example View first to see a working configuration you can copy.
