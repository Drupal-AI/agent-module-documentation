# Sprinklr — manual setup guide

**Sprinklr** (`sprinklr`) adds the Sprinklr chatbot to your Drupal site. Sprinklr
is a customer‑experience platform, and this module places its chat widget on your
pages so visitors can talk to your Sprinklr‑powered bot or agent. You connect it
with the **App Id** provided by Sprinklr, and you can choose to show the chatbot
only on specific pages and content types rather than everywhere.

Because the widget is a third‑party integration, there is a little to be aware of.
It loads **Sprinklr's own JavaScript**, which runs in your site's origin — so you
are extending trust to the vendor's script — and the chat and visitor data is
handled by **Sprinklr**, which is a privacy and consent consideration you should
account for. The Sprinklr App Id / API key is configuration you provide; handle it
as you would any such value. The module itself has no access‑control role. It sits
in the *Web services* package and runs on Drupal 9, 10 and 11.

The chatbot does nothing until you supply the App Id and choose where it should
appear, so this module needs configuration before it is useful.

This guide is written for a **human** setting the module up through the admin UI.
If you want terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install and enable the module.
2. [Configuration](configuration/index.md) — enter your Sprinklr App Id and choose
   where the chatbot appears.

## How to use it

Once you have entered your App Id and picked the pages/content types where it
should show, the Sprinklr chat widget appears on those pages for visitors to use.
