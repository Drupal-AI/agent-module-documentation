# Page Attributes — manual setup guide

**Page Attributes** (`page_attributes`) is a small theming helper that lets you
attach custom attributes to a node so your theme can use them. In practice it
lets you set a custom **body id** or **body class**, or an **article class**, on
a per‑node basis — handy when a particular page needs its own styling hook without
you writing a preprocess function.

It adds a new area in the **Advanced** section of the node add/edit form, where an
editor types the attribute values for that node. When the page is viewed, those
values are applied to the markup, so your CSS or JavaScript can target them.
Since version 1.3 the values also support **Tokens**, so an attribute can be built
from other field or site data rather than being purely static.

It depends only on core **Node**. Because the attribute values are output as
markup, keep them in the hands of trusted editors — treat them like any other
value that ends up in your page's HTML.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

There is **no separate configuration page** for this module — you set the
attribute values directly on each node, as described below.

## How to use it

1. Install and enable the module (see [Installation](installation/index.md)).
2. Edit any node and open the **Advanced** section (the vertical tabs at the side
   of the edit form). You will find the Page Attributes area there.
3. Enter the values you want — for example a body class or id, or an article
   class. You can use Tokens to build a value from other data.
4. Save the node and view it: the values you entered now appear on the page's
   markup, ready for your theme's CSS or JS to target.
